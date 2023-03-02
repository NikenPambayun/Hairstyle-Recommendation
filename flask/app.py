from flask import Flask, flash, render_template, url_for, request, jsonify, session, redirect
from flask_cors import CORS
from flask_mysqldb import MySQL
import MySQLdb.cursors
import datetime
from calendar import monthrange
import random
import json
import pickle
import numpy as np
import cv2

import nltk
nltk.download('wordnet')
nltk.download('punkt')
nltk.download('omw-1.4')
from nltk.tokenize import word_tokenize
from nltk.stem import WordNetLemmatizer

from keras.models import Sequential
from keras.layers import Dense, Activation, Dropout, Input, Flatten, MaxPooling2D , Conv2D, Dropout, GlobalAveragePooling2D
from keras.optimizers import SGD
import base64
import os
import re


import tensorflow as tf
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import glob
import cv2 as cv
import matplotlib.image as mpim

from werkzeug.utils import secure_filename
from PIL import Image as im
from keras.utils import load_img
from IPython.display import display, Javascript
from base64 import b64decode
from IPython.display import Image
from keras.utils import load_img, img_to_array
from keras import layers, models

from Recomendation import make_model


app = Flask(__name__)
CORS(app) #untuk client(eksternal) bisa mengakses localhost
app.secret_key = "check" 
  
app.secret_key = "secret key"
app.config['MAX_CONTENT_LENGTH'] = 2024 * 2024 #ukuran maksimal inputan gambar dalam bentuk byte
app.config['UPLOAD_EXTENSIONS']  = ['.jpg','.JPG','.PNG','.png','.jpeg','.JPEG'] #mengatur ekstensi pada gambar yang di upload
app.config['UPLOAD_PATH']        = './static/images/uploads/' #lokasi gambar yang diupload dari user/inputan
app.config['REKOMENDASI_PATH']   = './static/images/rekomendasi/' #lokasi gambar yang dihasilkan/hasil prediksi/output


  
ALLOWED_EXTENSIONS = set(['png', 'jpg', 'jpeg', 'gif'])  #filter ekstensi yang diperbolehkan untuk diinput/upload


#Database setting
app.config['MYSQL_HOST'] = 'localhost' 
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'hairstyle'

#flask connect ke database mysql 
mysql = MySQL(app) 

#MODEL IMG menyimpan code modeling dengan menggunakan fungsi make_model yang disimpan di rekomendation.py
model_gambar = make_model()

#CHATBOT
lemmatizer = WordNetLemmatizer()

with open('chatbot/intents.json') as content:
  intents = json.load(content)

words = []
classes = []
documents = []
ignore_letters = ['?', '!',',','.']

for intent in intents['intents']:
    for pattern in intent['patterns']:
        word_list = nltk.word_tokenize(pattern)
        words.extend(word_list)
        documents.append((word_list,intent['tag']))
        if intent['tag'] not in classes:
            classes.append(intent['tag'])

words = [lemmatizer.lemmatize(word) for word in words if word not in ignore_letters]
words = sorted(set(words))

classes = sorted(set(classes))

# pickle.dump(words, open('words.pkl', 'wb'))
# pickle.dump(classes, open('classes.pkl', 'wb'))

training = []
output_empty = [0] * len(classes)

for document in documents:
    bag =[]
    word_patterns = document[0]
    word_patterns = [lemmatizer.lemmatize(word.lower()) for word in word_patterns]
    for word in words:
        bag.append(1) if word in word_patterns else bag.append(0)

    output_row = list(output_empty)
    output_row[classes.index(document[1])] = 1
    training.append([bag, output_row])

random.shuffle(training)
training = np.array(training, dtype=object)

train_x = list(training[:, 0])
train_y = list(training[:, 1])

model = Sequential()
model.add(Dense(128, input_shape=(len(train_x[0]),), activation='relu')) 
model.add(Dropout(0.5))
model.add(Dense(64, activation='relu'))
model.add(Dropout(0.5))
model.add(Dense(len(train_y[0]), activation='softmax'))

sgd = SGD(lr=0.01, decay=1e-6, momentum=0.9, nesterov=True)
model.compile(loss='categorical_crossentropy', optimizer=sgd, metrics=['accuracy'])
# hist = model.fit(np.array(train_x), np.array(train_y), epochs=100, batch_size=5)

def clean_up_sentence(sentence):
    sentence_words = nltk.word_tokenize(sentence)
    sentence_words = [lemmatizer.lemmatize(word)  for word in sentence_words]
    return sentence_words

def bag_of_words(sentence):
    sentence_words= clean_up_sentence(sentence)
    bag = [0] * len(words)
    for w in sentence_words:
        for i, word in enumerate(words):
            if word == w:
                bag[i] = 1

    return np.array(bag)

def predict_class(sentence):
    bow = bag_of_words(sentence)
    res = model.predict(np.array([bow]))[0]
    ERROR_THRESHOLD = 0.25
    results = [[i,r] for i, r in enumerate(res) if r > ERROR_THRESHOLD]

    results.sort(key=lambda  x:x[1], reverse=True)
    return_list = []
    for r in results:
        return_list.append({'intent': classes[r[0]], 'probability': str(r[1])})
    return return_list


def get_response(intents_list,intents_json):
    tag= intents_list[0]['intent']
    list_of_intents =intents_json['intents']
    for i in list_of_intents:
        if i['tag'] == tag:
            result = random.choice(i['responses'])
            break
    return result
  
def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


#FLASK CODE DISINI 
@app.route("/", methods=['GET', 'POST']) #request hanya menerima get dan post

#Buat fungsi login
def login():
    if session.get('login') == True:
        return redirect(url_for('dashboard'))
        #request.method adalah method yang direquest oleh form, bisa dilihat diatribut method pada form
        #request.form adalah data yang dikirim oleh form
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
        #menyimpan form username pada variable username
        username = request.form['username']
        #menyimpan form password pada variable password
        password = request.form['password']

        #koneksi queri mysql validasi username dan password pada database
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM users WHERE username = % s AND password = % s', (username, password, ))
        
        #untuk mengambil salah satu akun yang sama pada tabel users di database
        account = cursor.fetchone() 

        #kondisi jika sukses login success jika berhasil masuk page dashboard
        # dan jika gagal pesan login fail jika gagal masuk page login
        if account != None:
            session['login'] = True
            msg = 'Login Success'
            flash(msg)
            return redirect(url_for('dashboard'))
        else:
            msg = 'Login Fail!'
            flash(msg, 'danger')
            return render_template('login.html')
    else:
        return render_template('login.html')

#@app.route untuk routing url mengambil fungsi pada dashboard()
@app.route("/dashboard", methods=['GET', 'POST'])
def dashboard():
    if session.get('login') == True:
        if request.method == 'GET':
            date = datetime.datetime.now()
            tahun = int(date.strftime("%Y"))
            bulan = int(date.strftime("%m"))
            jumlahHari = monthrange(tahun, bulan)[1]

            date = datetime.datetime.now()
            tanggal = date.strftime("%Y-%m")
            cursor = mysql.connection.cursor()
            queryHari = "SELECT DATE_FORMAT(FROM_UNIXTIME(timestamp), '%e') FROM recomendation_history WHERE DATE_FORMAT(FROM_UNIXTIME(timestamp), '%Y-%m') = '{0}' GROUP BY DATE_FORMAT(FROM_UNIXTIME(timestamp), '%e')".format(tanggal)
            cursor.execute(queryHari)
            hari = cursor.fetchall()
            queryJumlah = "SELECT COUNT(DATE_FORMAT(FROM_UNIXTIME(timestamp), '%Y-%m-%d')) FROM recomendation_history WHERE DATE_FORMAT(FROM_UNIXTIME(timestamp), '%Y-%m') = '{0}' GROUP BY DATE_FORMAT(FROM_UNIXTIME(timestamp), '%e')".format(tanggal)
            cursor.execute(queryJumlah)
            data = cursor.fetchall()

            hariList = []
            dataList = []
            for h in hari:
                hariList.append(h[0])
            
            for d in data:
                dataList.append(d[0])
            return render_template('dashboard.html', jumlahHari=jumlahHari, data=zip(hariList,dataList))
        elif request.method == 'POST' and 'filterBulan' in request.form:
            filterBulan = request.form['filterBulan']
            splited = filterBulan.split('-')
            jumlahHari = monthrange(int(splited[0]), int(splited[1]))[1]

            cursor = mysql.connection.cursor()
            queryHari = "SELECT DATE_FORMAT(FROM_UNIXTIME(timestamp), '%e') FROM recomendation_history WHERE DATE_FORMAT(FROM_UNIXTIME(timestamp), '%Y-%m') = '{0}' GROUP BY DATE_FORMAT(FROM_UNIXTIME(timestamp), '%e')".format(filterBulan)
            cursor.execute(queryHari)
            hari = cursor.fetchall()
            queryJumlah = "SELECT COUNT(DATE_FORMAT(FROM_UNIXTIME(timestamp), '%Y-%m-%d')) FROM recomendation_history WHERE DATE_FORMAT(FROM_UNIXTIME(timestamp), '%Y-%m') = '{0}' GROUP BY DATE_FORMAT(FROM_UNIXTIME(timestamp), '%e')".format(filterBulan)
            cursor.execute(queryJumlah)
            data = cursor.fetchall()

            hariList = []
            dataList = []
            for h in hari:
                hariList.append(h[0])
            
            for d in data:
                dataList.append(d[0])
            return render_template('dashboard.html', jumlahHari=jumlahHari, data=zip(hariList,dataList))
    else:
        return redirect(url_for('login'))


@app.route("/chat", methods=['GET'])
def chat_hist():
    if session.get('login') == True:
        cursor = mysql.connection.cursor()
        #query mysql mendapatan semua data yang ada di table chat_history
        #Date format untuk mengubah timestamp ke format tanggal
        #order by DESC untuk mengurutkan dari yang terakhir diinput
        cursor.execute(''' SELECT id, message, answer, DATE_FORMAT(FROM_UNIXTIME(timestamp), '%Y-%m-%d %H:%i:%s') FROM chat_history ORDER BY id DESC''')
        #ambil semua data yang didapat disimpan divariable chat
        chat = cursor.fetchall()
        cursor.close()
        #mengembalikan template chat-history.html dengan mengirimkan data chat pada variable chat
        return render_template("chat-history.html", chat=chat)
    else:
        #apabila belum login atau login session == false dilempar ke halaman login
        return redirect(url_for('login'))

#membuat routing /hairstyle
@app.route("/hairstyle", methods=['GET', 'POST'])
#membuat fungsi hairstyle_hist
def hairstyle_hist():
    if request.method == 'GET':
        #cek apakah session login == True
        if session.get('login') == True:
            date = datetime.datetime.now()
            tanggal = date.strftime("%Y-%m-%d")
            cursor = mysql.connection.cursor()
            query = "SELECT id, photo, recomendation, DATE_FORMAT(FROM_UNIXTIME(timestamp), '%Y-%m-%d %H:%i:%s') FROM recomendation_history WHERE DATE_FORMAT(FROM_UNIXTIME(timestamp), '%Y-%m-%d') = '{0}'".format(tanggal)
            #query mysql mendapatkan data dari table recomendation_history
            #DATE_FORMAT fungsi untuk mengubah timestamp ke format tanggal
            #order by desc untuk mengurutkan data sesuai dengan yang terakhir diinput
            cursor.execute(query)
            #mengambil semua data yang didapat dan disimpan pada variable recomendation
            recomendation = cursor.fetchall()
            cursor.close()
            #mengembalikan template recomendation-history.html dengan mengirimkan data yang sudah didapat pada parameter kedua
            return render_template("recomendation-history.html", recomendation=recomendation)
        else:
            #apabila session login == false dilempar ke halaman login
            return redirect(url_for('login'))
    elif request.method == 'POST' and 'filterTanggal' in request.form:
        if session.get('login') == True:
            filterTanggal = request.form['filterTanggal']
            cursor = mysql.connection.cursor()
            query = "SELECT id, photo, recomendation, DATE_FORMAT(FROM_UNIXTIME(timestamp), '%Y-%m-%d %H:%i:%s') FROM recomendation_history WHERE DATE_FORMAT(FROM_UNIXTIME(timestamp), '%Y-%m-%d') = '{0}'".format(filterTanggal)
            print(query)
            cursor.execute(query)
            recomendation = cursor.fetchall()
            cursor.close()
            return render_template("recomendation-history.html", recomendation=recomendation)
        else:
            #apabila session login == false dilempar ke halaman login
            return redirect(url_for('login'))

#membuat routing logout
@app.route('/logout')
#membuat fungsi logout
def logout():
    #session.pop mengeluarkan atau menghapus session login atau mengubah menjadi False
    session.pop('login', False)
    #melempar ke halaman login
    return redirect(url_for('login'))

#membuat routing /chatbot
@app.route("/chatbot", methods=['GET', 'POST'])
#membuat fungsi chatbot
def chatbot():  
    #apabila request.method == GET
    if request.method == 'GET':
        #mengembalikan teks test api
        return 'test api'
    #apabila request.method == POST
    else:
        #request.get_json() mengubah semua request yang dikirim menjadi format json
        #kemudian .get('message') untuk mendapatkan value dari key message disimpan pada variabel message_input
        message_input = request.get_json().get("message")
        #predict_class() prediksi inputan 
        ints = predict_class(message_input)
        #get_response() outuputnya disimpan divariabel res dalam bentuk hasil  prediksi
        res = get_response(ints, intents)
        #membuat json untuk response, masukkan resp pada key answer
        message = {"answer": res}
        #mengambil waktu sekarang menggunaskan library datetime
        curent_time = datetime.datetime.now()
        #mengubah curent_time menjadi bentuk timestamp
        timestamp = curent_time.timestamp()
        cursor = mysql.connection.cursor()
        #lakukan query insert ke database
        cursor.execute('''INSERT INTO chat_history(message, answer, timestamp) VALUES(%s,%s,%s)''',(message_input, res, timestamp))    
        mysql.connection.commit()
        cursor.close()

        #mengembalikan response json
        #jsonnify mengubah string menjadi json
        return jsonify(message) 

#membuat routing /recomendation
@app.route('/recomendation', methods=['GET', 'POST'])
#membuat fungsi recomendation
def recomendation():
    #simpan nilai default hasil_prediksi dan gambar_prediksi
    hasil_prediksi  = '(none)'
    classess = ['Diamond Face', 'Heart Face', 'Oblong Face', 'Oval Face', 'Round Face', 'Square Face', 'Triangle Face']

    # Get File Gambar yg telah diupload pengguna
    uploaded_file = request.files['file']
    
    #mendapakan waktu sekarang menggunakan library datetime
    curent_time = datetime.datetime.now()
    #mengubah curenta_time menjadi timestamp
    timestamp = curent_time.timestamp()

    #membuat variable filename isinya timstamp dirubah jadi string terus direplace misal terdapat . pada timestamp
    #filename untuk nama file yang telah diupload
    filename = str(timestamp).replace(".", "") + '.jpg'

    # Simpan Gambar
    uploaded_file.save(os.path.join(app.config['UPLOAD_PATH'], filename))
    
    #Training Model
    # predicting images
    path = os.path.join(app.config['UPLOAD_PATH'], filename)

    #load gambar yang sudah diupload dan sisesuikan ukurannya
    img = load_img(path, target_size=(224,224))

    #ubah gambar ke dalam array
    x = img_to_array(img)
    x = np.expand_dims(x, axis=0)
 
    images = np.vstack([x])

    #Prediksi gambar berdasarkan model
    classes = model_gambar.predict(images, batch_size=50)
    classes = np.argmax(classes)
  
    #Klasifikasi model
    if classes==0:
        diamond = [cv2.imread(file) for file in glob.glob(".\Dataset\Gaya_Rambut\DiamondFace\*g")]
        # print('DiamondFace')
        print(classess[classes])
    elif classes==1:
        heart = [cv2.imread(file) for file in glob.glob(".\Dataset\Gaya_Rambut\HeartFace\*g")]
        # print('HeartFace')
        print(classess[classes])
    elif classes==2:
        oblong = [cv2.imread(file) for file in glob.glob(".\Dataset\Gaya_Rambut\OblongFace\*g")]
        # print('OblongFace')
        print(classess[classes])
    elif classes==3:
        oval = [cv2.imread(file) for file in glob.glob(".\Dataset\Gaya_Rambut\OvalFace\*g")]
        # print('OvalFace')
        print(classess[classes])
    elif classes==4:
        roundF = [cv2.imread(file) for file in glob.glob(".\Dataset\Gaya_Rambut\RoundFace\*g")]
        # print('RoundFace')
        print(classess[classes])
    elif classes==5:
        square = [cv2.imread(file) for file in glob.glob(".\Dataset\Gaya_Rambut\SquareFace\*g")]
        # print('SquareFace')
        print(classess[classes])
    elif classes==6:
        triangle = [cv2.imread(file) for file in glob.glob(".\Dataset\Gaya_Rambut\TriangleFace\*g")]
        # print('TriangleFace')
        print(classess[classes])
    else:
        print('wajah tidak terdeteksi')

    #hasil prediksi disimpan 
    hasil_prediksi = classes
    wajah = classess[classes]

    # print(hasil_prediksi)
    listimage = list()
    # fig = plt.figure(figsize=(10,6))
    for i in range(0, 1*3):
        # fig.add_subplot(1, 3, i+1)
        if (hasil_prediksi == 0 ):
            # plt.imshow(diamond[i])
            data = im.fromarray(cv2.cvtColor(diamond[i], cv2.COLOR_RGB2BGR))
            resultimage = str(timestamp).replace(".", "") + str(random.randint(0, 100)) + '.png'
            listimage.append(resultimage)
            data.save(os.path.join(app.config['REKOMENDASI_PATH'], resultimage))
        elif (hasil_prediksi == 1):
            # plt.imshow(heart[i])
            data = im.fromarray(cv2.cvtColor(heart[i], cv2.COLOR_RGB2BGR))
            resultimage = str(timestamp).replace(".", "") + str(random.randint(0, 100)) + '.png'
            listimage.append(resultimage)
            data.save(os.path.join(app.config['REKOMENDASI_PATH'], resultimage))
        elif (hasil_prediksi == 2):
            # plt.imshow(oblong[i])
            data = im.fromarray(cv2.cvtColor(oblong[i], cv2.COLOR_RGB2BGR))
            resultimage = str(timestamp).replace(".", "") + str(random.randint(0, 100)) + '.png'
            listimage.append(resultimage)
            data.save(os.path.join(app.config['REKOMENDASI_PATH'], resultimage))
        elif (hasil_prediksi == 3):
            # plt.imshow(oval[i])
            data = im.fromarray(cv2.cvtColor(oval[i], cv2.COLOR_RGB2BGR))
            resultimage = str(timestamp).replace(".", "") + str(random.randint(0, 100)) + '.png'
            listimage.append(resultimage)
            data.save(os.path.join(app.config['REKOMENDASI_PATH'], resultimage))
        elif (hasil_prediksi == 4):
            # plt.imshow(roundF[i])
            data = im.fromarray(cv2.cvtColor(roundF[i], cv2.COLOR_RGB2BGR))
            resultimage = str(timestamp).replace(".", "") + str(random.randint(0, 100)) + '.png'
            listimage.append(resultimage)
            data.save(os.path.join(app.config['REKOMENDASI_PATH'], resultimage))
        elif (hasil_prediksi == 5):
            # plt.imshow(square[i])
            data = im.fromarray(cv2.cvtColor(square[i], cv2.COLOR_RGB2BGR))
            resultimage = str(timestamp).replace(".", "") + str(random.randint(0, 100)) + '.png'
            listimage.append(resultimage)
            data.save(os.path.join(app.config['REKOMENDASI_PATH'], resultimage))
        elif (hasil_prediksi == 6):
            # plt.imshow(triangle[i])
            data = im.fromarray(cv2.cvtColor(triangle[i], cv2.COLOR_RGB2BGR))
            resultimage = str(timestamp).replace(".", "") + str(random.randint(0, 100)) + '.png'
            listimage.append(resultimage)
            data.save(os.path.join(app.config['REKOMENDASI_PATH'], resultimage))

    cursor = mysql.connection.cursor()
    cursor.execute('''INSERT INTO recomendation_history (photo, recomendation, timestamp) VALUES(%s,%s,%s)''',(filename, ','.join(listimage), timestamp))  
    mysql.connection.commit()
    cursor.close()

    return jsonify({
        "Bentuk_wajah" : wajah,
        "Rekomendasi": listimage,
    })

if __name__ == "__main__":
    model.load_weights('./chatbot/chatbotmodel.h5')
    model_gambar.load_weights('./cnn_model.h5')
    app.run(host="0.0.0.0", debug=True)
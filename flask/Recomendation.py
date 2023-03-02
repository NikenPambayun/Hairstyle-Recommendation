from keras.models import Sequential
from keras import layers, models
import tensorflow as tf

def make_model():
    model_gambar = models.Sequential()
    model_gambar.add(layers.Conv2D(64, (2, 3), activation='relu', input_shape=(224 , 224, 3)))
    model_gambar.add(layers.MaxPooling2D((2, 2)))
    model_gambar.add(layers.Conv2D(32, (2, 3), activation='relu'))
    model_gambar.add(layers.MaxPooling2D((2, 2)))
    model_gambar.add(layers.Conv2D(32, (2, 3), activation='relu'))
    model_gambar.add(layers.MaxPooling2D((2)))
    model_gambar.add(layers.Flatten())
    model_gambar.add(layers.Dense(7, activation='softmax'))

    model_gambar.compile(optimizer=tf.keras.optimizers.Adam(learning_rate=0.00005), 
            loss='categorical_crossentropy', 
            metrics = ['accuracy'])
    return model_gambar
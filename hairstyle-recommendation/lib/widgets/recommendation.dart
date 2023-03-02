import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hairstyle/widgets/result.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Recomendation extends StatefulWidget {
  @override
  _RecomendationState createState() => _RecomendationState();
}

class _RecomendationState extends State<Recomendation> {
  final urlApi = 'http://192.168.116.141:5000/recomendation';

  XFile? image;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    // bentuk_wajah = "";

    setState(() {
      image = img;
    });

  }

  //show popup dialog
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: Color.fromARGB(255, 225, 210, 210),
            title: Text('Please choose media to select', textAlign: TextAlign.center),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton.icon(
                    //if user click this button, user can upload image from gallery
                    label: Text(
                      'From Gallery',
                      style: TextStyle(
                        fontSize: 20.5,
                      ),
                    ),
                    icon: Icon(Icons.photo),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 130, 86, 86),
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                  ),
                  ElevatedButton.icon(
                    //if user click this button. user can upload image from camera
                    label: Text(
                      'From Camera',
                      style: TextStyle(
                        fontSize: 20.5,
                      ),
                    ),
                    icon: Icon(Icons.camera_alt_outlined),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 130, 86, 86),
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Upload Image'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 130, 86, 86)),
      body: Container(
        color: Color.fromARGB(255, 225, 210, 210),
        padding: EdgeInsets.all(30),
        child: Container(
            child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                // Buat gambar
                image != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            //to show image, you type like this.
                            File(image!.path),
                            fit: BoxFit.cover,
                            width: 250,
                            // width: MediaQuery.of(context).size.width,
                            height: 300,
                          ),
                        ),
                      )
                    : Text(
                        "No Image",
                        style: TextStyle(fontSize: 20),
                      ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        label: Text(
                          'Upload Your Image',
                          style: TextStyle(
                            fontSize: 20.5,
                          ),
                        ),
                        icon: Icon(Icons.camera_alt_rounded),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 130, 86, 86),
                          shape: StadiumBorder(),
                        ),
                        onPressed: () => {myAlert()},
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  
                  child: ElevatedButton.icon(
                    label: Text(
                      'Recommendation',
                      style: TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                    icon: Icon(Icons.cut_sharp),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 130, 86, 86),
                      shape: StadiumBorder(),
                    ),
                    onPressed: () async {
                      final bytes = await image!.readAsBytes();
                      var request =
                          http.MultipartRequest('POST', Uri.parse(urlApi));
                      request.files.add(http.MultipartFile.fromBytes(
                          'file', bytes,
                          filename: image!.path));
                      try {

                      var duration = Duration(seconds: 2);
                        final alert = AlertDialog(
                          title: Text("Please Wait..."),
                          backgroundColor: Color.fromARGB(255, 225, 210, 210)
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext){
                          return alert;
                            }
                          );

                        var res = await request.send();
                        var response = await http.Response.fromStream(res);
                        print('${response.body}');
                        // String responsebentuk = response.body;
                        dynamic data = jsonDecode(response.body)['Bentuk_wajah'];

                        String responseimage = response.body;
                        List<dynamic> listimage =
                            jsonDecode(response.body)['Rekomendasi'];
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => Result(image: listimage, data: data)));
                      } catch (e) {
                        print(e.toString());
                      }
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => Result()))
                    },
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

class Result extends StatelessWidget {
  final List<dynamic> image;
  final dynamic data;
  const Result({Key? key, required this.image, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Result'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 130, 86, 86)),
      body: Container(
          color: Color.fromARGB(255, 225, 210, 210),
          width: double.infinity,
          padding: EdgeInsets.all(15),
          child: 
          Column(children: [
            Text("Bentuk Wajah : " + data, style: TextStyle(fontSize: 17)),
            SizedBox(width: 10),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(5),
              itemCount: image.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 200,
                  height: 200,
                  padding: EdgeInsets.all(10),
                  child:   
                  Image.network(
                      'http://192.168.116.141:5000/static/images/rekomendasi/' +
                          image[index]),
                  
                  // child: Center(child: Text('Entry ${image[index]}')),
                );
              })
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Image.memory(
          //       base64Decode(image),
          //       width: 200,
          //       height: 200,
          //     )
          //   ],
          // ),
          ]
      )
      ),
    );
  }
}

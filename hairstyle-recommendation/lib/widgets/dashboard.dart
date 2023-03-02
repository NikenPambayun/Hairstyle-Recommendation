import 'package:flutter/material.dart';
import 'package:hairstyle/widgets/chatbot.dart';
import 'package:hairstyle/widgets/recommendation.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hairstyle Recommendation',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('T.R. Barbershop',
                style: TextStyle(fontSize: 25.0)),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 130, 86, 86)),
        body: Container(
          width: 10000,
          color: Color.fromARGB(255, 225, 210, 210),
          padding: EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 450,
                  height: 450,
                  child: Image.asset(
                    'image/3.1.png',
                  ),
                ),
                SizedBox(
                  width: 400.0,
                  height: 70.0,
                  child: ElevatedButton.icon(
                    label: Text(
                      'Haircut Recommendation',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    icon: Icon(Icons.cut_sharp),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 130, 86, 86),
                      shape: StadiumBorder(),
                    ),
                    onPressed: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Recomendation(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 400.0,
                  height: 70.0,
                  child: ElevatedButton.icon(
                    label: Text(
                      'Help',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    icon: Icon(Icons.chat_bubble),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 130, 86, 86),
                      shape: StadiumBorder(),
                    ),
                    onPressed: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Chatbot(),
                        ),
                      );
                    },
                  ),
                )
              ]),
        ),
      ),
    );
  }
}

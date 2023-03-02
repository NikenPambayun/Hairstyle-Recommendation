import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Chatbot extends StatefulWidget {
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final List<Message> _msg = <Message>[];
  final TextEditingController _txtController = TextEditingController();
  void getChatbotReply(String userReply) async {
    _txtController.clear();
    var response =
        await http.post(Uri.parse("http://192.168.116.141:5000/chatbot"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'message': userReply,
            }));
    var data = jsonDecode(response.body);
    var botReply = data["answer"];
    Message msg = Message(
      text: botReply,
      name: "Bot",
      type: false,
    );
    setState(() {
      _msg.insert(0, msg);
    });
  }

  void handleSubmitted(text) async {
    if (kDebugMode) {
      print(text);
    }
    _txtController.clear();
    Message msg = Message(
      text: text,
      name: "YOU",
      type: true,
      //date: DateTime.now(),
    );
    setState(() {
      _msg.insert(0, msg);
    });
    getChatbotReply(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HairBot'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 130, 86, 86),
      ),
      backgroundColor: Colors.brown[100],
      body: Column(
        children: [
          Flexible(
              child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_, int index) => _msg[index],
            itemCount: _msg.length,
          )),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: IconTheme(
              data: IconThemeData(color: Theme.of(context).cardColor),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                //color: Colors.grey[300],
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: _txtController,
                        onSubmitted: handleSubmitted,
                        decoration: const InputDecoration.collapsed(
                            hintText: 'Send a message'),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () => handleSubmitted(_txtController.text),
                        color: Colors.brown[400],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Message extends StatelessWidget {
  final String text;
  final String name;
  final bool type;
  // final DateTime date;
  // ignore: use_key_in_widget_constructors
  const Message({
    required this.text,
    required this.name,
    required this.type,
    //  required this.date,
  });

  List<Widget> bot(context) {
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: const CircleAvatar(
          backgroundColor: Color.fromARGB(255, 130, 86, 86),
          child: 
          Icon(Icons.android, color: Colors.white)
          ),
      ),
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5.0),
            child: Text(text, style: const TextStyle(fontSize: 20.0)),
          )
        ],
      ))
    ];
  }

  List<Widget> me(context) {
    return <Widget>[
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            //color: Colors.white,
            margin: const EdgeInsets.only(top: 5.0),
            child: Text(text, style: const TextStyle(fontSize: 20.0)),
          )
        ],
      )),
      Container(
          margin: const EdgeInsets.only(left: 16.0),
          child: const CircleAvatar(
              backgroundColor: Color.fromARGB(255, 150, 100, 50),
              child: 
              Icon(Icons.person, color: Colors.white)
          ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: type ? me(context) : bot(context),
        ));
  }
}

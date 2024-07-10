import 'dart:convert';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Nutrition extends StatefulWidget {
  const Nutrition({Key? key}) : super(key: key);

  @override
  State<Nutrition> createState() => _NutritionState();
}

class _NutritionState extends State<Nutrition> {
  ChatUser myself = ChatUser(id: '1', firstName: 'Player');
  ChatUser bot = ChatUser(id: '2', firstName: 'ChatBot');

  List<ChatMessage> allMessages = [];

  final oururl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyCE7a_fMNXGD-CYZEgj1m4AWp3MvKLQu1k';

  final header = {'Content-Type': 'application/json'};

  getdata(ChatMessage m) async {
    allMessages.insert(0, m);
    setState(() {});

    var data = {
      "contents": [
        {
          "parts": [
            {"text": m.text}
          ]
        }
      ]
    };

    await http
        .post(Uri.parse(oururl), headers: header, body: jsonEncode(data))
        .then((value) {
      if (value.statusCode == 200) {
        var result = jsonDecode(value.body);
        print(result['candidates'][0]['content']['parts'][0]['text']);

        ChatMessage m1 = ChatMessage(
          text: result['candidates'][0]['content']['parts'][0]['text'],
          user: bot,
          createdAt: DateTime.now(),
        );

        allMessages.insert(0, m1);
        setState(() {});
      } else {
        print("error occurred");
      }
    }).catchError((e) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 165, 152, 152),
      appBar: AppBar(
        title: const Text(
          'Feel Free To Ask',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 0, 2, 39),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: DashChat(
        currentUser: myself,
        onSend: (ChatMessage m) {
          getdata(m);
        },
        messages: allMessages,
      ),
    );
  }
}

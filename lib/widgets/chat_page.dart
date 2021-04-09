import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thanhmaihskchatbot/utils/bot_dialog.dart';

import 'chat_message.dart';

class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessage> _message = [];
  final TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  reverse: true,
                  itemBuilder: (_, int index) => _message[index],
                  itemCount: _message.length,
                )),
            Divider(
              height: 1.0,
            ),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            )
          ],
        ));
  }

  Widget _buildTextComposer() {
    return IconTheme(
        data: IconThemeData(color: Theme.of(context).accentColor),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Flexible(
                child: TextField(
                  controller: _textController,
                  onSubmitted: _handleSubmitted,
                  decoration:
                  InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text),
                ),
              )
            ],
          ),
        ));
  }

  void _handleSubmitted(String message) {
    _textController.clear();

    if (message.isEmpty) return;

    ChatMessage messageWidget = ChatMessage(
      text: message,
      name: "You",
      type: true,
    );

    setState(() {
      _message.insert(0, messageWidget);
    });

    _response(message);
  }

  void _response(query) async {
    _textController.clear();

    String ans = await answer(query);

    print(ans);

    ChatMessage messageWidget = ChatMessage(
      text: ans,
      name: "Bot",
      type: false,
    );

    setState(() {
      _message.insert(0, messageWidget);
    });
  }
}

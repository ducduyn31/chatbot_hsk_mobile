import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thanhmaihskchatbot/utils/bot_dialog.dart';
import 'package:thanhmaihskchatbot/widgets/image_button.dart';

import '../widgets/chat_message.dart';

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
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.contain,
            height: 52,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          ImageButton(image: 'assets/options_icon.png')
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/background.png'),
                    fit: BoxFit.cover),
              ),
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => _message[index],
                itemCount: _message.length,
              ),
            ),
          ),
          Divider(
            height: 1.0,
          ),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          )
        ],
      ),
    );
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
                child: ImageButton(
                  image: 'assets/send_icon.png',
                  onPressed: () => _handleSubmitted(_textController.text),
                )
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

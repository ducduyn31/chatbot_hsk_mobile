import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holding_gesture/holding_gesture.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:thanhmaihskchatbot/utils/bot_dialog.dart';
import 'package:thanhmaihskchatbot/widgets/image_button.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessage> _message = [];
  final TextEditingController _textController = new TextEditingController();

  stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

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
          ImageButton(
            image: 'assets/options_icon.png',
            size: Size.square(40),
          )
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
              // Flexible(
              //   child: TextField(
              //     controller: _textController,
              //     onSubmitted: _handleSubmitted,
              //     decoration:
              //         InputDecoration.collapsed(hintText: "Send a message"),
              //   ),
              // ),
              HoldDetector(
                onHold: _listen,
                onCancel: _stopListen,
                child: ImageButton(
                  image: 'assets/button.png',
                  size: const Size(250, 40),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 4.0),
              //   child: ImageButton(
              //     image: 'assets/send_icon.png',
              //     onPressed: () => _handleSubmitted(_textController.text),
              //     size: Size.square(40),
              //   ),
              // )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ));
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => log('onStatus: $val'),
        onError: (val) => log('onError: $val'),
        options: [],
      );

      if (available) {
        setState(() {
          _isListening = true;
        });

        _speech.listen(
          onResult: (val) {
            _handleSubmitted(val.recognizedWords);
          },
          listenMode: ListenMode.confirmation,
          partialResults: false,
          localeId: 'zh-cn',
        );
      }
    }
  }

  void _stopListen() async {
    if (_isListening) {
      setState(() {
        _isListening = false;
      });
      _speech.stop();
    }
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

    String ans = await Future.any([
      answer(query),
      Future.delayed(const Duration(seconds: 5)).then((value) => '> . <')
    ]);

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

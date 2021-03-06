import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.name, this.type});

  final String text;
  final String name;
  final bool type;

  List<Widget> otherMessage(context) {
    return [
      Container(
        margin: EdgeInsets.only(right: 16.0),
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/avatar_icon.png'),
        ),
      ),
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            this.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Bubble(
              child: Text(text.replaceAll('{br}', '\n')),
            ),
          )
        ],
      ))
    ];
  }

  List<Widget> myMessage(context) {
    return [
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            this.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Bubble(
              child: Text(text),
            ),
          )
        ],
      )),
      Container(
        margin: EdgeInsets.only(left: 16.0),
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/thanhmai.jpg'),
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}

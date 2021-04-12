import 'package:flutter/cupertino.dart';

class SimpleResponse {
  final String content;

  SimpleResponse({@required this.content});

  factory SimpleResponse.fromJson(Map<String, dynamic> json) {
    return SimpleResponse(content: json['content']);
  }
}

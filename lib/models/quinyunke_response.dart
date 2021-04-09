import 'package:flutter/cupertino.dart';

class QuinyunkeResponse {
  final int result;
  final String content;

  QuinyunkeResponse({@required this.result, @required this.content});

  factory QuinyunkeResponse.fromJson(Map<String, dynamic> json) {
    return QuinyunkeResponse(result: json['result'], content: json['content']);
  }
}

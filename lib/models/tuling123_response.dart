import 'package:flutter/cupertino.dart';

class Tuling123Response {
  final dynamic emotion;
  final dynamic intent;
  final List<dynamic> results;

  Tuling123Response(
      {@required this.emotion, @required this.intent, @required this.results});

  factory Tuling123Response.fromJson(Map<String, dynamic> json) {
    return Tuling123Response(
      emotion: json['result'],
      intent: json['content'],
      results: json['results'],
    );
  }
}

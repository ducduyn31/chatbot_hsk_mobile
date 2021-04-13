import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thanhmaihskchatbot/models/quinyunke_response.dart';
import 'package:thanhmaihskchatbot/models/response.dart';
import 'package:thanhmaihskchatbot/models/tuling123_response.dart';

Future<String> answerQuingyunke(String message) async {
  Map<String, dynamic> queries = {
    'key': 'free',
    'appid': '0',
    'msg': message,
  };
  final response =
      await http.get(Uri.https('api.qingyunke.com', 'api.php', queries));

  if (response.statusCode == 200) {
    return QuinyunkeResponse.fromJson(jsonDecode(response.body)).content;
  } else {
    throw Exception('I am confused!');
  }
}

Future<String> answerTuling123(String message) async {
  final response = await http.post(
    Uri.https('openapi.tuling123.com', 'openapi/api/v2'),
    body: jsonEncode(
      {
        'reqType': 0,
        'perception': {
          'inputText': {
            'text': message,
          },
        },
        'userInfo': {
          'apiKey': 'ed8cba8088a9460fa08ccf259c502e53',
          'userId': '313644',
        }
      },
    ),
  );

  if (response.statusCode == 200) {
    return Tuling123Response.fromJson(jsonDecode(response.body)).results[0]
        ['values']['text'];
  } else {
    throw Exception('I am confused!');
  }
}

Future<String> answer(String message) async {
  Map<String, dynamic> queries = {
    'message': message,
  };

  final response =
      await http.get(Uri.https('demo.techqila.com:8243', '', queries));

  if (response.statusCode == 200) {
    return SimpleResponse.fromJson(jsonDecode(response.body)).content;
  } else {
    throw Exception('I am confused!');
  }
}

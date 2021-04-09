import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thanhmaihskchatbot/models/quinyunke_response.dart';

Future<String> answer(String message) async {
  Map<String, dynamic> queries = {
    'key': 'free',
    'appid': '0',
    'msg': message,
  };
  final response = await http.get(Uri.https('api.qingyunke.com', 'api.php', queries));

  if (response.statusCode == 200) {
    return QuinyunkeResponse.fromJson(jsonDecode(response.body)).content;
  } else {
    throw Exception('I am confused!');
  }
}

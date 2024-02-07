// ignore_for_file: empty_catches

import 'package:contact_book/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> postContact(String id, String name, String company, String title,
    String phone, String email, String group) async {
  try {
    final url = Uri.parse(
        'https://stage.app.studiovity.com/api/v1/contactbook/createNupdate');
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    final body = {
      "name": name,
      "title": title,
      "company": company,
      "mobile": phone,
      "alternateMobile": "",
      "email": email,
      "image": "",
      "groupCategory": group,
      "notes": ""
    };

    final request = http.Request('POST', url)
      ..headers.addAll(headers)
      ..body = jsonEncode(body);

     await http.Client().send(request);
  } catch (error) {}
}

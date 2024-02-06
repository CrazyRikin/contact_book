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

    final response = await http.Client().send(request);

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(
          'Request failed with status: ${response.statusCode}, ${response.reasonPhrase}');
      print('Response body: ${await response.stream.bytesToString()}');
    }
  } catch (error, stackTrace) {
    print('Error making the request: $error');
    print('Stack trace: $stackTrace');
  }
}

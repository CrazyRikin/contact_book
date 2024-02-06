import 'package:contact_book/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void deleteContactApi(String id) async {
  var headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json'
  };

  var request = http.Request('DELETE',
      Uri.parse('https://stage.app.studiovity.com/api/v1/contactbook/delete'));

  request.body = jsonEncode({
    "contactIds": [id]
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  print(response.statusCode);
  print(await response.stream.bytesToString());
}

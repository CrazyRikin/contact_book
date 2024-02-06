import 'dart:convert';
import 'dart:io';
import 'package:contact_book/utils/constants.dart';
import 'package:http/http.dart' as http;

Future<_FetchList> makeCall() async {
  final response = await http.get(
    Uri.parse('https://stage.app.studiovity.com/api/v1/contactbook/get'),
    headers: {
      HttpHeaders.authorizationHeader: 'bearer $token',
    },
  );
  final responseJson = jsonDecode(response.body) as Map<String, dynamic>;

  return _FetchList.fromJson(responseJson);
}

class _FetchList {
  List<_Contacts>? contacts;

  _FetchList(contacts);

  _FetchList.fromJson(Map<String, dynamic> json) {
    if (json['contacts'] != null) {
      contacts = <_Contacts>[];
      json['contacts'].forEach((v) {
        contacts!.add(_Contacts.fromJson(v));
      });
    }
  }
}

class _Contacts {
  String? groupCategory;
  String? sId;
  String? name;
  String? company;
  String? title;
  String? mobile;
  String? email;
  String? image;
  String? userId;
  int? iV;
  String? alternateMobile;
  String? notes;

  _Contacts(groupCategory, sId, name, company, title, mobile, email, image,
      userId, iV, alternateMobile, notes);

  _Contacts.fromJson(Map<String, dynamic> json) {
    groupCategory = json['groupCategory'];
    sId = json['_id'];
    name = json['name'];
    company = json['company'];
    title = json['title'];
    mobile = json['mobile'];
    email = json['email'];
    image = json['image'];
    userId = json['userId'];
    iV = json['__v'];
    alternateMobile = json['alternateMobile'];
    notes = json['notes'];
  }
}

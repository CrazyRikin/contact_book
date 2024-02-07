import 'dart:convert';
import 'dart:io';
import 'package:contact_book/utils/constants.dart';
import 'package:http/http.dart' as http;

Future<FetchList> makeCall() async {
  final response = await http.get(
    Uri.parse('https://stage.app.studiovity.com/api/v1/contactbook/get'),
    headers: {
      HttpHeaders.authorizationHeader: 'bearer $token',
    },
  );
  final responseJson = jsonDecode(response.body) as Map<String, dynamic>;

  return FetchList.fromJson(responseJson);
}

class FetchList {
  List<ContactsAPI>? contacts;

  FetchList(contacts);

  FetchList.fromJson(Map<String, dynamic> json) {
    if (json['contacts'] != null) {
      contacts = <ContactsAPI>[];
      json['contacts'].forEach((v) {
        contacts!.add(ContactsAPI.fromJson(v));
      });
    }
  }
}

class ContactsAPI {
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

  ContactsAPI(groupCategory, sId, name, company, title, mobile, email, image,
      userId, iV, alternateMobile, notes);

  ContactsAPI.fromJson(Map<String, dynamic> json) {
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

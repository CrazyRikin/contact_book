import 'package:contact_book/services/model/contact_model.dart';
import 'package:flutter/material.dart';


class ContactListProvider extends ChangeNotifier {
  List<Contacts> registeredContacts = [
    Contacts(
        name: 'rikin',
        company: 'suas',
        phone: 999999999,
        title: 'flutter dev',
        email: 'xyz@gmail.com',
        group: Group.tech),
  ];
  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}

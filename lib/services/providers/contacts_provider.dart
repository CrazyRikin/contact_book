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

  void addContact(String name, String company, int phone, String title,
      String email, Group group) {
    registeredContacts.add(Contacts(
        name: name,
        company: company,
        title: title,
        phone: phone,
        email: email,
        group: group));
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}

import 'package:contact_book/services/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';

List<String> saveOptions = ["Save To Device", "Save To Google"];

class ContactListProvider extends ChangeNotifier {
  FullContact fetchedContact = FullContact([], [], [], [],
      StructuredName('', '', '', ''), null, null, null, null, [], []);

  Group defaultGroup = Group.work;
  
  String defaultSaveOption = 'Save To Google';

  List<Contacts> registeredContacts = [
    Contacts(
        name: 'rikin',
        company: 'suas',
        phone: '999999999',
        title: 'flutter dev',
        email: 'xyz@gmail.com',
        group: Group.tech),
  ];

  void addContact(String name, String? company, String phone, String? title,
      String? email, Group? group) {
    registeredContacts.add(Contacts(
        name: name,
        company: company!,
        title: title!,
        phone: phone,
        email: email!,
        group: group!));
    notifyListeners();
  }

  void changeSaveOption(String value) {
    defaultSaveOption = value;
    notifyListeners();
  }

  void changeGroup(Group value) {
    defaultGroup = value;
    notifyListeners();
  }

  void updateFetchContact(FullContact value) {
    fetchedContact = value;
    notifyListeners();
  }
}

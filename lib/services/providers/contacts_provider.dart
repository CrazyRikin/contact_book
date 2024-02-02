import 'dart:io';
import 'package:contact_book/services/model/contact_model.dart';
import 'package:csv/csv.dart';
import 'package:external_path/external_path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';

List<String> saveOptions = ["Save To Device", "Save To Google"];

class ContactListProvider extends ChangeNotifier {
  FilePickerResult? result;
  String? csv;

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
        group: Group.tech)
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

  void updateResultFile(value) {
    result = value;
    notifyListeners();
  }

  void dataExport() async {
    List<List<dynamic>> listContacts = [];
    List<dynamic> listContact = [];
    listContact.add('Name');
    listContact.add('Company');
    listContact.add('Title');
    listContact.add('Phone');
    listContact.add('Group');
    listContacts.add(listContact);

    for (int i = 0; i < registeredContacts.length; i++) {
      List<dynamic> listContact = [];
      listContact.add(registeredContacts[i].name);
      listContact.add(registeredContacts[i].company);
      listContact.add(registeredContacts[i].title);
      listContact.add(registeredContacts[i].phone);
      listContact.add(registeredContacts[i].group);
      listContacts.add(listContact);
    }
    csv = const ListToCsvConverter().convert(listContacts);
    String dir = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    print("dir $dir");
    String file = dir;
    File f = File(file + ("/contacts.csv"));
    f.writeAsString(csv!);
    print(" export function called successfully");

    notifyListeners();
  }
}

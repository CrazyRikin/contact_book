import 'dart:convert';
import 'dart:io';
import 'package:contact_book/backend/contact_list_fetch.dart';
import 'package:contact_book/backend/delete_contact.dart';
import 'package:contact_book/backend/post_contact.dart';
import 'package:contact_book/services/model/contact_model.dart';
import 'package:csv/csv.dart';
import 'package:external_path/external_path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:uuid/uuid.dart';

List<String> saveOptions = ["Save To Device", "Save To Google"];

class ContactListProvider extends ChangeNotifier {
  List<List<dynamic>> importedData = [];
  String? filePath;
  String? csv;
  List<List<dynamic>> listContacts = [];
  List<dynamic> listContact = [];
  var saveName = TextEditingController();

  late FullContact fetchedContact;

  Group defaultGroup = Group.others;

  String defaultSaveOption = 'Save To Google';

  List<Contacts> registeredContacts = [];

  void listSorter() {
    registeredContacts.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  void addContact(String name, String? company, String phone, String? title,
      String? email, Group? group) {
    registeredContacts.add(Contacts.addId(
        name: name,
        company: company!,
        title: title!,
        phone: phone,
        email: email!,
        group: group!));
    postContact(
        const Uuid().v4(), name, company, title, phone, email, group.name);
    listSorter();
    notifyListeners();
  }

  void addContactFromImport(String id, String name, String? company,
      String? title, String phone, String? email, Group? group) {
    registeredContacts.add(Contacts(
        id: id,
        name: name,
        company: company!,
        title: title!,
        phone: phone,
        email: email!,
        group: group!));
    postContact(
        const Uuid().v4(), name, company, title, phone, email, group.name);
    listSorter();
    notifyListeners();
  }

  void loadContactsList() async {
    var response = await makeCall();
    var responseList = response.contacts;
    for (final element in responseList!) {
      
      registeredContacts.add(Contacts(
          id: element.sId.toString(),
          name: element.name.toString(),
          company: element.company.toString(),
          title: element.title.toString(),
          phone: element.mobile.toString(),
          email: element.email.toString(),
          group: defaultGroup));
    }

    listSorter();
    notifyListeners();
  }

  void deleteContact(index) {
    print(registeredContacts[index].id);
    deleteContactApi(registeredContacts[index].id);
    registeredContacts.removeAt(index);

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

  void pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) {
      return;
    }
    filePath = result.files.first.path;
    final input = File(filePath!).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
    importedData = fields;
    notifyListeners();
  }

  void dataExport(context) async {
    listContact.add('Sid');
    listContact.add('Name');
    listContact.add('Company');
    listContact.add('Title');
    listContact.add('Phone');
    listContact.add('email');
    listContact.add('Group');
    listContacts.add(listContact);

    for (int i = 0; i < registeredContacts.length; i++) {
      List<dynamic> listContact = [];
      listContact.add(registeredContacts[i].id);
      listContact.add(registeredContacts[i].name);
      listContact.add(registeredContacts[i].company);
      listContact.add(registeredContacts[i].title);
      listContact.add(registeredContacts[i].phone);
      listContact.add(registeredContacts[i].email);
      listContact.add(registeredContacts[i].group);
      listContacts.add(listContact);
    }
    csv = const ListToCsvConverter().convert(listContacts);
    String dir = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);

    String file = dir;
    showBottomSheet(
        context: context,
        builder: (context) => SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(children: [
                    const Icon(Icons.horizontal_rule_rounded, size: 36),
                    TextField(
                        decoration: const InputDecoration(
                            hintText: 'Enter save name',
                            border: OutlineInputBorder()),
                        controller: saveName),
                    const SizedBox(height: 20),
                    OutlinedButton(
                        onPressed: () {
                          if (saveName.text.isNotEmpty) {
                            File f = File(
                                file + ("/${saveName.text.trimRight()}.csv"));
                            f.writeAsString(csv!);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 3),
                                backgroundColor: Colors.white,
                                content: Center(
                                  child: Text(
                                    'DATA EXPORTED SUCCESSFULLY ! CHECK DOWNLOADS.',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ),
                            );
                            saveName.clear();
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 3),
                                backgroundColor: Colors.white,
                                content: Center(
                                  child: Text(
                                    'ENTER A VALID NAME',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text("SAVE FILE"))
                  ]),
                ),
              ),
            ));

    notifyListeners();
  }
}

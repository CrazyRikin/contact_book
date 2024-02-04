import 'dart:convert';
import 'dart:io';
import 'package:contact_book/services/model/contact_model.dart';
import 'package:csv/csv.dart';
import 'package:external_path/external_path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';

List<String> saveOptions = ["Save To Device", "Save To Google"];

class ContactListProvider extends ChangeNotifier {
  List<List<dynamic>> importedData = [];
  String? filePath;
  String? csv;
  List<List<dynamic>> listContacts = [];
  List<dynamic> listContact = [];
  var saveName = TextEditingController();

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

  void pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) {
      return;
    }
    print(" path : ${result.files.first.path}");
    filePath = result.files.first.path;
    final input = File(filePath!).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
    print(fields);
    importedData = fields;
    notifyListeners();
  }

  void dataExport(context) async {
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

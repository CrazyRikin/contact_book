import 'package:contact_book/services/model/contact_model.dart';
import 'package:contact_book/services/providers/contacts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImportContacts extends StatelessWidget {
  const ImportContacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactListProvider>(
      builder: (context, contactlistprovider, child) => Scaffold(
        appBar: AppBar(centerTitle: true, actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                try {
                  for (int index = 1;
                      index < contactlistprovider.importedData.length;
                      index++) {
                    contactlistprovider.addContact(
                        contactlistprovider.importedData[index][0].toString(),
                        contactlistprovider.importedData[index][1].toString(),
                        contactlistprovider.importedData[index][3].toString(),
                        contactlistprovider.importedData[index][2].toString(),
                        contactlistprovider.importedData[index][4].toString(),
                        contactlistprovider.defaultGroup);
                  }
                  contactlistprovider.importedData = [];
                  Navigator.pop(context);
                } catch (e) {
                  print("import error");
                }
              },
              child: const Text(
                "Done",
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
        ]),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: Column(children: [
                    Container(
                      color: const Color.fromARGB(73, 124, 77, 255),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextButton(
                          onPressed: () async {
                            try {
                              contactlistprovider.pickFile();
                            } catch (e) {
                              print("error on select");
                            }
                          },
                          child: const Text(
                            "CLICK TO IMPORT FILE",
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                    const SizedBox(height: 10),
                    contactlistprovider.importedData.isEmpty
                        ? const Text(
                            "NO FILE SELECTED!",
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          )
                        : const Text(
                            "FILE SELECTED!",
                            style: TextStyle(color: Colors.green, fontSize: 12),
                          ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text(
                          "Select Group for the file: ",
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(width: 20),
                        DropdownButton(
                          value: contactlistprovider.defaultGroup,
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }

                            contactlistprovider.changeGroup(value);
                          },
                          items: Group.values
                              .map(
                                (group) => DropdownMenuItem(
                                  value: group,
                                  child: Text(group.name.toUpperCase()),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

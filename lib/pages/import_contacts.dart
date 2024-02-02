import 'package:contact_book/services/model/contact_model.dart';
import 'package:contact_book/services/providers/contacts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

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
                  contactlistprovider.updateResultFile(null);
                  Navigator.pop(context);
                } catch (e) {
                  print("error!");
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
                Column(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextButton(
                        onPressed: () async {
                          try {
                            contactlistprovider.updateResultFile(
                                await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['csv', 'xlx', 'xlsx'],
                            ));
                          } catch (e) {
                            print("error encountered");
                          }
                        },
                        child: const Text("CLICK TO IMPORT FILE")),
                  ),
                  Row(
                    children: [
                      const Text("Select Group for the file: "),
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
                  contactlistprovider.result == null
                      ? const Text(
                          "No File Selected",
                          style: TextStyle(color: Colors.red),
                        )
                      : const Text(
                          "File Selected",
                          style: TextStyle(color: Colors.green),
                        ),
                  Text(contactlistprovider.result.toString())
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

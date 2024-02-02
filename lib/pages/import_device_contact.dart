import 'package:flutter/material.dart';
import 'package:contact_book/services/providers/contacts_provider.dart';
import 'package:provider/provider.dart';
import 'package:contact_book/services/model/contact_model.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';

class DeviceContacts extends StatefulWidget {
  const DeviceContacts({super.key});

  @override
  State<DeviceContacts> createState() => _DeviceContactsState();
}

class _DeviceContactsState extends State<DeviceContacts> {
  FullContact nullFunction = FullContact([], [], [], [],
      StructuredName('', '', '', ''), null, null, null, null, [], []);
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
                    contactlistprovider.addContact(
                        contactlistprovider.fetchedContact.name!.firstName
                            .toString(),
                        contactlistprovider.fetchedContact.company.toString(),
                        contactlistprovider.fetchedContact.phones.toString(),
                        contactlistprovider.fetchedContact.relations.toString(),
                        contactlistprovider.fetchedContact.emails.toString(),
                        contactlistprovider.defaultGroup);
                    contactlistprovider.updateFetchContact(nullFunction);

                    Navigator.pop(context);
                  } catch (e) {}
                },
                child: const Text(
                  "Done",
                  style: TextStyle(fontSize: 20),
                )),
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
                            bool perm =
                                await FlutterContactPicker.requestPermission();
                            if (perm) {
                              if (await FlutterContactPicker.hasPermission()) {
                                contactlistprovider.updateFetchContact(
                                    await FlutterContactPicker
                                        .pickFullContact());
                              }
                            }
                          } catch (e) {}
                        },
                        child: const Text("CLICK TO SELECT DEVICE CONTACT")),
                  ),
                  Row(
                    children: [
                      const Text("Select Group for the contact: "),
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
                  Text(
                      "Selected Contact: ${contactlistprovider.fetchedContact.name!.firstName!.toUpperCase()}")
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

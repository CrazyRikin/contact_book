import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:contact_book/services/providers/contacts_provider.dart';
import 'package:provider/provider.dart';
import 'package:contact_book/services/model/contact_model.dart';

class DeviceContacts extends StatefulWidget {
  const DeviceContacts({super.key});

  @override
  State<DeviceContacts> createState() => _DeviceContactsState();
}

class _DeviceContactsState extends State<DeviceContacts> {
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
                    Navigator.pop(context);
                  } catch (e) {
                    print("error!");
                  }
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
            child: ListView(children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextButton(
                    onPressed: () async {
                      try {
                        bool permission =
                            await FlutterContactPicker.requestPermission();
                        if (permission) {
                          if (await FlutterContactPicker.hasPermission()) {
                            var temp =
                                await FlutterContactPicker.pickPhoneContact();
                            contactlistprovider.updateFetchContact(temp);
                            if (contactlistprovider.fetchedContact != null) {}
                          }
                        }
                      } catch (e) {
                        print("error encountered");
                      }
                    },
                    child: const Text("CLICK TO IMPORT DEVICE CONTACTS")),
              ),
              Text(contactlistprovider.fetchedContact.toString())
            ]),
          ),
        ),
      ),
    );
  }
}

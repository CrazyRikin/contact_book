import 'package:contact_book/pages/add_contact.dart';
import 'package:contact_book/pages/import_contacts.dart';
import 'package:contact_book/pages/import_device_contact.dart';
import 'package:contact_book/services/providers/contacts_provider.dart';

import 'package:contact_book/widgets/HomePageWidgets/buttons_to_nextpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Consumer<ContactListProvider>(
      builder: (context, contactlistprovider, child) => FloatingActionButton(
        onPressed: () {
          showBottomSheet(
            enableDrag: true,
            backgroundColor: Theme.of(context).colorScheme.onSecondary,
            context: context,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: deviceHeight * 0.3,
                child: Column(
                  children: [
                    const Icon(Icons.horizontal_rule_rounded),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const ToPageButton(
                              buttonIcon: Icons.add,
                              label: 'Add Contacts',
                              onPressed: AddContacts()),
                          const ToPageButton(
                              buttonIcon: Icons.download,
                              label: 'Import Contacts',
                              onPressed: ImportContacts()),
                          const ToPageButton(
                              buttonIcon: Icons.phone_android,
                              label: 'Device Contacts',
                              onPressed: DeviceContacts()),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: GestureDetector(
                              onTap: () {
                                try {
                                  contactlistprovider.dataExport();
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
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      duration: Duration(seconds: 3),
                                      backgroundColor: Colors.white,
                                      content: Center(
                                        child: Text(
                                          'FAILED TO EXPORT DATA!',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: const Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.upload),
                                      SizedBox(width: 16),
                                      Text("Export Contacts")
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

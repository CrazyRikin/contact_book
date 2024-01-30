import 'package:contact_book/pages/add_contact.dart';
import 'package:contact_book/pages/export_contact.dart';
import 'package:contact_book/pages/import_contacts.dart';
import 'package:contact_book/pages/import_device_contact.dart';

import 'package:contact_book/widgets/HomePageWidgets/buttons_to_nextpage.dart';
import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return FloatingActionButton(
      onPressed: () {
        showBottomSheet(
            enableDrag: true,
            backgroundColor: Theme.of(context).colorScheme.onSecondary,
            context: context,
            builder: (context) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: deviceHeight * 0.3,
                    child: const Column(
                      children: [
                        Icon(Icons.horizontal_rule_rounded),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ToPageButton(
                                  buttonIcon: Icons.add,
                                  label: 'Add Contacts',
                                  openPage: AddContacts()),
                              ToPageButton(
                                  buttonIcon: Icons.download,
                                  label: 'Import Contacts',
                                  openPage: ImportContacts()),
                              ToPageButton(
                                  buttonIcon: Icons.phone_android,
                                  label: 'Device Contacts',
                                  openPage: DeviceContacts()),
                              ToPageButton(
                                  buttonIcon: Icons.upload,
                                  label: 'Export Contacts',
                                  openPage: ExportContacts()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
      },
      child: const Icon(Icons.add),
    );
  }
}

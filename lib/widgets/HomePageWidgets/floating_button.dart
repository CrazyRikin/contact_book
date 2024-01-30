import 'package:contact_book/pages/add_contact.dart';
import 'package:contact_book/pages/export_contact.dart';
import 'package:contact_book/pages/import_contacts.dart';
import 'package:contact_book/pages/import_device_contact.dart';
import 'package:contact_book/services/functions/home_page_functions.dart';
import 'package:contact_book/widgets/HomePageWidgets/buttons_to_nextpage.dart';
import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showBottomSheet(
            enableDrag: true,
            backgroundColor: Colors.white,
            context: context,
            builder: (context) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                ));
      },
      child: const Icon(Icons.add),
    );
  }
}

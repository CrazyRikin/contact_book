import 'package:contact_book/services/providers/contacts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contact_book/services/model/contact_model.dart';

class AddContacts extends StatefulWidget {
  const AddContacts({super.key});

  @override
  State<AddContacts> createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  TextEditingController nameController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController workController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    companyController.dispose();
    titleController.dispose();
    phoneController.dispose();
    workController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactListProvider>(
      builder: (context, contactlistprovider, child) => Scaffold(
        appBar: AppBar(centerTitle: true, actions: [
          DropdownButton(
            value: contactlistprovider.defaultSaveOption,
            onChanged: (value) {
              if (value == null) {
                return;
              }

              contactlistprovider.changeSaveOption(value);
            },
            items: saveOptions
                .map(
                  (option) => DropdownMenuItem(
                    value: option,
                    child: Text(option.toUpperCase()),
                  ),
                )
                .toList(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  try {
                    contactlistprovider.addContact(
                        nameController.text,
                        companyController.text,
                        phoneController.text,
                        titleController.text,
                        workController.text,
                        contactlistprovider.defaultGroup);
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.white,
                        content: Center(
                          child: Text(
                            'Failed to add contact',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.save_alt, size: 32)),
          )
        ]),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(children: [
              Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    maxLength: 50,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: companyController,
                          decoration: InputDecoration(
                            labelText: 'Company',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: titleController,
                          decoration: InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: workController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text(
                        "Group Name",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
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
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

import 'package:uuid/uuid.dart';

enum Group { crew,talent,extras,client,others }

class Contacts {
  final String name;
  final String company;
  final String title;
  final String phone;
  final String email;
  final Group group;
  final String id;

  Contacts(
      {required this.id,
      required this.name,
      required this.company,
      required this.title,
      required this.phone,
      required this.email,
      required this.group});
  Contacts.addId(
      {required this.name,
      required this.company,
      required this.title,
      required this.phone,
      required this.email,
      required this.group})
      : id = const Uuid().v4();
}

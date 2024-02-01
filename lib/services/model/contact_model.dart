enum Group { work, tech, hr }

class Contacts {
  final String name;
  final String company;
  final String title;
  final String phone;
  final String email;
  final Group group;
  
  Contacts(
      {required this.name,
      required this.company,
      required this.title,
      required this.phone,
      required this.email,
      required this.group});
}

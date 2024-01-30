import 'package:flutter/material.dart';

class ToPageButton extends StatelessWidget {
  const ToPageButton(
      {super.key,
      required this.openPage,
      required this.buttonIcon,
      required this.label});
  final Widget openPage;
  final IconData buttonIcon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: deviceWidth * 0.5,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => openPage));
        },
        child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(buttonIcon),
                  const SizedBox(width: 16),
                  Text(label)
                ],
              ),
            )),
      ),
    );
  }
}

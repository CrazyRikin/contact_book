import 'package:flutter/material.dart';

class ToPageButton extends StatelessWidget {
  const ToPageButton(
      {super.key,
      required this.onPressed,
      required this.buttonIcon,
      required this.label});
  final Widget onPressed;
  final IconData buttonIcon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: deviceWidth * 0.75,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => onPressed));
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

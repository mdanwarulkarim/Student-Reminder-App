import 'package:flutter/material.dart';
import 'package:student_reminder/util/styles.dart';

class IntroButton extends StatelessWidget {
  final String title;
  final Function onTap;
  const IntroButton({Key? key, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(children: [

          Expanded(child: Text(title, style: poppinsSemiBold.copyWith(fontSize: 16))),
          const SizedBox(width: 10),

          const Icon(Icons.navigate_next, size: 20),

        ]),
      ),
    );
  }
}

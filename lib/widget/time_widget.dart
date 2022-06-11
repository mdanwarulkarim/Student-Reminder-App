import 'package:flutter/material.dart';
import 'package:student_reminder/util/styles.dart';

class TimeWidget extends StatelessWidget {
  final String? title;
  const TimeWidget({Key? key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(
      decoration: BoxDecoration(
        color: const Color(0xFF162847),
        borderRadius: BorderRadius.circular(20),
      ),
      child: FittedBox(child: Text(title ?? '', style: poppinsBold.copyWith(color: Colors.white))),
    ));
  }
}

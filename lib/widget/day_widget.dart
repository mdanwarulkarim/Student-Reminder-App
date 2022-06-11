import 'package:flutter/material.dart';
import 'package:student_reminder/util/styles.dart';

class DayWidget extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final String title;
  final Function onTap;
  const DayWidget({Key? key, required this.index, required this.selectedIndex, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selectedIndex == index ? Theme.of(context).secondaryHeaderColor : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(title, style: poppinsMedium.copyWith(fontSize: 12, color: selectedIndex == index ? Colors.white : null)),
      ),
    ));
  }
}

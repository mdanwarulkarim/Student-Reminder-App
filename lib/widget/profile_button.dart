import 'package:flutter/material.dart';
import 'package:student_reminder/util/styles.dart';

class ProfileButton extends StatefulWidget {
  final String icon;
  final String title;
  final Function onTap;
  const ProfileButton({Key? key, required this.icon, required this.title, required this.onTap}) : super(key: key);

  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(children: [

          Image.asset(widget.icon, height: 20, width: 20),
          const SizedBox(width: 10),

          Expanded(child: Text(widget.title, style: poppinsRegular.copyWith(fontSize: 12, color: Theme.of(context).textTheme.titleMedium!.color))),
          const SizedBox(width: 10),

          Icon(Icons.navigate_next, color: Theme.of(context).textTheme.titleMedium!.color),

        ]),
      ),
    );
  }
}

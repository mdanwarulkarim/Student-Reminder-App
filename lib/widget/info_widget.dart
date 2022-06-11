import 'package:flutter/material.dart';
import 'package:student_reminder/util/styles.dart';

class InfoWidget extends StatefulWidget {
  final String title;
  final String value;
  const InfoWidget({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  State<InfoWidget> createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<InfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(children: [

        Text(widget.value, style: poppinsMedium.copyWith(color: Theme.of(context).primaryColor)),
        const SizedBox(height: 10),

        Text(widget.title, style: poppinsRegular.copyWith(fontSize: 12)),

      ]),
    );
  }
}

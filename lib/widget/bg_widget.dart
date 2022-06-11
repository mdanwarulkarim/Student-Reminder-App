import 'package:flutter/material.dart';

class BgWidget extends StatefulWidget {
  final Widget child;
  final Alignment alignment;
  const BgWidget({Key? key, required this.child, this.alignment = Alignment.center}) : super(key: key);

  @override
  State<BgWidget> createState() => _BgWidgetState();
}

class _BgWidgetState extends State<BgWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor.withOpacity(0.5)],
          begin: Alignment.centerRight, end: Alignment.centerLeft,
        ),
      ),
      alignment: widget.alignment,
      child: widget.child,
    );
  }
}

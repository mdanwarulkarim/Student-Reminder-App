import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_reminder/util/styles.dart';

class ButtonWidget extends StatelessWidget {
  final Function? onPressed;
  final String? buttonText;
  final EdgeInsets? margin;
  final double? width;
  final IconData? preIcon;
  final IconData? postIcon;
  const ButtonWidget({
    Key? key, this.onPressed, @required this.buttonText, this.margin, this.width, this.preIcon, this.postIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed!(),
      child: Container(
        height: 60, width: width ?? context.width,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).secondaryHeaderColor,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          preIcon != null ? Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(preIcon, color: Colors.white),
          ) : const SizedBox(),
          Text(buttonText ?? '', textAlign: TextAlign.center, style: poppinsBold.copyWith(
            color: Colors.white, fontSize: 16,
          )),
          postIcon != null ? Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Icon(postIcon, color: Colors.white),
          ) : const SizedBox(),
        ]),
      ),
    );
  }
}

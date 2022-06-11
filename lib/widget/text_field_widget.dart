import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_reminder/util/styles.dart';

class TextFieldWidget extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final Function(String text)? onChanged;
  final Function? onSubmit;
  final Function? onTap;
  final bool isEnabled;
  final int maxLines;
  final TextCapitalization capitalization;
  final String? prefixIcon;

  const TextFieldWidget(
      {Key? key, this.hintText = 'Write something...',
      this.controller,
      this.focusNode,
      this.nextFocus,
      this.isEnabled = true,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      this.maxLines = 1,
      this.onSubmit,
      this.onTap,
      this.onChanged,
      this.prefixIcon,
      this.capitalization = TextCapitalization.none,
      this.isPassword = false}
  ) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: poppinsRegular.copyWith(fontSize: 16),
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      cursorColor: Theme.of(context).primaryColor,
      textCapitalization: widget.capitalization,
      enabled: widget.isEnabled,
      autofocus: false,
      onTap: () => widget.onTap != null ? widget.onTap!() : null,
      obscureText: widget.isPassword ? _obscureText : false,
      inputFormatters: (widget.inputType == TextInputType.phone || widget.inputType == TextInputType.number)
          ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9.]'))] : null,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(style: BorderStyle.none, width: 0),
        ),
        isDense: true,
        hintText: widget.hintText,
        fillColor: Theme.of(context).shadowColor,
        hintStyle: poppinsRegular.copyWith(fontSize: 16, color: Theme.of(context).hintColor),
        filled: true,
        prefixIcon: widget.prefixIcon != null ? Container(
          height: 50, width: 50, alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: Image.asset(widget.prefixIcon!, height: 20, width: 20),
        ) : null,
        suffixIcon: widget.isPassword ? IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: Theme.of(context).hintColor.withOpacity(0.3)),
          onPressed: _toggle,
        ) : null,
      ),
      onSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus)
          : widget.onSubmit != null ? widget.onSubmit!(text) : null,
      onChanged: widget.onChanged,
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}

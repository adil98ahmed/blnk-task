import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final lable, hint, controller, passwordEncryption;
  const TextFieldWidget({
    Key key,
    this.lable,
    this.hint,
    this.controller,
    this.passwordEncryption,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            5, 20, 5, MediaQuery.of(context).viewInsets.bottom),
        child: TextField(
          obscureText: widget.passwordEncryption,
          controller: widget.controller,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              labelText: widget.lable,
              labelStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
              hintText: widget.hint,
              hintStyle: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w200),
              enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: Colors.white)),
              focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: Colors.white)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1))),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SmallTextFormFieldWidget extends StatefulWidget {
  final String hinttext;
  final IconData? icon;
  final String? labelname;
  bool? read = false;
  bool? sufix = false;
  final FormFieldValidator<String>? validator;
  final TextEditingController controllerr;
  bool? keybordTypes;

  SmallTextFormFieldWidget(
      {super.key,
      required this.validator,
      required this.hinttext,
      this.icon,
      required this.controllerr,
      this.labelname,
      this.read,
      this.sufix,
      this.keybordTypes});

  @override
  State<SmallTextFormFieldWidget> createState() =>
      _SmallTextFormFieldWidgetState();
}

class _SmallTextFormFieldWidgetState extends State<SmallTextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 2.4,
      height: 60,
      child: TextFormField(
        validator: widget.validator,
        keyboardType: widget.keybordTypes == true
            ? TextInputType.number
            : TextInputType.text,
        readOnly: widget.read == true ? true : false,
        controller: widget.controllerr,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 41, 161, 110), width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          prefixIcon: Icon(widget.icon),
          hintText: widget.hinttext,
          fillColor: Colors.white,
          labelText: widget.labelname,
          filled: true,
          suffix: widget.sufix == true
              ? IconButton(onPressed: () {}, icon: Icon(Icons.date_range))
              : SizedBox(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

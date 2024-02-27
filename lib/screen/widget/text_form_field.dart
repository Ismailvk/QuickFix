import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TextFormFieldWidget extends StatefulWidget {
  final String hinttext;
  final IconData? icon;
  final IconData? lastIcon;
  final String? labelname;
  bool? read = false;
  bool? sufix = false;
  final FormFieldValidator<String>? validator;
  final TextEditingController controllerr;
  bool? keybordTypes;

  TextFormFieldWidget(
      {super.key,
      required this.validator,
      required this.hinttext,
      this.icon,
      required this.controllerr,
      this.labelname,
      this.read,
      this.lastIcon,
      this.sufix,
      this.keybordTypes});

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
          minWidth: size.width / 2,
          maxWidth: size.width / 1.06,
          minHeight: size.height / 10,
          maxHeight: size.height / 10),
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
              ? IconButton(
                  onPressed: () {
                    _showDate(DateTime.now(), context);
                  },
                  icon: Icon(Icons.date_range))
              : SizedBox(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  void _showDate(
    DateTime tapDate,
    BuildContext context,
  ) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) {
      setState(() {
        if (value == null) {
          return;
        } else {
          setState(() {
            widget.controllerr.text = DateFormat('yyyy/MM/dd').format(value);
          });
        }
      });
    });
  }
}

import 'package:textfield_shadow/textfield_shadow.dart';

class TextWidget extends StatelessWidget {
  final text1st;

  TextWidget({
    super.key,
    required this.text1st,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          text1st,
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}

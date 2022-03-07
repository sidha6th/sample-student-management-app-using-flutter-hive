import 'package:sample/exports/exports.dart';

bool isfieldTouched = false;

class Textfield extends StatefulWidget {
  const Textfield({
    Key? key,
    this.data,
    required this.isnumber,
    required this.textcontroller,
    required this.hindText,
  }) : super(key: key);
  final String hindText;
  final bool isnumber;
  final String? data;
  final TextEditingController textcontroller;

  @override
  State<Textfield> createState() => _TextfieldState();
}

class _TextfieldState extends State<Textfield> {
  @override
  void dispose() {
    isfieldTouched = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isfieldTouched == false) {
      widget.textcontroller.text = widget.data ?? '';
    }
    return TextField(
      onTap: () => isfieldTouched = true,
      keyboardType:
          widget.isnumber == true ? TextInputType.number : TextInputType.name,
      textInputAction: TextInputAction.next,
      controller: widget.textcontroller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(borderSide: BorderSide()),
        hintText: widget.hindText,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:su_project/config/config.dart';

class customTextFieldRegsiterPage extends StatelessWidget {
  final TextEditingController? textEditingController;
  bool? isSecure = true;
  final TextInputType? textInputType;
  bool? enabledEdit = true;
  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;

  customTextFieldRegsiterPage(
      {Key? key,
      this.enabledEdit,
      this.isSecure,
      this.textEditingController,
      this.textInputType,
      this.hint,
      this.prefixIcon,
      this.suffixIcon,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: SU.backgroundColor, // Border color
          width: 1.0, // Border width
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: TextField(
          onChanged: onChanged,
          controller: textEditingController,
          obscureText: isSecure!,
          cursorColor: Colors.black,
          keyboardType: textInputType,
          enabled: enabledEdit,
          decoration: InputDecoration(
            filled: false,
            fillColor: Colors.transparent,
            isCollapsed: false,
            isDense: true,
            suffixStyle: const TextStyle(
              color: SU.primaryColor,
            ),
            border: InputBorder.none, // Remove the default border
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 12),
            focusedBorder:
                InputBorder.none, // Remove the default focused border
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }
}

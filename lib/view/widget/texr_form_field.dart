import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditTextForm extends StatelessWidget {
  EditTextForm({
    Key? key,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixWidget,
    this.prefixWidget,
    this.validator,
    this.onPasswordToggle,
    this.controller,
    this.autoValidateMode,
    this.obscureText,
    this.readOnly = false,
    this.onTapped,
    this.keyboardType,
    this.suffixIconColor,
    this.prefixIconColor,
    this.formKey,
  }) : super(key: key);

  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onPasswordToggle;

  final TextEditingController? controller;
  final AutovalidateMode? autoValidateMode;
  final bool? obscureText;
  final bool? readOnly;
  final Function()? onTapped;

  final TextInputType? keyboardType;
  final Color? suffixIconColor;
  final Color? prefixIconColor;
  final Key? formKey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.h,
      child: TextFormField(
        readOnly: readOnly!,
        controller: controller,
        validator: validator,
        autovalidateMode: autoValidateMode,
        decoration: InputDecoration(
          suffixIcon: suffixWidget,
          suffixIconColor: const Color.fromARGB(255, 11, 8, 163),
          label: Text(label ?? ''),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        key: formKey,
        onTap: onTapped,
      ),
    );
  }
}

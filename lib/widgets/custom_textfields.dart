import 'package:chat_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomFormTextField extends StatefulWidget {
  CustomFormTextField({this.onchange, this.hintText, this.obsecure});
  final String? hintText;
  Function(String)? onchange;
  bool? obsecure;

  @override
  State<CustomFormTextField> createState() => _CustomFormTextFieldState();
}

class _CustomFormTextFieldState extends State<CustomFormTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: TextFormField(
        validator: (data) {
          if (data!.isEmpty) {
            return 'This field is required';
          }
        },
        onChanged: widget.onchange,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: kSecondaryColor,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: kQuaternaryColor),
          suffixIcon: widget.hintText == 'Password' || widget.hintText == 'Confirm password'
              ? GestureDetector(
                  child:widget.obsecure!? const Icon(
                    Icons.visibility_off,
                    color: kSecondaryColor,)
                  :const Icon(
                    Icons.visibility,
                    color: kSecondaryColor,),
                  
                  onTap: () {
                    setState(() {
                       widget.obsecure = !widget.obsecure!;
                    });
                  },
                )
              : const Icon(Icons.mail, color: kSecondaryColor),
        ),
        obscureText: widget.obsecure!,
        cursorColor: kSecondaryColor,
      ),
    );
  }
}

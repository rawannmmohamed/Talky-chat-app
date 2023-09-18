import 'package:chat_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({this.onTap, required this.text});
  final String? text;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              onTap?.call();
            },
            style: ButtonStyle(
              backgroundColor: const MaterialStatePropertyAll(kSecondaryColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            child: Text(
              text!,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ));
  }
}

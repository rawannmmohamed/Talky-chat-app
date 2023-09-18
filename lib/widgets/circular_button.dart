import 'package:chat_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  CircularButton({this.image, this.ontap});
  String? image;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap, 
      child: Container(
        height: 50,
        width: 50,
        decoration:const BoxDecoration(
          color: kPrimaryColor,
          shape: BoxShape.circle,
          boxShadow:[
            BoxShadow(
              blurRadius: 3,
              color: kQuaternaryColor,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            image!,
            alignment: Alignment.centerLeft,
          ),
        ),
      ),
    );
  }
}

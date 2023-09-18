import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: kSecondaryColor,
  ));
}

const kMessagesCollection = 'messages';
const kMessage = 'message';
const kCreatedAt = 'createdAt';

import 'package:chat_app/helper/snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Message {
  final String message;
  final String id;
  Message(this.message, this.id);

  factory Message.fromJson(jsonData) {
    return Message(jsonData[kMessage], jsonData['id']);
  }
}

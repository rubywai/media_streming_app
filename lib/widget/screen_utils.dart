import 'package:flutter/material.dart';

bool isLargerDevice(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  return size.width > size.height;
}

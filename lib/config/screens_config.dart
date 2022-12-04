import 'package:flutter/material.dart';

double getCurrentScreenHeight(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height -
      (MediaQuery.of(context).padding.top +
          MediaQuery.of(context).padding.bottom);
  return screenHeight;
}

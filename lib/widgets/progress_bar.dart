import 'package:flutter/material.dart';

Widget progressBar() {
  return Stack(
    children: [
      Opacity(
        opacity: 0.7,
        child: ModalBarrier(
          dismissible: false,
          color: Colors.grey,
        ),
      ),
      Center(
        child: CircularProgressIndicator(backgroundColor: Colors.white,),
      ),
    ],
  );
}

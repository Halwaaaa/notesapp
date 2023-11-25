import 'package:flutter/material.dart';

class dauilMateral extends StatelessWidget {
  const dauilMateral({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: const EdgeInsets.all(10),
          width: 80,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(35)),
          child: const Image(
            height: 50,
            width: 35,
            image: AssetImage(
              'assets/images/icon.png',
            ),
            //,width: 30,
          )),
    );
  }
}

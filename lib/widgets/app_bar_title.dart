import 'package:flutter/material.dart';
import 'package:studentproject/constants/sizes.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: ScreenSize.height50,
          width: ScreenSize.width50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 215, 3, 227),
                Color.fromARGB(255, 250, 20, 84),
              ],
            ),
          ),
          child: Text(
            "DP",
            style: TextStyle(
                fontSize: ScreenSize.fontSize25, fontWeight: FontWeight.w400),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: ScreenSize.width20, top: ScreenSize.height5),
          child: const Text(
            "Mark Appollo Hot Trends",
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

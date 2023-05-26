import 'package:get/get.dart';

class ScreenSize {
  static double screenHeight = Get.context!.height; //781 - emu
  static double screenWidth = Get.context!.width; //392 emu

//screenwidth or height or dimen 752 * 360
  static double toolbarHeight = screenHeight / 12.53;
  static double toolbarElevation = screenHeight / 1504;

  static double fontSize25 = screenWidth / 14.4;
  static double fontSize15 = screenWidth / 24;
  static double letterSpacing = screenWidth / 360;

  //width
  static double width1 = screenWidth / 360;
  static double width5 = screenWidth / 72;
  static double width10 = screenWidth / 36;
  static double width12 = screenWidth / 30;
  static double width15 = screenWidth / 24;
  static double width20 = screenWidth / 18;
  static double width50 = screenWidth / 7.2;
  static double width100 = screenWidth / 3.6;
  static double width150 = screenWidth / 2.4;
  static double width200 = screenWidth / 1.8;
  static double width300 = screenWidth / 1.2;

  static double height5 = screenHeight / 150.4;
  static double height10 = screenHeight / 75.2;
  static double height12 = screenHeight / 62.66;
  static double height15 = screenHeight / 50.13;
  static double height20 = screenHeight / 37.6;
  static double height25 = screenHeight / 30.08;
  static double height30 = screenHeight / 25.06;
  static double height50 = screenHeight / 15.04;
  static double height80 = screenHeight / 9.4;
  static double height100 = screenHeight / 7.52;
  static double height250 = screenHeight / 3.00;
}

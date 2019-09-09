import 'package:flutter/material.dart';
import 'package:lib_mvp/utils/utils.dart';

class MyUtils {
  static Widget loadAssetImage(String name,
      {double width, double height, BoxFit fit}) {
    return Image.asset(
      Utils.getImgPath(name),
      height: height,
      width: width,
      fit: fit,
    );
  }
}

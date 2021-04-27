import 'dart:convert';
import 'dart:io';

import 'package:image/image.dart';


class ImageUtils {

  /// compress the input image and return the compressed image path
  static String compress(String imagePath) {
    final image = decodeImage(File(imagePath).readAsBytesSync());
    final smallerImage = copyResize(image as Image, width: 500);
    String compressImagePath = imagePath.replaceFirst(".png", "_c.png");
    File(compressImagePath).writeAsBytesSync(encodeJpg(smallerImage, quality: 75));
    return compressImagePath;
  }

  static String compressFile(File file) {
    final imagePath = file.path;
    final image = decodeImage(file.readAsBytesSync());
    final smallerImage = copyResize(image as Image, width: 500);
    String compressImagePath = imagePath.replaceFirst(".png", "_c.png");
    File(compressImagePath).writeAsBytesSync(encodeJpg(smallerImage, quality: 75));
    return compressImagePath;
  }

  static String imageAsBase64(String imagePath) {
    List<int> imageBytes = File(imagePath).readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }
}

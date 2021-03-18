import 'dart:convert';
import 'dart:io';

import 'package:image/image.dart' as Im;

class ImageUtils {

  /// compress the input image and return the compressed image path
  static String compress(String imagePath) {
    Im.Image image = Im.decodeImage(File(imagePath).readAsBytesSync());
    Im.Image smallerImage = Im.copyResize(image, width: 250);
    String compressImagePath = imagePath.replaceFirst(".png", "_c.png");
    File(compressImagePath)
        .writeAsBytesSync(Im.encodeJpg(smallerImage, quality: 85));
    return compressImagePath;
  }

  static Object imageAsBase64(String imagePath) {
    List<int> imageBytes = File(imagePath).readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }
}

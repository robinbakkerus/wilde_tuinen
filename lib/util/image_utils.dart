import 'dart:convert';
import 'dart:io';

// import 'package:image/image.dart';

class ImageUtils {
  /// compress the input image and return the compressed image path
  static String compress(String imagePath) {
    // var image = decodeImage(File(imagePath).readAsBytesSync());
    // Image smallerImage = copyResize(image, width: 250);
    // String compressImagePath = imagePath.replaceFirst(".png", "_c.png");
    // File(compressImagePath)
    //     .writeAsBytesSync(encodeJpg(smallerImage, quality: 85));
    // return compressImagePath;
    return imagePath; //JRB
  }

  static Object imageAsBase64(String imagePath) {
    List<int> imageBytes = File(imagePath).readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }
}

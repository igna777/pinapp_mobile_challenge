import 'package:flutter/services.dart';

class NativeCommentsService {
  static const platform = MethodChannel('comments');

  static Future<List<Map<String, String>>> fetchComments(int postId) async {
    try {
      final List<dynamic> result =
          await platform.invokeMethod('getComments', {"postId": postId});

      return List<Map<String, String>>.from(
          result.map((e) => Map<String, String>.from(e)));
    } on PlatformException catch (e) {
      throw Exception("Error al obtener comentarios: ${e.message}");
    }
  }
}

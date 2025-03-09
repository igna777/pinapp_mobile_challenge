import 'package:dio/dio.dart';
import 'package:pin_app_challenge/data/models/comment_model.dart';

abstract class CommentRemoteDataSource {
  Future<List<CommentModel>> getComments(int postId);
}

class CommentRemoteDataSourceImpl implements CommentRemoteDataSource {
  final Dio dio;

  CommentRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<CommentModel>> getComments(int postId) async {
    try {
      final response = await dio.get(
        'https://jsonplaceholder.typicode.com/comments',
        queryParameters: {"postId": postId}, // Pasamos el parámetro aquí
      );

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => CommentModel.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Error al obtener comentarios: Código ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }
}

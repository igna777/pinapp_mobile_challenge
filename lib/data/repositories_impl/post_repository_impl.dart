import 'package:pin_app_challenge/data/data_sources/post_remote_data_source.dart';
import 'package:pin_app_challenge/domain/entities/post.dart';
import 'package:pin_app_challenge/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<PostEntity>> getPosts() async {
    try {
      return await remoteDataSource.getPosts();
    } catch (e) {
      throw Exception("Error al obtener los posts: $e");
    }
  }
}

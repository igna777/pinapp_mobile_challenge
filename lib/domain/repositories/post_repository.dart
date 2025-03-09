import 'package:pin_app_challenge/domain/entities/post.dart';

abstract class PostRepository {
  Future<List<PostEntity>> getPosts();
}

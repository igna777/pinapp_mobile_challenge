import 'package:pin_app_challenge/domain/entities/post.dart';
import 'package:pin_app_challenge/domain/repositories/post_repository.dart';

class GetPosts {
  final PostRepository repository;

  GetPosts(this.repository);

  Future<List<PostEntity>> call() async {
    return await repository.getPosts();
  }
}

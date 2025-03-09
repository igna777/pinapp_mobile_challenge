import 'package:pin_app_challenge/domain/entities/comment.dart';
import 'package:pin_app_challenge/domain/repositories/comment_repository.dart';

class GetComments {
  final CommentRepository repository;

  GetComments(this.repository);

  Future<List<Comment>> call(int postId) {
    return repository.getComments(postId);
  }
}

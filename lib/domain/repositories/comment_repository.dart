import 'package:pin_app_challenge/domain/entities/comment.dart';

abstract class CommentRepository {
  Future<List<Comment>> getComments(int postId);
}

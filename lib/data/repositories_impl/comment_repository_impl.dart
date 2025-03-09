import 'package:pin_app_challenge/data/data_sources/comment_remote_data_source.dart';
import 'package:pin_app_challenge/domain/entities/comment.dart';
import 'package:pin_app_challenge/domain/repositories/comment_repository.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentRemoteDataSource remoteDataSource;

  CommentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Comment>> getComments(int postId) async {
    return await remoteDataSource.getComments(postId);
  }
}

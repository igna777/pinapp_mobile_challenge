import 'package:mockito/annotations.dart';
import 'package:pin_app_challenge/domain/usescases/get_posts.dart';
import 'package:pin_app_challenge/domain/repositories/post_repository.dart';

@GenerateMocks([PostRepository, GetPosts])
void main() {}

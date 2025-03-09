import '_dependency_injection.dart';

class DependencyInjection {
  late final Dio dio;
  late final PostRemoteDataSource postRemoteDataSource;
  late final PostRepository postRepository;
  late final GetPosts getPosts;

  DependencyInjection() {
    dio = DioClient.dio; // Asegura que Dio se inicialice correctamente
    postRemoteDataSource = PostRemoteDataSourceImpl(dio: dio);
    postRepository = PostRepositoryImpl(remoteDataSource: postRemoteDataSource);
    getPosts = GetPosts(postRepository);
  }
}

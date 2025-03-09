import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pin_app_challenge/presentation/bloc/post/post_bloc.dart';
import 'package:pin_app_challenge/presentation/bloc/post/post_event.dart';
import 'package:pin_app_challenge/presentation/bloc/post/post_state.dart';
import 'package:pin_app_challenge/domain/entities/post.dart';
import '../../mocks.mocks.dart';

void main() {
  late PostBloc postBloc;
  late MockGetPosts mockGetPosts;

  setUp(() {
    mockGetPosts = MockGetPosts();
    postBloc = PostBloc(getPosts: mockGetPosts);
  });

  final testPosts = [
    PostEntity(
      id: 1,
      title: "Título de prueba",
      body: "Cuerpo de prueba",
      userId: 101,
    ),
    PostEntity(
      id: 2,
      title: "Otro título",
      body: "Otro cuerpo",
      userId: 102,
    ),
  ];

  blocTest<PostBloc, PostState>(
    'Debe emitir [PostLoading, PostLoaded] cuando LoadPosts es agregado y la API responde correctamente',
    build: () {
      when(mockGetPosts()).thenAnswer((_) async => testPosts);
      return postBloc;
    },
    act: (bloc) => bloc.add(LoadPosts()),
    expect: () => [
      PostLoading(),
      PostLoaded(posts: testPosts, likedPosts: {}),
    ],
  );

  blocTest<PostBloc, PostState>(
    'Debe emitir [PostLoading, PostError] cuando LoadPosts es agregado y la API falla',
    build: () {
      when(mockGetPosts()).thenThrow(Exception("Error en API"));
      return postBloc;
    },
    act: (bloc) => bloc.add(LoadPosts()),
    expect: () => [
      PostLoading(),
      PostError(message: "Exception: Error en API"),
    ],
  );
}

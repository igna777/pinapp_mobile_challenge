import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pin_app_challenge/domain/entities/post.dart';
import 'package:pin_app_challenge/domain/usescases/get_posts.dart';

import '../../mocks.mocks.dart';

void main() {
  late GetPosts getPosts;
  late MockPostRepository mockPostRepository;

  setUp(() {
    mockPostRepository = MockPostRepository();
    getPosts = GetPosts(mockPostRepository);
  });

  final testPosts = [
    PostEntity(
        id: 1,
        title: "Título de prueba",
        body: "Cuerpo de prueba",
        userId: 101),
    PostEntity(id: 2, title: "Otro título", body: "Otro cuerpo", userId: 102),
  ];

  test('Debería retornar una lista de posts desde el repositorio', () async {
    // Arrange (Configurar el comportamiento del mock)
    when(mockPostRepository.getPosts()).thenAnswer((_) async => testPosts);

    // Act (Ejecutar la función)
    final result = await getPosts();

    // Assert (Verificar que el resultado sea el esperado)
    expect(result, equals(testPosts));
    verify(mockPostRepository.getPosts()).called(1); // Se llamó una vez
  });
}

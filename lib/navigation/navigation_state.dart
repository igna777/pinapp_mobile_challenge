import 'package:equatable/equatable.dart';

// Definir los estados de la navegación
abstract class NavigationState extends Equatable {
  @override
  List<Object> get props => [];
}

// Estados de cada pantalla
class IntroScreenState extends NavigationState {}

class ListScreenState extends NavigationState {}

class PostListScreenState extends NavigationState {}

class PostDetailScreenState extends NavigationState {
  final String title;
  final String body;
  final int postId; // 🔹 Incluir postId

  PostDetailScreenState({
    required this.title,
    required this.body,
    required this.postId,
  });

  @override
  List<Object> get props => [title, body, postId];
}

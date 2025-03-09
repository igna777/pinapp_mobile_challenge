import '_post.dart';

abstract class PostState extends Equatable {
  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<PostEntity> posts;
  final Set<int> likedPosts; // Agregamos likedPosts

  PostLoaded({required this.posts, required this.likedPosts});

  @override
  List<Object> get props =>
      [posts, likedPosts]; // 🔹 Aseguramos que detecte cambios
}

class PostError extends PostState {
  final String message;

  PostError({required this.message});

  @override
  List<Object> get props => [message];
}

import '_post.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadPosts extends PostEvent {}

class FilterPosts extends PostEvent {
  final String query;
  FilterPosts({required this.query});

  @override
  List<Object> get props => [query]; // Agregamos query a props para comparación
}

//  Nuevo evento para manejar el like
class ToggleLike extends PostEvent {
  final int postId;
  ToggleLike({required this.postId});

  @override
  List<Object> get props =>
      [postId]; // Aseguramos que el estado detecte cambios
}

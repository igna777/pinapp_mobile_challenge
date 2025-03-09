// Definir eventos de navegación
import '_navigation.dart';

abstract class NavigationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NavigateToListScreen extends NavigationEvent {}

class NavigateToIntroScreen extends NavigationEvent {}

class NavigateToPostListScreen extends NavigationEvent {}

class NavigateToPostDetailScreen extends NavigationEvent {
  final String title;
  final String body;
  final int postId;

  NavigateToPostDetailScreen({
    required this.title,
    required this.body,
    required this.postId,
  });

  @override
  List<Object> get props => [title, body, postId];
}

class NavigateBack extends NavigationEvent {}

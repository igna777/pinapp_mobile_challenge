// Bloc de navegación
import '_navigation.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(IntroScreenState()) {
    on<NavigateToListScreen>((event, emit) => emit(ListScreenState()));
    on<NavigateToIntroScreen>((event, emit) => emit(IntroScreenState()));
    on<NavigateToPostListScreen>((event, emit) => emit(PostListScreenState()));

    on<NavigateToPostDetailScreen>((event, emit) {
      emit(PostDetailScreenState(
        title: event.title,
        body: event.body,
        postId: event.postId, //  Pasar el postId
      ));
    });

    on<NavigateBack>((event, emit) {
      emit(PostListScreenState()); //  Regresa a la lista de posts
    });
  }
}

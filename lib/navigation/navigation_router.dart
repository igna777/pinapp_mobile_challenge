import '_navigation.dart';

class NavigationRouter {
  static Widget buildNavigation(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        if (state is ListScreenState) {
          return const PinAppPostListScreen();
        }
        if (state is PostListScreenState) {
          return const PinAppPostListScreen();
        }
        if (state is PostDetailScreenState) {
          return PinAppPostDetailScreen(
            title: state.title,
            body: state.body,
            postId: state.postId, //  Agregar el postId
          );
        }
        return const PinAppIntroScreen();
      },
    );
  }
}

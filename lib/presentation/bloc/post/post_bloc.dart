import '_post.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPosts getPosts;
  List<PostEntity> allPosts = [];
  Set<int> likedPosts = {}; //Set para los likes

  PostBloc({required this.getPosts}) : super(PostInitial()) {
    on<LoadPosts>((event, emit) async {
      emit(PostLoading());
      try {
        allPosts = await getPosts();
        emit(PostLoaded(posts: allPosts, likedPosts: likedPosts));
      } catch (e) {
        emit(PostError(message: e.toString()));
      }
    });

    on<FilterPosts>((event, emit) {
      if (event.query.isEmpty) {
        emit(PostLoaded(posts: allPosts, likedPosts: likedPosts));
      } else {
        final filteredPosts = allPosts
            .where((post) =>
                post.title.toLowerCase().contains(event.query.toLowerCase()))
            .toList();
        emit(PostLoaded(posts: filteredPosts, likedPosts: likedPosts));
      }
    });

    on<ToggleLike>((event, emit) {
      // Alternamos el estado del "like"
      final updatedLikedPosts = Set<int>.from(likedPosts);
      if (updatedLikedPosts.contains(event.postId)) {
        updatedLikedPosts.remove(event.postId);
      } else {
        updatedLikedPosts.add(event.postId);
      }

      likedPosts = updatedLikedPosts; // Actualizamos el Set

      emit(PostLoaded(posts: allPosts, likedPosts: likedPosts));
    });
  }
}

import '_screens.dart';

class PinAppPostListScreen extends StatelessWidget {
  const PinAppPostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Asegurar que los posts se cargan al entrar
    context.read<PostBloc>().add(LoadPosts());

    return Scaffold(
      backgroundColor: PinappColors.background,
      appBar: AppBar(
        title: const Text(PinappStrings.postListTitle),
        backgroundColor: PinappColors.primary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Column(
          children: [
            PostSearchBar(onSearch: (query) {
              context.read<PostBloc>().add(FilterPosts(query: query));
            }),
            Expanded(
              child: BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  if (state is PostLoading) {
                    return const Center(
                        child: CircularProgressIndicator(
                      backgroundColor: PinappColors.primary,
                      color: PinappColors.accent,
                    ));
                  } else if (state is PostLoaded) {
                    if (state.posts.isEmpty) {
                      return const NoResultsWidget(); //No hay resultados
                    }
                    return PostList(posts: state.posts);
                  } else if (state is PostError) {
                    return Center(
                        child: Text("${PinappStrings.error} ${state.message}"));
                  } else {
                    return const Center(child: Text(PinappStrings.noPosts));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

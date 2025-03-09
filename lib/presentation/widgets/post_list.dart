import '_widgets.dart';

class PostList extends StatelessWidget {
  final List<PostEntity> posts;

  const PostList({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        Set<int> likedPosts = {};
        if (state is PostLoaded) {
          likedPosts = state.likedPosts;
        }

        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            final isLiked = likedPosts.contains(post.id);

            return Card(
              color: PinappColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(
                  post.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: PinappColors.accent,
                  ),
                ),
                subtitle: Text(
                  post.body,
                  style: const TextStyle(color: PinappColors.black),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 🔥 Botón de Like que se actualiza instantáneamente
                    IconButton(
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color:
                            isLiked ? PinappColors.accent : PinappColors.grey,
                      ),
                      onPressed: () {
                        context
                            .read<PostBloc>()
                            .add(ToggleLike(postId: post.id));
                      },
                    ),
                    const Icon(Icons.arrow_forward_ios,
                        color: PinappColors.primary),
                  ],
                ),
                onTap: () {
                  context.read<NavigationBloc>().add(
                        NavigateToPostDetailScreen(
                          title: post.title,
                          body: post.body,
                          postId: post.id,
                        ),
                      );
                },
              ),
            );
          },
        );
      },
    );
  }
}

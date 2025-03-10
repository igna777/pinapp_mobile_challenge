import '_screens.dart';

class PinAppPostDetailScreen extends StatefulWidget {
  final String title;
  final String body;
  final int postId;

  const PinAppPostDetailScreen({
    super.key,
    required this.title,
    required this.body,
    required this.postId,
  });

  @override
  State<PinAppPostDetailScreen> createState() => _PinAppPostDetailScreenState();
}

class _PinAppPostDetailScreenState extends State<PinAppPostDetailScreen> {
  List<Map<String, String>> comments = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  Future<void> _loadComments() async {
    try {
      final fetchedComments = await NativeCommentsService.fetchComments(widget.postId);
      setState(() {
        comments = fetchedComments;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PinappColors.background,
      appBar: AppBar(
        title: const Text(PinappStrings.postDetailTitle),
        backgroundColor: PinappColors.primary,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.read<NavigationBloc>().add(NavigateBack()),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título del post
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: PinappColors.accent,
                ),
              ),
              const SizedBox(height: 10),
              // Cuerpo del post
              Text(
                widget.body,
                style: const TextStyle(
                  fontSize: 16,
                  color: PinappColors.white,
                ),
              ),
              const SizedBox(height: 20),
              // Sección de comentarios
              const Text(
                PinappStrings.sectionComments,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PinappColors.primary,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        backgroundColor: PinappColors.primary,
                        color: PinappColors.accent,
                      ))
                    : errorMessage.isNotEmpty
                        ? Center(
                            child: Text(
                              errorMessage,
                              style: const TextStyle(color: PinappColors.accent),
                            ),
                          )
                        : ListView.builder(
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              final comment = comments[index];
                              return Card(
                                color: PinappColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: ListTile(
                                  title: Text(
                                    comment["name"] ?? PinappStrings.unknownUser,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: PinappColors.accent,
                                    ),
                                  ),
                                  subtitle: Text(
                                    comment["body"] ?? PinappStrings.emptyComment,
                                    style: const TextStyle(color: PinappColors.black),
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

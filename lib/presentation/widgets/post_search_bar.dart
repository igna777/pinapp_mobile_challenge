import '_widgets.dart';

class PostSearchBar extends StatelessWidget {
  final Function(String) onSearch;

  const PostSearchBar({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextField(
        decoration: InputDecoration(
          hintText: PinappStrings.searchHintText,
          filled: true,
          fillColor: PinappColors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Icon(Icons.search, color: PinappColors.primary),
        ),
        style: const TextStyle(color: PinappColors.black),
        onChanged: onSearch,
      ),
    );
  }
}

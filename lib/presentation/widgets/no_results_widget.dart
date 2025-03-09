import '_widgets.dart';

class NoResultsWidget extends StatelessWidget {
  const NoResultsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 60, color: PinappColors.white),
          SizedBox(height: 10),
          Text(
            PinappStrings.noResults,
            style: TextStyle(fontSize: 18, color: PinappColors.white),
          ),
        ],
      ),
    );
  }
}

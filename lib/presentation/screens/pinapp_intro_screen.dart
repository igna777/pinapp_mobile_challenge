import '_screens.dart';

class PinAppIntroScreen extends StatelessWidget {
  const PinAppIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PinappColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Imagen
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset(
                PinappAssetsRoutes.logo,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            // Título
            const Text(
              PinappStrings.introTitle,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: PinappColors.accent,
              ),
            ),
            const SizedBox(height: 40),
            // Botón de inicio con Bloc
            ElevatedButton(
              onPressed: () {
                context.read<NavigationBloc>().add(NavigateToListScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: PinappColors.accent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                PinappStrings.introButton,
                style: TextStyle(
                  fontSize: 18,
                  color: PinappColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

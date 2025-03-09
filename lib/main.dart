import '_main.dart';

void main() {
  final di = DependencyInjection();
  runApp(MyApp(dependencyInjection: di));
}

class MyApp extends StatelessWidget {
  final DependencyInjection dependencyInjection;

  const MyApp({super.key, required this.dependencyInjection});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationBloc()),
        BlocProvider(
          create: (_) => PostBloc(getPosts: dependencyInjection.getPosts),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Builder(
          builder: (context) => NavigationRouter.buildNavigation(context),
        ),
      ),
    );
  }
}

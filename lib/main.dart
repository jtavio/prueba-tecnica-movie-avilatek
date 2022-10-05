import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pruebamovieavilatek/src/api/http_services.dart';
import 'package:pruebamovieavilatek/src/blocs/bloc.dart';
import 'package:pruebamovieavilatek/src/blocs/simple_bloc_observer.dart';
import 'package:pruebamovieavilatek/src/pages/detail/detailMovieScreen.dart';
import 'package:pruebamovieavilatek/src/pages/home/homeScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pruebamovieavilatek/src/pages/profile/profile_actor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => GetAllMovieBloc(httpServices: HttpServices()),
      ),
      BlocProvider(
        create: (context) => CreditsMovieBloc(httpServices: HttpServices()),
      ),
      BlocProvider(
        create: (context) => PersonBloc(httpServices: HttpServices()),
      ),
      BlocProvider(
        create: (context) =>
            MovieCreditsPersonBloc(httpServices: HttpServices()),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.baloo2TextTheme(
        Theme.of(context).textTheme,
      )),
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomeScreen(),
        'details': (_) => const DetailsMovieScreen(),
        'profile': (_) => const ProfileActorScreen(),
      },
    );
  }
}

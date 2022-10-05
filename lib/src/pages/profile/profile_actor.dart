import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pruebamovieavilatek/src/blocs/bloc.dart';
import 'package:pruebamovieavilatek/src/models/movie_credits.dart';
import 'package:pruebamovieavilatek/src/widgets/image_card_credits.dart';

class ProfileActorScreen extends StatefulWidget {
  const ProfileActorScreen({super.key});

  @override
  State<ProfileActorScreen> createState() => _ProfileActorScreenState();
}

class _ProfileActorScreenState extends State<ProfileActorScreen> {
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  Cast? cast;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cast = ModalRoute.of(context)!.settings.arguments as Cast;
    BlocProvider.of<PersonBloc>(context).getPersonBio(cast!.id!);
    Future.delayed(
      const Duration(seconds: 5),
      () => BlocProvider.of<MovieCreditsPersonBloc>(context)
          .getMovieCreditsPersonId(cast!.id!),
    );
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: InkWell(
            child: const Image(
                image: AssetImage('assets/down.png'), width: 30, height: 30),
            onTap: () {
              BlocProvider.of<MovieCreditsPersonBloc>(context)
                  .add(DeleteMoviesPersonCreditsEvent());
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeadActor(cast: cast),
              const SizedBox(
                height: 17,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Casted on',
                  style: GoogleFonts.baloo2(
                    color: Colors.black,
                    fontSize: 36.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              BlocBuilder<MovieCreditsPersonBloc, MovieCreditsPersonState>(
                  builder: (context, state) {
                if (state.moviePersonCredits == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state.moviePersonCredits!.isNotEmpty) {
                  return Flexible(
                    child: StaggeredGridView.countBuilder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      itemCount: state.moviePersonCredits!.length,
                      crossAxisCount: 4,
                      mainAxisSpacing: 30.0,
                      crossAxisSpacing: 20.0,
                      staggeredTileBuilder: (index) =>
                          const StaggeredTile.fit(2),
                      itemBuilder: (context, index) => ImageCardCredits(
                          imageData: state.moviePersonCredits![index]),
                    ),
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

class HeadActor extends StatelessWidget {
  const HeadActor({
    Key? key,
    required this.cast,
  }) : super(key: key);

  final Cast? cast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: cast!.id!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: FadeInImage(
                image: NetworkImage(cast!.fullPosterImg),
                placeholder: const AssetImage('assets/jar-loading.gif'),
                fit: BoxFit.cover,
                width: 63,
                height: 63,
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInRight(
                    child: Text(
                      cast!.name!,
                      style: GoogleFonts.baloo2(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  BlocBuilder<PersonBloc, PersonState>(
                    builder: (context, state) {
                      if (state.people == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state.people!.biography != null) {
                        return FadeInRight(
                          child: SizedBox(
                            width: 256,
                            child: Text(
                              state.people!.biography!,
                              style: GoogleFonts.baloo2(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 5,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

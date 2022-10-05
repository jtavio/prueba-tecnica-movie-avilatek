import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pruebamovieavilatek/src/blocs/bloc.dart';
import 'package:pruebamovieavilatek/src/models/movie_credits.dart';
import 'package:pruebamovieavilatek/src/models/movie_popular.dart';

class DetailsMovieScreen extends StatefulWidget {
  const DetailsMovieScreen({super.key});

  @override
  State<DetailsMovieScreen> createState() => _DetailsMovieScreenState();
}

class _DetailsMovieScreenState extends State<DetailsMovieScreen> {
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  late Result movie;
  bool isShowActors = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    movie = ModalRoute.of(context)!.settings.arguments as Result;
    BlocProvider.of<CreditsMovieBloc>(context).getMovieCreditsId(movie.id!);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            InkWell(
              onTap: () async {
                setState(() {
                  isShowActors = !isShowActors;
                });
              },
              child: Hero(
                tag: movie.id!,
                child: SizedBox(
                  // width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  child: Image(
                    image: NetworkImage(movie.fullPosterImg
                        // 'https://media0.giphy.com/media/10khKaHKOP2mZ2/giphy.gif?cid=fdd78afabhgp9qvzsxpoqsjoskdxqd3xgd4hjqu8r2o9kb29&rid=giphy.gif&ct=g',
                        ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 20.0),
                child: InkWell(
                  child: const Image(
                      image: AssetImage('assets/cancel.png'),
                      width: 30,
                      height: 30),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            !isShowActors ? SizedBox() : MainContent(movie: movie),
          ],
        ),
      ),
    );
  }
}

class MainContent extends StatelessWidget {
  Result movie;
  MainContent({
    required this.movie,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: 260,
        color: const Color.fromARGB(100, 22, 44, 33),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                movie.title!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 42.0,
                  fontWeight: FontWeight.w900,
                ),
                maxLines: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                '${(movie.voteAverage! * 100).toString().substring(0, 2)} % User Score',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const ShowActors(),
          ],
        ),
      ),
    );
  }
}

class ShowActors extends StatelessWidget {
  const ShowActors({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditsMovieBloc, CreditsMovieState>(
      builder: (context, state) {
        if (state.credits == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.credits!.isNotEmpty) {
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: state.credits!.length,
              itemBuilder: (context, index) {
                return _MovieCast(state.credits![index]);
              },
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class _MovieCast extends StatelessWidget {
  Cast cast;
  _MovieCast(this.cast);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () async {
          Navigator.pushNamed(context, 'profile', arguments: cast);
        },
        child: Stack(
          children: [
            Hero(
              tag: cast.id!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: FadeInImage(
                  image: NetworkImage(cast.fullPosterImg),
                  placeholder: const AssetImage('assets/jar-loading.gif'),
                  fit: BoxFit.cover,
                  width: 100,
                  height: 150,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0, left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cast.name!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    cast.character!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pruebamovieavilatek/src/blocs/bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pruebamovieavilatek/src/widgets/image_card.dart';
import 'package:pruebamovieavilatek/src/widgets/navigation_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetAllMovieBloc>(context).getPopularMovie();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          key: _scaffoldKey,
          drawer: const NavigationDrawerWidget(),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text(
              'Latest',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            leading: InkWell(
              onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              child: const Image(
                  image: AssetImage('assets/list.png'), width: 30, height: 30),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: Column(
                  children: [
                    BlocBuilder<GetAllMovieBloc, GetAllMovieState>(
                      builder: (context, state) {
                        if (state.movies == null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state.movies!.isNotEmpty) {
                          return Flexible(
                            child: StaggeredGridView.countBuilder(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 20.0),
                              itemCount: state.movies!.length,
                              crossAxisCount: 4,
                              mainAxisSpacing: 30.0,
                              crossAxisSpacing: 20.0,
                              staggeredTileBuilder: (index) =>
                                  const StaggeredTile.fit(2),
                              itemBuilder: (context, index) =>
                                  ImageCard(imageData: state.movies![index]),
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
          )),
    );
  }
}

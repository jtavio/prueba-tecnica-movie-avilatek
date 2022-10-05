import 'package:flutter/material.dart';
import 'package:pruebamovieavilatek/src/models/movie_credits_person.dart';

class ImageCardCredits extends StatelessWidget {
  Cast? imageData;
  ImageCardCredits({super.key, required this.imageData});

  @override
  Widget build(BuildContext context) {
    String userScore = (imageData!.voteAverage! * 100).toString();
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: FadeInImage(
                image: NetworkImage(imageData!.fullPosterImg),
                fit: BoxFit.cover,
                placeholder: const AssetImage('assets/jar-loading.gif'),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0, left: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                imageData!.title!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                '${userScore.substring(0, 2)} % User Score',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

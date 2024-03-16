import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

ratingWidget(double size) {
  return RatingBar.builder(
    initialRating: 3,
    minRating: 1,
    ignoreGestures: true,
    direction: Axis.horizontal,
    allowHalfRating: true,
    itemCount: 5,
    itemSize: size,
    unratedColor: const Color(0xffDADADB),
    // itemPadding: const EdgeInsets.symmetric(horizontal: .5),
    itemBuilder: (context, _) => const Icon(
      Icons.star,
      color: Colors.amber,
    ),
    onRatingUpdate: (rating) {
      print(rating);
    },
  );
}

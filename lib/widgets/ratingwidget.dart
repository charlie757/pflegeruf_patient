import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

ratingWidget(
    {required double size,
    required double initalRating,
    required bool isGesture}) {
  return RatingBar.builder(
    initialRating: initalRating,
    minRating: 1,
    ignoreGestures: isGesture,
    direction: Axis.horizontal,
    allowHalfRating: false,
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

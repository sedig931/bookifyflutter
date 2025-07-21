import 'package:flutter/material.dart';
const primeLightBackColor = Color(0xFF32367D);
// Color(0xff464646)

List<Icon> ratingStars (rating,iconSize) {
  var stars =<Icon> [];
  for(var i = 0 ; i < rating; i++){
    if(i + 1 == rating){
      stars.add(Icon(Icons.star_half,size: iconSize,color: Color(0xFF514746),));
    }else{
      stars.add(Icon(Icons.star,size: iconSize,color: Color(0xFF514746),));
    }
  }
  return stars;
}

const titleStyle = TextStyle(
  fontSize: 19.0,
  // fontWeight: FontWeight.bold,
  fontFamily: 'Ubuntu-Med',
  color:Color(0xFF514746),
);
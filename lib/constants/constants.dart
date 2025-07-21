import 'package:flutter/material.dart';
const primeLightBackColor = Color(0xFF32367D);
// Color(0xff464646)

List<Icon> ratingStars (rating) {
  var stars =<Icon> [];
  for(var i = 0 ; i < rating; i++){
    if(i + 1 == rating){
      stars.add(Icon(Icons.star_half,size: 14.0,));
    }else{
      stars.add(Icon(Icons.star,size: 14.0,));
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




// decoration: BoxDecoration(
// color: Color(0xFF1c1c1e),
// border: Border.all(
// width: 2,
// color: txtInputBorderColor
// ),
// borderRadius: BorderRadius.all(Radius.circular(15.0)),
// shape: BoxShape.rectangle
// ),

// const KInputDecoration = InputDecoration(
//   contentPadding:
//   EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//   border: OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//   ),
//   enabledBorder: OutlineInputBorder(
//     borderSide:
//     BorderSide(color: Colors.lightBlueAccent, width: 1.0),
//     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//   ),
//   focusedBorder: OutlineInputBorder(
//     borderSide:
//     BorderSide(color: Colors.lightBlueAccent, width: 2.0),
//     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//   ),
// );
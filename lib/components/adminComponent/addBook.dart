import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/constants.dart';
import '../../modal/dataBaseAuth.dart';
class Addbook extends StatefulWidget {
  const Addbook({super.key});

  @override
  State<Addbook> createState() => _AddbookState();
}
class _AddbookState extends State<Addbook> {
  final _firestore = FirebaseFirestore.instance;
  AuthController authController = AuthController();
  var bookTitle = "";
  var bookAuthor = "";
  var bookRating = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 25.0,left: 15.0,right: 15.0),
        child: Column(
          children: [
            SizedBox(
              height: 45.0,
              child: TextField(
                onChanged: (value){
                  bookTitle = value;
                },
                style: TextStyle(fontSize: 17,color: primeLightBackColor),
                cursorColor: primeLightBackColor,
                cursorHeight: 18,
                decoration: InputDecoration(
                  hintText: 'Book Title',
                  hintStyle: TextStyle(fontSize: 15.0,color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primeLightBackColor, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.0,),
            SizedBox(
              height: 45.0,
              child: TextField(
                onChanged: (value){
                  bookAuthor = value;
                },
                style: TextStyle(fontSize: 17,color: primeLightBackColor),
                cursorColor: primeLightBackColor,
                cursorHeight: 18,
                decoration: InputDecoration(
                  hintText: 'Book Author',
                  hintStyle: TextStyle(fontSize: 15.0,color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primeLightBackColor, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
              ),
            ),SizedBox(height: 15.0,),
            SizedBox(
              height: 45.0,
              child: TextField(
                onChanged: (value){
                  bookRating = value;
                },
                style: TextStyle(fontSize: 17,color: primeLightBackColor),
                cursorColor: primeLightBackColor,
                cursorHeight: 18,
                decoration: InputDecoration(
                  hintText: 'Rating , 2 - 5',
                  hintStyle: TextStyle(fontSize: 15.0,color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primeLightBackColor, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.0,),
            Container(
              width: 250.0,
              child: Material(
                color:primeLightBackColor,
                borderRadius: BorderRadius.circular(10.0),
                elevation: 0.0,
                child: Container(
                  height: 35.0,
                  // width: 70.0,
                  child: MaterialButton(
                      padding: EdgeInsets.all(0.0),
                      onPressed: ()async {
                        // print("$bookAuthor $bookTitle $bookRating");
                        await authController.addBook(title: bookTitle, author: bookAuthor, rating: bookRating, status: 'available');
                        Navigator.pop(context);
                      },
                      child: Text('Add',style: TextStyle(color: Colors.white,fontSize: 16.0))
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

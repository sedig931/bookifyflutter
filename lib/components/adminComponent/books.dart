import 'package:flutter/material.dart';
import '../../constants/constants.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../modal/dataBaseAuth.dart';
class Books extends StatefulWidget {
  const Books({super.key});

  @override
  State<Books> createState() => _Books();
}

class _Books extends State<Books> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final _firestore = FirebaseFirestore.instance;
  AuthController authController = AuthController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return
        Column(
          children: [
            Row(
              children: [
                Text("All Books ",style: titleStyle,)
              ],
            ),
            StreamBuilder<QuerySnapshot>(stream: authController.getBooks(), builder: (context,snapshot){
              if(snapshot.hasData){
                List booksList = snapshot.data!.docs;
                 return ListView.builder(
                     shrinkWrap: true,
                     physics: ClampingScrollPhysics(),
                    itemCount: booksList.length,
                    itemBuilder: (context,index){
                  DocumentSnapshot document = booksList[index];
                  String docID = document.id;
                  Map<String,dynamic> data = document.data() as Map<String,dynamic>;
                  String title  = data['title'];
                  String author  = data['author'];
                  String rating  = data['rating'];

                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 250.0,
                          width: 220.0,
                          decoration: BoxDecoration(
                              // color: Color(0xffdfdfdf),
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              shape: BoxShape.rectangle
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 150.0,
                                width: 150.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                    image: DecorationImage(
                                      image: AssetImage('images/loginImg.png'),
                                      fit: BoxFit.fill, // Change this to fit the container
                                      )
                                ),
                              ),
                              Text(title,style: TextStyle(fontSize: 17.0,fontFamily: 'Ubuntu-Med'),),
                              Text(author,style: TextStyle(fontSize: 14.0,fontFamily: 'Ubuntu',),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: ratingStars(int.parse(rating)),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
              }else {
                return Text("no books");
              }
            }),
          ],
        );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../modal/dataBaseAuth.dart';
import '../../modal/sharedData.dart';
class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  AuthController authController = AuthController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0,left: 15.0,right: 15.0),
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Material(
                    color:Color(0xffdfdfdf),
                    borderRadius: BorderRadius.circular(50.0),
                    elevation: 0.0,
                    child: Container(
                      height: 35.0,
                      width: 35.0,
                      child: MaterialButton(
                          padding: EdgeInsets.all(0.0),
                          onPressed: () {
                            _auth.signOut();
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Icon(Icons.logout,size: 15.0,color: primeLightBackColor,)
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 45.0,
                    padding:  EdgeInsets.only(left: 20.5,top: 1,bottom: 1,right: 20.5),
                    decoration: BoxDecoration(
                        color: Color(0xffdfdfdf),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        shape: BoxShape.rectangle
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 30.0,
                        decoration: BoxDecoration(
                          color:primeLightBackColor,
                            borderRadius: BorderRadius.all(Radius.circular(18.0)),
                            shape: BoxShape.rectangle
                        ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(Provider.of<sharedData>(context).activeUser['name'],style: TextStyle(color: Colors.white,fontSize: 16.0,fontFamily: 'Ubuntu')),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: GestureDetector(
                    onTap: ()=>{
                      Navigator.pushNamed(context, '/userHome')
                    },
                    child: CircleAvatar(
                      radius:22.0,
                      foregroundColor: Colors.white,
                      backgroundColor: primeLightBackColor,
                      child: Text(Provider.of<sharedData>(context).activeUser['name'][0],style: TextStyle(color: Colors.white,fontSize: 13.0,fontFamily: 'Ubuntu'),),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.0,),
            Text('Book Rental By You',style: titleStyle,),
            StreamBuilder<QuerySnapshot>(stream: authController.getUserRentalBook(), builder: (context,snapshot){
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
                      String bookId  = data['bookID'];
                      String userID = data['userID'];
                      if(userID == Provider.of<sharedData>(context).activeUser['id']) {
                        return ListTile(
                          title: StreamBuilder<QuerySnapshot>(stream: authController.getBooks(), builder: (context,snapshot){
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
                                    String status  = data['status'];
                                    String rating  = data['rating'];
                                    if(docID == bookId) {
                                      return ListTile(
                                        title: GestureDetector(
                                          onTap:() {
                                            Provider.of<sharedData>(context,listen: false).setActiveBookID(docID);
                                            Navigator.pushNamed(context, '/singleBook');
                                          },
                                          child: Container(
                                            height: 300.0,
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
                                                Text(title,style: TextStyle(color:Color(0xFF514746),fontSize: 17.0,fontFamily: 'Ubuntu-Med'),),
                                                SizedBox(height: 3.0,),
                                                Text(author,style: TextStyle(fontSize: 14.0,color: Color(0xFF514746),fontFamily: 'Ubuntu',),),
                                                SizedBox(height: 3.0,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: ratingStars(int.parse(rating),14.0),
                                                ),
                                                SizedBox(height: 15.0,),
                                                status == 'rent' ?
                                                Container(
                                                    height: 28.0,
                                                    width: 150.0,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF5ebf5b),
                                                      borderRadius: BorderRadius.all(Radius.circular(11.0)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text('Rent for you',style: TextStyle(color: Colors.white,fontSize: 14.0,fontFamily: 'Ubuntu'),),
                                                      ],
                                                    )
                                                ): status == 'pended' ?
                                                Container(
                                                    height: 28.0,
                                                    width: 150.0,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xffdfdfdf),
                                                      borderRadius: BorderRadius.all(Radius.circular(11.0)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text('Pended',style: TextStyle(color: Color(0xFF514746),fontSize: 14.0,fontFamily: 'Ubuntu'),),
                                                      ],
                                                    )
                                                ) : Text(''),
                                                SizedBox(height: 15.0,),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }else return SizedBox(height: 1.0,);
                                  }
                              );
                            }else {
                              return Text("no books");
                            }
                          }),
                        );
                      }
                    }
                );
              }else {
                return Text("no books");
              }
            }),
          ],
        ),
      ),
    );
  }
}

import 'package:bookify_app/components/adminComponent/books.dart';
import 'package:bookify_app/modal/sharedData.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final _firestore = FirebaseFirestore.instance;
  late final userId;
  late String userEmail ;
  var searchWord = '';

  void searchBook (){
    print(searchWord);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children:[Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        padding:  EdgeInsets.only(left: 20.5,top: 1,bottom: 1,right: 20.5),
                        decoration: BoxDecoration(
                          color: Color(0xffdfdfdf),
                            borderRadius: BorderRadius.all(Radius.circular(25.0)),
                            shape: BoxShape.rectangle
                        ),
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.search,color: primeLightBackColor,),
                            Expanded(
                              child: TextField(
                                    style: TextStyle(color: primeLightBackColor),
                                      onChanged: (value) {
                                      searchWord = value;
                                      },
                                      decoration: InputDecoration(
                                        contentPadding:
                                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                        border: InputBorder.none,
                                        hintText: "Search",
                                        hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Ubuntu',fontSize: 16.0),
                                      )
                                  ),
                            ),
                            Material(
                              color:primeLightBackColor,
                              borderRadius: BorderRadius.circular(25.0),
                              elevation: 0.0,
                              child: Container(
                                height: 35.0,
                                width: 70.0,
                                child: MaterialButton(
                                    padding: EdgeInsets.all(0.0),
                                    onPressed: searchBook,
                                    child: Text('search',style: TextStyle(color: Colors.white,fontSize: 16.0,fontFamily: 'Ubuntu'))
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: CircleAvatar(
                        radius:22.0,
                        foregroundColor: Colors.white,
                        backgroundColor: primeLightBackColor,
                        child: Text(Provider.of<sharedData>(context).activeUser['name'][0],style: TextStyle(color: Colors.white,fontSize: 13.0,fontFamily: 'Ubuntu'),),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25.0,),
              Books(),
                //   books shows here...
              ],
            ),
          )],
        ),
      ),
    );
  }
}

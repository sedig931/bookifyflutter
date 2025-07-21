import 'package:bookify_app/components/adminComponent/addBook.dart';
import 'package:bookify_app/components/adminComponent/books.dart';
import 'package:bookify_app/components/adminComponent/rentalOrder.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '../modal/sharedData.dart';
class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('admin - ${Provider.of<sharedData>(context).activeUser['name']}',style: TextStyle(color:Color(0xFF514746),fontSize: 18.0,fontFamily: 'Ubuntu'),),
        centerTitle: true,
        leadingWidth: 60.0,
        leading: Row(
          children: [
            SizedBox(width: 15.0,),
            CircleAvatar(
              backgroundColor: Color(0xffdfdfdf),
              child: MaterialButton(
              padding: EdgeInsets.all(0.0),
              onPressed: () {
                _auth.signOut();
                Navigator.pushNamed(context, '/login');
              },
              child: Icon(Icons.logout,size: 15.0,color: primeLightBackColor,)
                  ),
            ),
          ],
        ),
        actionsPadding: EdgeInsets.only(right: 15.0),
        actions: [
          CircleAvatar(
            radius: 20.0,
            backgroundColor: primeLightBackColor,
            child: Text(Provider.of<sharedData>(context).activeUser['name'][0],style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            // shrinkWrap: true,
            // shrinkWrap: true,
            // physics: ClampingScrollPhysics(),
            children: [
              Material(
                color:primeLightBackColor,
                borderRadius: BorderRadius.circular(15.0),
                elevation: 0.0,
                child: Container(
                  height: 45.0,
                  child: MaterialButton(
                      padding: EdgeInsets.all(0.0),
                      onPressed: (){
                        showModalBottomSheet(context: context,builder:(context) => Addbook());
                      },
                      child: Text('Add New Book',style: TextStyle(color: Colors.white,fontSize: 16.0,fontFamily: 'Ubuntu'))
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              RentalOrder(),
              SizedBox(height: 20.0,),
              Books()
            ],
          ),
        ),
      ),
    );
  }
}

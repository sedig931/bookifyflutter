import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../modal/dataBaseAuth.dart';
class RentalOrder extends StatefulWidget {
  const RentalOrder({super.key});

  @override
  State<RentalOrder> createState() => _RentalOrderState();
}

class _RentalOrderState extends State<RentalOrder> {
  AuthController authController = AuthController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Rental Oreder ",style: titleStyle,)
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
                  String status = data['status'];
                  if(status == 'pending'){
                  return ListTile(
                    title: Container(
                      height: 250.0,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 150.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                image: DecorationImage(
                                  image: AssetImage('images/loginImg.png'),
                                  fit: BoxFit.fill, // Change this to fit the container
                                )
                            ),
                          ),
                          Text(title),
                          Text(author),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: ratingStars(int.parse(rating)),
                          )
                        ],
                      ),
                    ),
                  );}
                });
          }else {
            return Text("no books");
          }
        }),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../modal/dataBaseAuth.dart';
class PendingOrder extends StatefulWidget {
  const PendingOrder({super.key});

  @override
  State<PendingOrder> createState() => _PendingOrderState();
}

class _PendingOrderState extends State<PendingOrder> {
  AuthController authController = AuthController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Pending Orders ",style: titleStyle,)
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
                  String status  = data['status'];
                  String rating  = data['rating'];
                  if(status == 'pended') {
                    return ListTile(
                      title: Container(
                        height: 60.0,
                        width:double.infinity,
                        decoration: BoxDecoration(
                          // color: Color(0xffdfdfdf),
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            shape: BoxShape.rectangle
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 55.0,
                              width: 55.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                  image: DecorationImage(
                                    image: AssetImage('images/loginImg.png'),
                                    fit: BoxFit.fill, // Change this to fit the container
                                  )
                              ),),
                            Text(title, style: TextStyle(fontSize: 14.0, fontFamily: 'Ubuntu',color: Color(0xFF514746)),),
                            Text(status,style: TextStyle(fontSize: 14.0, fontFamily: 'Ubuntu',color: Color(0xFF514746)),),
                            // status == 'pended' ?
                            Material(
                              color:Color(0xFF5ebf5b),
                              borderRadius: BorderRadius.circular(5.0),
                              elevation: 0.0,
                              child: Container(
                                width: 60.0,
                                height: 25.0,
                                child: MaterialButton(
                                    padding: EdgeInsets.all(0.0),
                                    onPressed: ()  async{
                                      try{
                                        await authController.updateBook(docID,
                                          {
                                            'title': title,
                                            'author':author,
                                            'rating':rating,
                                            'status':'rent'
                                          },
                                        );
                                      }catch(e){
                                        print(e.toString());
                                      }
                                    },
                                    child: Text('Approve',style: TextStyle(color: Colors.white,fontSize: 12.0,fontFamily: 'Ubuntu'))
                                ),
                              ),
                            )
                                // : Text(''),
                          ],
                        ),
                      ),
                    );
                  }
                }
            );
          }else {
            return Text("no books");
          }
        }),
      ],
    );
  }
}

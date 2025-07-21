import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../modal/dataBaseAuth.dart';
import '../constants/constants.dart';
import '../modal/sharedData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  AuthController authController = AuthController();
  Map<String, dynamic> book = {
    'title': '',
    'auther':'',
    'rating':'',
    'status':''
  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70.0,
        leading:Padding(
          padding: const EdgeInsets.only(left: 25.0),
                  child: GestureDetector(
                      onTap: (){Navigator.pop(context);},
                      child: Icon(Icons.arrow_back_ios_new,size: 25.0,color: primeLightBackColor,))
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: StreamBuilder<QuerySnapshot>(stream: authController.getBooks(), builder: (context,snapshot){
          if(snapshot.hasData){
            List booksList = snapshot.data!.docs;
            var singleBook ;
            for(var book in booksList) {
              if(book.id == Provider.of<sharedData>(context).activeBookID){
                singleBook = book;
              }
            }
            String bookId  = singleBook.id;
            String title  = singleBook['title'];
            String author  = singleBook['author'];
            String status  = singleBook['status'];
            String rating  = singleBook['rating'];
            return
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 450.0,
                      decoration: BoxDecoration(
                        // color: Color(0xffdfdfdf),
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          shape: BoxShape.rectangle
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                  image: DecorationImage(
                                    image: AssetImage('images/loginImg.png'),
                                    fit: BoxFit.fill, // Change this to fit the container
                                  )
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(title,style: TextStyle(fontSize: 25.0,fontFamily: 'Ubuntu-Med'),),
                              SizedBox(height: 5.0,),
                              Text(author,style: TextStyle(fontSize: 20.0,fontFamily: 'Ubuntu',),),
                              SizedBox(height: 5.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: ratingStars(int.parse(rating),20.0),
                              ),
                              SizedBox(height: 15.0,),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    status == "available" ?
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
                            Text('Avalible To Rent',style: TextStyle(color: Colors.white,fontSize: 14.0,fontFamily: 'Ubuntu'),),
                          ],
                        )
                    ) : Container(
                        height: 28.0,
                        width: 150.0,
                        decoration: BoxDecoration(
                          color: Color(0xffee6469),
                          borderRadius: BorderRadius.all(Radius.circular(11.0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Not Avalible',style: TextStyle(color: Colors.white,fontSize: 14.0,fontFamily: 'Ubuntu'),),
                          ],
                        )
                    ),
                    SizedBox(height: 15.0,),
                    // SizedBox(height: 15.0,),
                    status == "available" && Provider.of<sharedData>(context).activeUser['role'] != 'admin'?
                    Material(
                      color:primeLightBackColor,
                      borderRadius: BorderRadius.circular(15.0),
                      elevation: 0.0,
                      child: Container(
                        width: double.infinity,
                        height: 37.0,
                        child: MaterialButton(
                            padding: EdgeInsets.all(0.0),
                            onPressed: ()  async{
                              try{
                                await authController.rentBook(singleBook.id,
                                    {
                                      'title': title,
                                      'author':author,
                                      'rating':rating,
                                      'status':'pended'
                                    },
                                    Provider.of<sharedData>(context,listen: false).activeUser['id']
                                );
                              }catch(e){
                                print(e.toString());
                              }
                            },
                            child: Text('Rent Now',style: TextStyle(color: Colors.white,fontSize: 17.0,fontFamily: 'Ubuntu'))
                        ),
                      ),
                    ) : Text(''),
                    status == "available" && Provider.of<sharedData>(context).activeUser['role'] == 'admin'?
                    Material(
                      color:Color(0xffee6469),
                      borderRadius: BorderRadius.circular(15.0),
                      elevation: 0.0,
                      child: Container(
                        width: double.infinity,
                        height: 37.0,
                        child: MaterialButton(
                            padding: EdgeInsets.all(0.0),
                            onPressed: ()  async{
                              try{
                                Navigator.pushNamed(context, '/adminHome');
                                await authController.dropBook(bookId);
                              }catch(e){
                                print(e.toString());
                              }
                            },
                            child: Text('Delete Book',style: TextStyle(color: Colors.white,fontSize: 17.0,fontFamily: 'Ubuntu'))
                        ),
                      ),
                    ) : Text(''),
                    // Text( Provider.of<sharedData>(context).activeUser['id']),
                  ],
                );
          }
          else {
            return Text("no books");
          }
        }),
      ),
    );
  }
}

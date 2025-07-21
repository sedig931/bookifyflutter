import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final CollectionReference books = FirebaseFirestore.instance.collection("books");
  // login....
  Future<Object>login({
    required String email,
    required String password,
  })async {
    try {
      final UserCredential user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      DocumentSnapshot userDoc = await _firestore.
      collection("users")
          .doc(user.user!.uid)
          .get();
      // return userDoc['role'];
      return {
        'name':userDoc['name'],
        'email':userDoc['email'],
        'role':userDoc['role'],
      };

    }catch(e){
      return e.toString();
    }
  }
  // register....
  Future<String?>register({
    required String name,
    required String email,
    required String password,
  })async {
    try {
      final UserCredential newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _firestore.collection("users")
          .doc(newUser.user!.uid)
          .set(
          {
            'name':name,
            'email':email,
            'role':'admin'
          }
      );
      return null;
    }catch(e){
      return e.toString();
    }
}
// get all books...
// add book..
Future<void> addBook ({required String title,required String author ,required String rating, required String status}){
    return books.add(
        {
          'title': title,
          'auther':author,
          'rating':rating,
          'status':status
        }
    );
}

// get all books
Stream<QuerySnapshot> getBooks(){
    return books.snapshots();
}
// get rental book
//   Stream<QuerySnapshot> getRentalBooks(){
//     return books.snapshots();
//   }
}
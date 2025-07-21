import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final CollectionReference books = FirebaseFirestore.instance.collection("books");
  final CollectionReference pendedRentalBooks = FirebaseFirestore.instance.collection("pendedRentalBooks");
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
        'id':user.user!.uid
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
            'role':'user'
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
          'author':author,
          'rating':rating,
          'status':status
        }
    );
}
// drop book..
Future<void> dropBook (docid){
    return books.doc(docid).delete();
}
// update book..
  Future<String?> updateBook (bookId,bookData) async {
    try {
      await books.doc(bookId).update(bookData);
    }catch(e){
      return e.toString();
    }
  }

// get all books
Stream<QuerySnapshot> getBooks(){
    return books.snapshots();
}

// user send rent request a book
  Future<String?>rentBook(bookId,bookData,userID)async {
    try {
     await books.doc(bookId).update(bookData);
     await pendedRentalBooks.add(
         {
           'bookID':bookId,
           'userID':userID,
         }
     );
      return null;
    }catch(e){
      return e.toString();
    }
  }
  // drop book from rental collections..
  Future<String?> dropRentalBook (docid) async {
    try{

    var snapshots = await pendedRentalBooks.get();
    for (var doc in snapshots.docs) {
      // await doc.reference.delete();
      var doco = doc as Map<String,dynamic>;
      print(doco.values);
    // return pendedRentalBooks.doc(docid).delete();
    }

    }catch(e){
      return e.toString();
    }

  }
// get book to user , that rent by itself
  Stream<QuerySnapshot> getUserRentalBook(){
    return pendedRentalBooks.snapshots();
  }
}
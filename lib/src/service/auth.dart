import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_web/src/app.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<void> signInAnonymously() async {
    final result = await _auth.signInAnonymously();
    FirebaseUser user = result.user;

    //create info client
    await _createDataUser(user.uid, user.uid);

    return true;
  }

  //sign in email and password
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      App.uid = result.user.uid;

      return App.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      App.uid = result.user.uid;

      await _createDataUser(email, App.uid);

      return App.uid;

      //create info client

    } catch (e) {
      print(e.toString());
    }
  }

//  Future signInWithGoogle() async {
//    try{
//      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//      AuthCredential credential = GoogleAuthProvider.getCredential(
//        idToken: googleAuth.idToken,
//        accessToken: googleAuth.accessToken,
//      );
//
//      AuthResult result = await _auth.signInWithCredential(credential);
//      FirebaseUser user = result.user;
//
//      _updateDataUserGoogle(user.email, 'Your phone', user.uid, user.photoUrl, user.displayName);
//
//      return _userFromFirebaseUser(user);
//    }catch(e){
//      print(e.toString());
//      return null;
//    }
//  }

  Future sendPasswordResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> _createDataUser(email, uid) async {
    Firestore.instance.collection('users').document(uid).setData({
      'email': email,
      'id': uid,
      'image': '',
      'username': email.toString().substring(0, email.toString().length - 10),
      'publishAt': DateTime.now(),
      'address': '',
      'orders': '',
    });
  }

  void _createListUserGoogle(email, uid) {
    Firestore.instance.collection('usersGoogle').document(uid).setData({
      'email': email,
    });
  }

  void _updateDataUserGoogle(email, phone, uid, url, displayName) {
    DocumentReference documentReference =
        Firestore.instance.collection('usersGoogle').document(uid);

    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (snapshot.exists) {
        print("USING NOW");
      } else {
        //create nor data
        _createDataUser(email, uid);
      }
    });
  }
}


import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth firebaseAuth;

  AuthenticationService(this.firebaseAuth);

  Stream<User> get authStateChanges => firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    firebaseAuth.signOut();
    GoogleSignIn().signOut();
  }

  signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount acc = await googleSignIn.signIn();
    GoogleSignInAuthentication auth = await acc.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: auth.accessToken, idToken: auth.idToken);
    final res = await firebaseAuth.signInWithCredential(credential);
    return res.user;
  }

  signIn({String email, String password}) async {
    try {
      final res = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return res.user;
    } on FirebaseAuthException catch (e) {
      //return e.message;
      print(e.message);
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}

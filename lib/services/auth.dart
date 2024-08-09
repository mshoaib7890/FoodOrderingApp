import 'package:firebase_auth/firebase_auth.dart';

class AuthMethod {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurentUser() async {
    return await auth.currentUser;
  }

  Future SignOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future Delete() async {
    User? user = FirebaseAuth.instance.currentUser;
    user?.delete();
  }
}

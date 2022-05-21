import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, User, UserCredential;
import 'package:shosev/models/SS_User.dart' show SS_User;

class AuthService {

  final FirebaseAuth auth = FirebaseAuth.instance;

  // create user object
  SS_User? _userFromFirebaseUser(User? user/*, String username, String phoneNo*/) {
    if (user == null && user?.displayName == null && user?.phoneNumber == null) {
      return null;
    }
    
    // final DataRepository repository = DataRepository();
    if (user != null && user.phoneNumber != null && user.displayName != null) {
      SS_User SSuser = SS_User(
        uid: user.uid,
        userName: user.displayName.toString(),
        phoneNo: user.phoneNumber.toString()
      );
    // repository.add_SS_User(SSuser);
    return SSuser;
    }
    return null;
    
  }
  
  // auth change user stream
  Stream<SS_User?> get user {
    return auth.authStateChanges().map((User? user) => _userFromFirebaseUser(user));
  }

  // sign in Anonymously
  Future signInAnonylously(String username, String phoneNo) async {
    try {
      UserCredential result = await auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  // sign in with phone number on mobile
  Future<void> phoneSignIn({
    required String phoneNumber,
    required var onVerificationCompleted,
    required var onVerificationFailed,
    required var onCodeSent,
    required var onCodeTimeout}) async {
      
    // final Function _setStateOtpcontroller = setStateOtpcontroller;
    

    var _onVerificationCompleted = onVerificationCompleted;
    var _onVerificationFailed = onVerificationFailed;
    var _onCodeSent = onCodeSent;
    var _onCodeTimeout = onCodeTimeout;

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: _onVerificationCompleted,
      verificationFailed: _onVerificationFailed,
      codeSent: _onCodeSent,
      codeAutoRetrievalTimeout: _onCodeTimeout,
      timeout: const Duration(seconds: 45)
    );
  }

  // register/sign up with phone number on mobile
  Future signUpWithPhoneNumberOnMobile(String phoneNo, String otp) async {
    try {
      
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with phone number on web
  Future signInWithPhoneNumberOnWeb() async {

  }

  // register/sign up with phone number on web
  Future signUpWithPhoneNumberOnWeb(String phoneNo, String otp) async {
    try {
      
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  // sign out
  Future siginOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }
}

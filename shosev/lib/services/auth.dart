import 'package:firebase_auth/firebase_auth.dart';

import 'package:shosev/services/data_repository.dart';

import '../models/SS_User.dart';

// enum AuthState {
//   loggedOut,
//   phoneNumber,
//   register,
//   otp,
//   loggedIn
// }

class AuthService {

  final FirebaseAuth auth = FirebaseAuth.instance;

  // final String phoneNo;
  // final String username;
  // AuthService({
  //   required this.phoneNo,
  //   required this.username,
  // });

  // create user object
  // sign in Anonymously
  // sign in with phone number
  // register/sign up with phone number
  // sign out

  // create user object
  SS_User? _userFromFirebaseUser(User? user/*, String username, String phoneNo*/) {
    if (user == null && user?.displayName == null && user?.phoneNumber == null) 
      return null;
    
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
      print(e.toString());
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
      timeout: const Duration(seconds: 30)
    );
  }
  // Future signInWithPhoneNumberOnMobile(String phoneNo, String? otp, String username) async {
  //   User? user;
  //   try {
  //     await _auth.verifyPhoneNumber(
  //       phoneNumber: phoneNo,
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         // ANDROID ONLY!

  //         // Sign the user in (or link) with the auto-generated credential
  //         UserCredential result = await _auth.signInWithCredential(credential);
  //         user = result.user;
  //         result.user?.updateDisplayName(username);
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         print("verifyPhoneNumber FAILED : ");
  //         print(e.message);
  //       },
  //       codeSent: (String verificationId, int? resendToken) async {
  //         if (otp != null) {
  //           PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);
  //           UserCredential result = await _auth.signInWithCredential(credential);
  //           user = result.user;
  //           result.user?.updateDisplayName(username);
  //         }
  //         else {
  //           print("codeSent FAILED : ");
  //           print("Failed, no OTP");
  //         }
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {

  //       },
  //       timeout: const Duration(seconds: 60)
  //     );
  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print(otp);
  //     return _userFromFirebaseUser(user);
  //   }

  // }

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
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future siginOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

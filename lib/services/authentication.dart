import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/models/user.dart';
import 'package:churchappenings/pages/guest-home/guest-home-page.dart';
import 'package:churchappenings/routes.dart';
import 'package:churchappenings/services/hasura.dart';
import 'package:churchappenings/services/local_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class Authentication extends GetxController {
  static Authentication to = Get.find();
  final localData = LocalData();

  bool isMember = false;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Rxn<User> firebaseUser = Rxn<User>();
  Rxn<UserModel> userData = Rxn<UserModel>();

  // Firebase user a realtime stream
  Future<User> get getUser async => _firebaseAuth.currentUser!;
  Future<String> get getUserId async => _firebaseAuth.currentUser!.uid;

  // Firebase user a realtime stream
  Stream<User?> get user => _firebaseAuth.authStateChanges();

  @override
  void onReady() async {
    //run every time auth state changes
    ever(firebaseUser, handleAuthChange);
    firebaseUser.bindStream(user);

    super.onReady();
  }

  handleAuthChange(_firebaseUser) async {
    if (_firebaseUser == null) {
      Get.offAllNamed(Routes.splash);
    } else {
      final HasuraService hasura = HasuraService.to;
      await hasura.initializeAuthenticatedConnection();
      final ProfileAPI profileApi = ProfileAPI.to;

      await profileApi.storeProfileInLocal(await getUserId);

      var list = await profileApi.toCheckMember(profileApi.memberId!);

      if (list.length == 0) {
        Get.offAll(GuestHomePage());

        localData.setMemberStatus(false);
      } else {
        Get.offAllNamed(Routes.home);
        localData.setMemberStatus(false);
      }
    }
  }

  //Method to handle user sign in using email and password
  Future signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      update();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      UserModel _newUser = UserModel(
        uid: result.user!.uid,
        email: result.user!.email!,
        name: name,
      );

      // User storing
      final HasuraService hasura = HasuraService.to;
      await hasura.addUser(
        name: _newUser.name,
        email: _newUser.email,
        uuid: _newUser.uid,
      );

      update();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );
        UserModel _newUser = UserModel(
          uid: userCredential.user!.uid,
          email: userCredential.user!.email!,
          name: userCredential.user!.displayName ?? '',
        );

        if (userCredential.additionalUserInfo!.isNewUser) {
          // User storing
          final HasuraService hasura = HasuraService.to;
          await hasura.addUser(
            name: _newUser.name,
            email: _newUser.email,
            uuid: _newUser.uid,
          );
        }

        update();
      }
    } else {
      throw FirebaseAuthException(
        message: "Sign in aborded by user",
        code: "ERROR_ABORDER_BY_USER",
      );
    }
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
    await localData.clear();
  }

  Future resetPassword({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}

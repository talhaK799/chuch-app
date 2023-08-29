import 'package:churchappenings/constants/api.dart';
import 'package:churchappenings/utils/process_indicator.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';
import './authentication.dart';

class HasuraService extends GetxController {
  static HasuraService to = Get.find();
  final Authentication auth = Authentication.to;
  late HasuraConnect hasuraConnectAnonymus;
  late HasuraConnect hasuraConnect;
  static Circle processIndicator = Circle();

  @override
  void onReady() async {
    // Hasura Anonymous Connection
    hasuraConnectAnonymus = HasuraConnect(
      HASURA_WRITER_ENDPOINT,
      headers: {
        "content-type": "application/json",
      },
    );
    super.onReady();
  }

  Future initializeAuthenticatedConnection() async {
    try {
      await FirebaseFunctions.instanceFor(region: "us-central1")
          .httpsCallable('getJWT')
          .call();
      print("INITIALIZED");
      final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
      String token = await _firebaseAuth.currentUser!.getIdToken();
      print("Toaken----->$token");
      final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
      pattern
          .allMatches(token)
          .forEach((match) => print("match group => ${match.group(0)}"));

      hasuraConnect = HasuraConnect(
        HASURA_READER_ENDPOINT,
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer " + token,
        },
      );
      print("hasuraConnect => ${hasuraConnect.url}");
    } on FirebaseFunctionsException catch (e) {
      print("Code :" + e.code);
      // print("Details :" + e.details);
      print("Message :" + e.message.toString());
    }
  }

  Future unAuthenticationConnection() async {
    try {
      hasuraConnect = HasuraConnect(
        HASURA_READER_ENDPOINT,
        headers: {
          "content-type": "application/json",
          // "Authorization": "Bearer " + token,
        },
      );
      print("hasuraConnect => ${hasuraConnect.url}");
    } catch (e) {
      print(e);
    }
  }

  // Add user to database
  Future addUser({
    required String name,
    required String email,
    required String uuid,
  }) async {
    try {
      String mutationAddMember = """
          mutation Query(\$email: String!, \$name: String!, \$uuid: String!) {
            insert_member_one(object: {user: {data: {email: \$email, name: \$name, type: "CUSTOM", uuid: \$uuid}}}) {
              user_id
            }
          }
        """;

      await hasuraConnectAnonymus.mutation(
        mutationAddMember,
        variables: {
          'email': email,
          'name': name,
          'uuid': uuid,
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future hasuraQuery(String query,
      [Map<String, dynamic>? variables, context]) async {
    print("@hasuraQueryCalled");
    if (context != null) await processIndicator.show(context);

    try {
      final dynamic result = await hasuraConnect.query(
        query,
        variables: variables,
      );

      if (context != null) processIndicator.hide(context);

      return result;
    } catch (e) {
      if (context != null) processIndicator.hide(context);
      print("errror=> $e");
    }
  }

  Future hasuraMutation(String query, Map<String, dynamic> variables,
      [context]) async {
    print("@hasuraMutationCalled");
    if (context != null) await processIndicator.show(context);

    try {
      final dynamic result = await hasuraConnect.mutation(
        query,
        variables: variables,
      );

      if (context != null) processIndicator.hide(context);

      return result;
    } catch (e) {
      if (context != null) processIndicator.hide(context);
      print(e);
    }
  }
}

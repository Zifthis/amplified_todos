import 'package:amplify_flutter/amplify.dart';

class AuthRepository {
  Future<String> fetchUserIdFromAttributes() async {
    try {
      final attributes = await Amplify.Auth.fetchUserAttributes();
      final subAttribute =
          attributes.firstWhere((element) => element.userAttributeKey == 'sub');
      final userId = subAttribute.value;
      return userId;
    } catch (e) {
      rethrow;
    }
  }

  // sign in
  Future<String> webSignIn() async {
    try {
      final result = await Amplify.Auth.signInWithWebUI();
      if (result.isSignedIn) {
        //get user id
        return await fetchUserIdFromAttributes();
      } else {
        throw Exception('Could not sign in');
      }
    } catch (e) {
      rethrow;
    }
  }

  // sign out
  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  // auto sign in
  Future<String> attemptAutoSignIn() async {
    try {
      final season = await Amplify.Auth.fetchAuthSession();
      if (season.isSignedIn) {
        return await fetchUserIdFromAttributes();
      } else {
        throw Exception('Not signed in');
      }
    } catch (e) {
      rethrow;
    }
  }
}

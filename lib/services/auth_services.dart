import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_chat/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServices {
  static SupabaseClient client() {
    final supbase = Supabase.instance.client;
    return supbase;
  }

  Future<AuthResponse> googleSignIn() async {
    const webClientId =
        '231541383923-9a6r4cfvrij0l3js1cnt2pq3ltre0np9.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(serverClientId: webClientId);

    await googleSignIn.signOut();
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      throw 'Google sign-in was aborted';
    }
    final googleAuth = await googleUser.authentication;

    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null || idToken == null) {
      throw 'Missing Google auth tokens';
    }

    final authResponse = await client().auth.signInWithIdToken(
      idToken: idToken,
      provider: OAuthProvider.google,
      accessToken: accessToken,
    );
    final user = authResponse.user;
    if (user == null) {
      throw 'User information not available after sign in';
    }

    final userProfile =
        await client()
            .from('users_table')
            .select()
            .eq('uid', user.id)
            .maybeSingle();

    if (userProfile == null) {
      // Insert the new user's information into the 'profiles' table
      final userMetadata = user.userMetadata ?? {};
      final fullName = userMetadata['full_name'] as String?;
      final avatarUrl = userMetadata['avatar_url'] as String?;
      final email = user.email;

      final userModel = UserModel(
        uid: user.id,
        fullName: fullName??"N/A",
        profileUrl: avatarUrl??"N/A",
        gmail: email??"N/A",
        joinedAt: DateTime.now().toString(),
      );

      await client().from('users_table').insert(userModel.toMap());
    }

    return authResponse;
  }

  Future<void> logOut() {
    return client().auth.signOut();
  }
}

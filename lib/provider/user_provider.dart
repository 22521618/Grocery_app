import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocery_app/models/user.dart';

class UserProvider extends StateNotifier<User?> {
  // contructor initialzing with default User Object
  // Manage the state of the user object allowing updates
  UserProvider()
      : super(User(
          id: '',
          fullName: '',
          email: '',
          state: '',
          city: '',
          locality: '',
          password: '',
          token: '',
        ));
  // Getter method to extract value from an object

  User? get user => state;

  // Method to set User state from Json
  // Updates he user sate base on json String  representation of user Object

  void setUser(String userJson) {
    state = User.fromJson(userJson);
  }

  // Method to clear user state
  void signOut() {
    state = null;
  }

  void recreateUserState({
    required String state,
    required String city,
    required String locality,
  }) {
    if (this.state != null) {
      this.state = User(
        id: this.state!.id,
        fullName: this.state!.fullName,
        email: this.state!.email,
        state: state,
        city: city,
        locality: locality,
        password: this.state!.password,
        token: this.state!.token,
      );
    }
  }
}
//make the data accisible within the application

final userProvider =
    StateNotifierProvider<UserProvider, User?>((ref) => UserProvider());

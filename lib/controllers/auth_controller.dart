import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocery_app/global_variable.dart';
import 'package:grocery_app/models/user.dart';
import 'package:grocery_app/provider/user_provider.dart';
import 'package:grocery_app/services/manage_http_response.dart';
import 'package:grocery_app/views/screens/authentication_screen/login_screen.dart';
import 'package:grocery_app/views/screens/main_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final providerContainer = ProviderContainer();

class AuthController {
  Future<void> signUpUsers({
    required context,
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        fullName: fullName,
        email: email,
        state: '',
        city: '',
        locality: '',
        password: password,
        token: '',
      );
      http.Response response = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            //set the header for the request
            "Content-Type": "application/json; chartset=UTF-8",
          });

      manageHtppResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
          showSnackBar(context, 'Account has been create for you');
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> signInUsers({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode(
          {
            'email': email,
            'password': password,
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      manageHtppResponse(
          response: response,
          context: context,
          onSuccess: () async {
            // access sharedPrefrences for token and user data storages
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            String token = jsonDecode(response.body)['token'];
            //store the authication token secuerely in sharedpreference

            await preferences.setString('auth_token', token);

            // encode the user data recied from the backend as json

            final userJson = jsonEncode(jsonDecode(response.body)['user']);
            //bỏ phần user để chạy được
            // update the application state with the user data using Riverpod
            providerContainer.read(userProvider.notifier).setUser(userJson);
            //stored data in sharedPreference for the future use

            await preferences.setString('user', userJson);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MainScreen()),
                (route) => false);
            showSnackBar(context, 'Loggin success');
          });
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> signOutUser({required context}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      //clear the token and user from SharedPreferenace
      await preferences.remove('auth_token');
      await preferences.remove('user');

      //clear the user state
      providerContainer.read(userProvider.notifier).signOut();

      //navigate the user back to the login screen
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false); // MaterialPageRoute

      showSnackBar(context, 'signout successfully');
    } catch (e) {
      showSnackBar(context, "error signing out");
    }
  }

  //Update user's state, city and locality
  Future<void> updateUserLocation({
    required context,
    required String id,
    required String state,
    required String city,
    required String locality,
  }) async {
    try {
      print("$id");
      print(state);
      print(city);
      print(locality);
      //Make an HTTP PUT request to update user's state, city and locality
      final http.Response response = await http.put(
        Uri.parse('$uri/api/users/$id'),
//set the header for the request to specify that the content is Json
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8'
        },
//Encode the update data(state, city and locality) AS Json object
        body: jsonEncode(<String, String>{
          'state': state,
          'city': city,
          'locality': locality,
        }),
      );
      manageHtppResponse(
        response: response,
        context: context,
        onSuccess: () async {
          print('vao luong');
          //Decode the updated user data from the response body
          //this converts the json String response Into Dart Map
          final updatedUser = jsonDecode(response.body);
          if (updatedUser.isEmpty) {
            print('loi user');
          }

          //Access Shared preference for local data storage
          //shared preferences allow us to store data persistently on the device
          SharedPreferences preferences = await SharedPreferences.getInstance();
          //Encode the update user data as json String
          //this prepares the data for storage in shared preference
          final userJson = jsonEncode(updatedUser);
          if (userJson.isEmpty) {
            print('loi userJson');
          }

          //update the application state with the updated user data userin Riverpod
          //this ensures the app reflects the most recent user data
          providerContainer.read(userProvider.notifier).setUser(userJson);

          //store the updated user data in shared preference for future user
          //this allows the app to retrieve the user data even after the app restarts
          await preferences.setString('user', userJson);
          showSnackBar(context, "update thanh cong");
        },
      );
    } catch (e) {
      showSnackBar(context, "Error updating location");
    }
  }
}

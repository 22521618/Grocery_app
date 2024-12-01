import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocery_app/provider/user_provider.dart';
import 'package:grocery_app/views/screens/authentication_screen/login_screen.dart';

import 'package:grocery_app/views/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => ProviderScope(child: MyApp()), // Wrap your app
      ),
    );

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  //Method to check token and set the user data if available
  Future<void> _checkTokenAndSetUser(WidgetRef ref) async {
    // obtain an instance of sharedPreference for local data storage
    SharedPreferences preferences = await SharedPreferences.getInstance();
// Retrieve the authentication token and user data stored locally
    String? token = preferences.getString('auth_token');
    String? userJson = preferences.getString('user');

    // if both token and user data are avaible, update the user state
    if (token != null && userJson != null) {
      ref.read(userProvider.notifier).setUser(userJson);
    } else {
      ref.read(userProvider.notifier).signOut();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      home: FutureBuilder(
          future: _checkTokenAndSetUser(ref),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final user = ref.watch(userProvider);
            print(user);
            return user != null ? MainScreen() : LoginScreen();
          }),
    );
  }
}

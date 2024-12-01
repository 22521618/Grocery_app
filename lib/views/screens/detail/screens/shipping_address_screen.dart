import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/controllers/auth_controller.dart';
import 'package:grocery_app/provider/user_provider.dart';
import 'package:grocery_app/services/manage_http_response.dart';

class ShippingAddressScreen extends ConsumerStatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  _ShippingAddressScreenState createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends ConsumerState<ShippingAddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  late TextEditingController _stateController;
  late TextEditingController _cityController;
  late TextEditingController _localityController;

  @override
  void initState() {
    super.initState();
    //Read the current user data from the provider
    final user = ref.read(userProvider);

    //Initialize the controllers with the current data if available
    // if user data is not available, initialize with an empty String
    _stateController = TextEditingController(text: user?.state ?? "");
    _cityController = TextEditingController(text: user?.city ?? "");
    _localityController = TextEditingController(text: user?.locality ?? "");
  }

  late String state;
  late String city;
  late String locality;

  //Show Loading Dialog
  _showLoadingDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ), // RoundedRectangleBorder
          child: const Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisSize: MainAxisSize.min, //
              children: [
                CircularProgressIndicator(),
                const SizedBox(
                  width: 20,
                ),
                Text('Updating...',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )), // Text
              ],
            ), // Row
          ), // Padding
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider);
    final updateUser = ref.read(userProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.96),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.96),
        elevation: 0,
        title: Text(
          'Delivery',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            letterSpacing: 1.7,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Where will your order be shipped?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    letterSpacing: 1.7,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextFormField(
                  controller: _stateController,
                  onChanged: (value) {
                    state = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'State',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter state";
                    } else {
                      return null;
                    }
                  },
                ), // TextFormField
                const SizedBox(
                  height: 10,
                ), // SizedBox
                TextFormField(
                  controller: _cityController,
                  onChanged: (value) {
                    city = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'City',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter city";
                    } else {
                      return null;
                    }
                  },
                ), // TextFormField
                const SizedBox(
                  height: 15,
                ), // SizedBox
                TextFormField(
                  controller: _localityController,
                  onChanged: (value) {
                    locality = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Locality',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter locality";
                    } else {
                      return null;
                    }
                  },
                ), // TextFormField
                const SizedBox(
                  height: 15,
                ), // SizedBox
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  _showLoadingDialog();
                  await _authController
                      .updateUserLocation(
                    context: context,
                    id: user!.id,
                    state: _stateController.text,
                    city: _cityController.text,
                    locality: _localityController.text,
                  )
                      .whenComplete(() {
                    updateUser.recreateUserState(
                      state: _stateController.text,
                      city: _cityController.text,
                      locality: _localityController.text,
                    );
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                } else {
                  print("Not valid");
                }
              },
              child: Container(
                width: 320,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF3854EE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Save',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

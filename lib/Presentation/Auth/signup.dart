import 'dart:io';
import 'package:customer/Application/signup/signup_cubit.dart';
import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Presentation/Common/snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:customer/Presentation/Auth/signin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  final UserType type;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final ValueNotifier<UserType> _userType;
  final ValueNotifier<File?> _licenseFile = ValueNotifier<File?>(null);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController idProofController =
      TextEditingController(); // Customer
  final TextEditingController companyNameController =
      TextEditingController(); // Owner

  RegisterPage({super.key, required this.type}) {
    _userType = ValueNotifier<UserType>(type);
  }

  void _pickLicenseFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result != null && result.files.single.path != null) {
      _licenseFile.value = File(result.files.single.path!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          state.isFailureOrSuccess.fold(
            () => null,
            (either) => either.fold(
              (failure) {
                if (!state.isLoading) {
                  if (failure == const MainFailure.serverFailure()) {
                    displaySnackBar(context: context, text: "Server is down");
                  } else if (failure == const MainFailure.authFailure()) {
                    displaySnackBar(
                      context: context,
                      text: "Please check the email address",
                    );
                  } else if (failure ==
                      const MainFailure.incorrectCredential()) {
                    displaySnackBar(
                      context: context,
                      text: "Incorrect Password",
                    );
                  } else if (failure == const MainFailure.clientFailure()) {
                    displaySnackBar(
                      context: context,
                      text: "Something wrong with your network",
                    );
                  } else {
                    displaySnackBar(
                      context: context,
                      text: "Something Unexpected Happened",
                    );
                  }
                }
              },
              (r) {
                 displaySnackBar(
                      context: context,
                      text: "Registration Successful",
                    );
              },
            ),
          );
        },
        builder: (context, state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent.shade200, Colors.blue.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent.shade700,
                                ),
                              ),
                            ),

                            const SizedBox(height: 15),
                            _buildTextField(
                              nameController,
                              "Name",
                              Icons.person,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              addressController,
                              "Address",
                              Icons.home,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              mobileController,
                              "Mobile Number",
                              Icons.phone,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              emailController,
                              "Email",
                              Icons.email,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              passwordController,
                              "Password",
                              Icons.lock,
                              obscureText: true,
                            ),

                            const SizedBox(height: 15),

                            // Show either customer or owner specific fields
                            ValueListenableBuilder(
                              valueListenable: _userType,
                              builder: (context, value, child) {
                                if (value == UserType.customer) {
                                  return Column(
                                    children: [
                                      _buildTextField(
                                        idProofController,
                                        "ID Proof",
                                        Icons.credit_card,
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      _buildTextField(
                                        companyNameController,
                                        "Company Name",
                                        Icons.business,
                                      ),
                                      const SizedBox(height: 15),
                                      ValueListenableBuilder<File?>(
                                        valueListenable: _licenseFile,
                                        builder:
                                            (context, file, _) => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ElevatedButton.icon(
                                                  onPressed: _pickLicenseFile,
                                                  icon: Icon(Icons.upload_file),
                                                  label: Text(
                                                    "Upload License Document",
                                                  ),
                                                ),
                                                if (file != null)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                          top: 8.0,
                                                        ),
                                                    child: Text(
                                                      "Selected: ${file.path.split('/').last}",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Colors.green[700],
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  );
                                }
                              },
                            ),

                            InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  final userType = _userType.value;

                                  context.read<SignupCubit>().signUp(
                                    userType: userType,
                                    name: nameController.text.trim(),
                                    email: emailController.text.trim(),
                                    phoneNumber: mobileController.text.trim(),
                                    address: addressController.text.trim(),
                                    password: passwordController.text.trim(),
                                    idProof:
                                        userType == UserType.customer
                                            ? idProofController.text.trim()
                                            : null,
                                    companyName:
                                        userType == UserType.owner
                                            ? companyNameController.text.trim()
                                            : null,
                                    licenseDocument:
                                        userType == UserType.owner
                                            ? _licenseFile.value
                                            : null,
                                  );
                                }
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                    colors: [Colors.blueAccent, Colors.blue],
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: TextStyle(color: Colors.grey.shade700),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter $label";
        }
        if (label == "Email" &&
            !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return "Enter a valid email";
        }
        if (label == "Mobile Number" && value.length != 10) {
          return "Enter a valid 10-digit mobile number";
        }
        return null;
      },
    );
  }
}

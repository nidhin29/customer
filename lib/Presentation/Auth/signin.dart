import 'package:customer/Application/signin/signin_cubit.dart';
import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Presentation/Auth/signup.dart';
import 'package:customer/Presentation/Common/snackbar.dart';
import 'package:customer/Presentation/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<UserType?> userTypeNotifier = ValueNotifier<UserType?>(
    null,
  );

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SigninCubit, SigninState>(
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
                      text: "Your account is not currently activated",
                    );
                  }
                }
              },
              (r) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            HomePage(userType: userTypeNotifier.value!),
                  ),
                  (route) => false,
                );
              },
            ),
          );
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
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
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Welcome Back!",
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent.shade700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Login to continue",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 25),

                            // Dropdown for User Type
                            ValueListenableBuilder<UserType?>(
                              valueListenable: userTypeNotifier,
                              builder: (context, selectedUserType, _) {
                                return DropdownButtonFormField<UserType>(
                                  value: selectedUserType,
                                  hint: Text("User Type"),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.blueAccent,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade100,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.blueAccent,
                                  ),
                                  dropdownColor: Colors.grey.shade100,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                  ),
                                  items:
                                      [
                                            UserType.customer,
                                            UserType.owner,
                                            UserType.staff,
                                          ]
                                          .map(
                                            (type) =>
                                                DropdownMenuItem<UserType>(
                                                  value: type,
                                                  child: Text(
                                                    type == UserType.customer
                                                        ? "Customer"
                                                        : type == UserType.owner
                                                        ? "Owner"
                                                        : "Staff",
                                                  ),
                                                ),
                                          )
                                          .toList(),
                                  onChanged: (value) {
                                    userTypeNotifier.value = value;
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return "Please select a user type";
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 15),

                            // Email Field
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.blueAccent,
                                ),
                                labelText: "Email",
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your email";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),

                            // Password Field
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.blueAccent,
                                ),
                                labelText: "Password",
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your password";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Login Button
                            InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  if (userTypeNotifier.value == null) {
                                    displaySnackBar(
                                      context: context,
                                      text: "Please select a user type",
                                    );
                                  } else {
                                    BlocProvider.of<SigninCubit>(
                                      context,
                                    ).signIn(
                                      emailController.text.trim(),
                                      passwordController.text.trim(),
                                      userTypeNotifier.value ==
                                              UserType.customer
                                          ? 3
                                          : userTypeNotifier.value ==
                                              UserType.owner
                                          ? 1
                                          : 2,
                                    );
                                  }
                                }
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                width: double.infinity,
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
                                    "Login",
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

                            // Registration Navigation
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(color: Colors.grey.shade700),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => RegisterPage(
                                              type: userTypeNotifier.value!,
                                            ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Register",
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
}

enum UserType { customer, owner, staff }

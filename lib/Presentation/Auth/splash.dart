import 'package:customer/Application/loggedin/loggedin_cubit.dart';
import 'package:customer/Domain/TokenManager/token_manager.dart';
import 'package:customer/Presentation/Auth/signin.dart';
import 'package:customer/Presentation/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<LoggedinCubit>(context).isLoggedIn();
    });
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: BlocConsumer<LoggedinCubit, LoggedinState>(
        listener: (context, state) {
          if (state.value) {
            final type = TokenManager.instance.user;
            // ignore: use_build_context_synchronously
            if (type == null) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false,
              );
            }
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder:
                    (context) => HomePage(
                      userType:
                          type == '2'
                              ? UserType.staff
                              : type == '3'
                              ? UserType.customer
                              : UserType.owner,
                    ),
              ),
              (route) => false,
            );
          } else {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: const Text(
                  'CaterCraft',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
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

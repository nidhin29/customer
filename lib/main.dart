import 'package:customer/Application/Feedback/feedback_cubit.dart';
import 'package:customer/Application/Service/service_cubit.dart';
import 'package:customer/Application/Staff/staff_cubit.dart';
import 'package:customer/Application/edit_profile/editprofile_cubit.dart';
import 'package:customer/Application/profile/profile_cubit.dart';
import 'package:customer/Application/staffview/View/view_cubit.dart';
import 'package:customer/Application/staffview/booking_cubit.dart';
import 'package:customer/Application/loggedin/loggedin_cubit.dart';
import 'package:customer/Application/message/message_cubit.dart';
import 'package:customer/Application/signin/signin_cubit.dart';
import 'package:customer/Application/signup/signup_cubit.dart';
import 'package:customer/Presentation/Auth/splash.dart';
import 'package:customer/core/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection(Environment.prod);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<FeedbackCubit>()),
        BlocProvider(create: (context) => getIt<ServiceCubit>()),
        BlocProvider(create: (context) => getIt<StaffCubit>()),
        BlocProvider(create: (context) => getIt<EditprofileCubit>()),
        BlocProvider(create: (context) => getIt<ProfileCubit>()),
        BlocProvider(create: (context) => getIt<ViewCubit>()),
        BlocProvider(create: (context) => getIt<BookingCubit>()),
        BlocProvider(create: (context) => getIt<LoggedinCubit>()),
        BlocProvider(create: (context) => getIt<MessageCubit>()),
        BlocProvider(create: (context) => getIt<SigninCubit>()),
        BlocProvider(create: (context) => getIt<SignupCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        title: 'CaterCraft',
      ),
    );
  }
}

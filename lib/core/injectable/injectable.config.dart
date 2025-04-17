// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:customer/Application/edit_profile/editprofile_cubit.dart'
    as _i756;
import 'package:customer/Application/Feedback/feedback_cubit.dart' as _i545;
import 'package:customer/Application/loggedin/loggedin_cubit.dart' as _i95;
import 'package:customer/Application/message/message_cubit.dart' as _i679;
import 'package:customer/Application/profile/profile_cubit.dart' as _i661;
import 'package:customer/Application/Service/service_cubit.dart' as _i521;
import 'package:customer/Application/signin/signin_cubit.dart' as _i910;
import 'package:customer/Application/signup/signup_cubit.dart' as _i156;
import 'package:customer/Application/Staff/staff_cubit.dart' as _i53;
import 'package:customer/Application/staffview/booking_cubit.dart' as _i748;
import 'package:customer/Application/staffview/View/view_cubit.dart' as _i328;
import 'package:customer/Domain/approve/approve_service.dart' as _i608;
import 'package:customer/Domain/bookings/booking_service.dart' as _i853;
import 'package:customer/Domain/earn/earn_service.dart' as _i573;
import 'package:customer/Domain/feedback/feedback_service.dart' as _i762;
import 'package:customer/Domain/LoggedIn/logged_in_service.dart' as _i638;
import 'package:customer/Domain/Message/SendMessage/send_message_service.dart'
    as _i610;
import 'package:customer/Domain/Message/ViewMessage/view_message_service.dart'
    as _i988;
import 'package:customer/Domain/Profile/profile_service.dart' as _i243;
import 'package:customer/Domain/Service/_service.dart' as _i629;
import 'package:customer/Domain/SignIn/sign_in_service.dart' as _i661;
import 'package:customer/Domain/signout/sign_out_service.dart' as _i771;
import 'package:customer/Domain/SignUp/sign_up_service.dart' as _i161;
import 'package:customer/Domain/Staff/staff_service.dart' as _i556;
import 'package:customer/Domain/Team/team_service.dart' as _i980;
import 'package:customer/Domain/TokenManager/token_service.dart' as _i857;
import 'package:customer/Infrastructure/approve/approve_repo.dart' as _i50;
import 'package:customer/Infrastructure/booking/booking_repo.dart' as _i182;
import 'package:customer/Infrastructure/earn/earn_repo.dart' as _i79;
import 'package:customer/Infrastructure/feedback/feedback_repo.dart' as _i277;
import 'package:customer/Infrastructure/LoggedIn/logged_in_repo.dart' as _i27;
import 'package:customer/Infrastructure/Message/SendMessage/send_message_repo.dart'
    as _i574;
import 'package:customer/Infrastructure/Message/ViewMessage/view_message_repo.dart'
    as _i92;
import 'package:customer/Infrastructure/Profile/profile_repo.dart' as _i247;
import 'package:customer/Infrastructure/Service/service_repo.dart' as _i601;
import 'package:customer/Infrastructure/SignIn/sign_in_repo.dart' as _i91;
import 'package:customer/Infrastructure/signout/signout.dart' as _i6;
import 'package:customer/Infrastructure/SignUp/signup_repo.dart' as _i797;
import 'package:customer/Infrastructure/staff/staff_repo.dart' as _i584;
import 'package:customer/Infrastructure/team/team_repo.dart' as _i974;
import 'package:customer/Infrastructure/TokenManager/token_repo.dart' as _i269;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i853.BookingService>(() => _i182.BookingRepo());
    gh.lazySingleton<_i771.SignOutService>(() => _i6.SignoutRepo());
    gh.lazySingleton<_i573.EarnService>(() => _i79.EarnRepo());
    gh.lazySingleton<_i988.ViewMessageService>(
      () => _i92.ViewMessageServiceRepo(),
    );
    gh.lazySingleton<_i608.ApproveService>(() => _i50.ApproveRepo());
    gh.lazySingleton<_i638.LoggedInService>(() => _i27.LoggedInRepo());
    gh.lazySingleton<_i610.SendMessageService>(() => _i574.SendMessageRepo());
    gh.lazySingleton<_i629.SService>(() => _i601.ServiceRepo());
    gh.lazySingleton<_i243.ProfileService>(() => _i247.ProfileRepo());
    gh.lazySingleton<_i980.TeamService>(() => _i974.TeamRepo());
    gh.lazySingleton<_i161.SignUpService>(() => _i797.SignUpRepo());
    gh.lazySingleton<_i857.TokenService>(() => _i269.TokenRepo());
    gh.factory<_i748.BookingCubit>(
      () => _i748.BookingCubit(
        gh<_i853.BookingService>(),
        gh<_i608.ApproveService>(),
      ),
    );
    gh.lazySingleton<_i762.FeedbackService>(() => _i277.FeedbackRepo());
    gh.lazySingleton<_i661.SignInService>(() => _i91.SignInRepo());
    gh.factory<_i661.ProfileCubit>(
      () => _i661.ProfileCubit(gh<_i243.ProfileService>()),
    );
    gh.factory<_i756.EditprofileCubit>(
      () => _i756.EditprofileCubit(gh<_i243.ProfileService>()),
    );
    gh.lazySingleton<_i556.StaffService>(() => _i584.FeedbackRepo());
    gh.factory<_i910.SigninCubit>(
      () => _i910.SigninCubit(
        gh<_i661.SignInService>(),
        gh<_i857.TokenService>(),
      ),
    );
    gh.factory<_i156.SignupCubit>(
      () => _i156.SignupCubit(gh<_i161.SignUpService>()),
    );
    gh.factory<_i679.MessageCubit>(
      () => _i679.MessageCubit(
        gh<_i988.ViewMessageService>(),
        gh<_i610.SendMessageService>(),
      ),
    );
    gh.factory<_i545.FeedbackCubit>(
      () => _i545.FeedbackCubit(
        gh<_i762.FeedbackService>(),
        gh<_i573.EarnService>(),
      ),
    );
    gh.factory<_i521.ServiceCubit>(
      () => _i521.ServiceCubit(gh<_i629.SService>()),
    );
    gh.factory<_i95.LoggedinCubit>(
      () => _i95.LoggedinCubit(
        gh<_i638.LoggedInService>(),
        gh<_i857.TokenService>(),
      ),
    );
    gh.factory<_i328.ViewCubit>(
      () => _i328.ViewCubit(gh<_i556.StaffService>(), gh<_i980.TeamService>()),
    );
    gh.factory<_i53.StaffCubit>(
      () => _i53.StaffCubit(gh<_i556.StaffService>()),
    );
    return this;
  }
}

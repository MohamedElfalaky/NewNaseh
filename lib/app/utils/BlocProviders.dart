import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Data/cubit/authentication/category_cubit/category_cubit.dart';
import '../../Data/cubit/FrontEndCubits/cubit/add_cirtificate_cubit.dart';
import '../../Data/cubit/advice_cubits/approve_advice_cubit/approve_advice_cubit.dart';
import '../../Data/cubit/advice_cubits/done_advice_cubit/done_advice_cubit.dart';
import '../../Data/cubit/advice_cubits/show_advice_cubit/show_advice_cubit.dart';
import '../../Data/cubit/authentication/check_code/check_code_cubit.dart';
import '../../Data/cubit/authentication/city_cubit/city_cubit.dart';
import '../../Data/cubit/authentication/country_cubit/country_cubit.dart';
import '../../Data/cubit/authentication/forget_password_cubit/change_password_cubit/change_password_cubit.dart';
import '../../Data/cubit/authentication/forget_password_cubit/check_forget_code_cubit/check_code_cubit.dart';
import '../../Data/cubit/authentication/forget_password_cubit/forget_mob/forget_mob_cubit.dart';
import '../../Data/cubit/authentication/get_user_cubit/get_user_cubit.dart';
import '../../Data/cubit/authentication/log_out_cubit/log_out_cubit.dart';
import '../../Data/cubit/authentication/login_cubit/login_cubit.dart';
import '../../Data/cubit/authentication/nationality_cubit/nationality_cubit.dart';
import '../../Data/cubit/authentication/new_mob/mob_cubit.dart';
import '../../Data/cubit/authentication/register_cubit/register_cubit.dart';
import 'package:provider/single_child_widget.dart';
import '../../Data/cubit/home/home_one_cubit/home_one_cubit.dart';
import '../../Data/cubit/home/home_status_cubit/home_status_cubit.dart';
import '../../Data/cubit/notification_cubit/notification_cubit.dart';
import '../../Data/cubit/profile/profile_cubit/profile_cubit.dart';
import '../../Data/cubit/profile/update_profile_cubit/update_profile_cubit.dart';
import '../../Data/cubit/rejections_cubit/reject_cubit/post_reject_cubit.dart';
import '../../Data/cubit/rejections_cubit/rejection_list_cubit/rejection_list_cubit.dart';
import '../../Data/cubit/send_chat_cubit/send_chat_cubit.dart';
import '../../Data/cubit/settings_cubits/is_advice_cubit/is_advice_cubit.dart';
import '../../Data/cubit/settings_cubits/is_notification_cubit/is_notification_cubit.dart';
import '../../Data/cubit/settings_cubits/privacy_cubit/privacy_cubit.dart';
import '../../Data/cubit/wallet_cubit/wallet_cubit.dart';

List<SingleChildWidget> providers = [
  BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
  BlocProvider<RegisterCubit>(create: (context) => RegisterCubit()),
  BlocProvider<MobCubit>(create: (context) => MobCubit()),
  BlocProvider<CheckCodeCubit>(create: (context) => CheckCodeCubit()),
  BlocProvider<CategoryCubit>(create: (context) => CategoryCubit()),
  BlocProvider<LogOutCubit>(create: (context) => LogOutCubit()),
  BlocProvider<CountryCubit>(create: (context) => CountryCubit()),
  BlocProvider<NationalityCubit>(create: (context) => NationalityCubit()),
  BlocProvider<CityCubit>(create: (context) => CityCubit()),
  BlocProvider<AddCertificateCubit>(create: (context) => AddCertificateCubit()),
  BlocProvider<UpdateProfileCubit>(create: (context) => UpdateProfileCubit()),
  BlocProvider<ProfileCubit>(create: (context) => ProfileCubit()),
  BlocProvider<HomeStatusCubit>(create: (context) => HomeStatusCubit()),
  BlocProvider<ListOneHomeCubit>(create: (context) => ListOneHomeCubit()),
  BlocProvider<PrivacyCubit>(create: (context) => PrivacyCubit()),
  BlocProvider<CheckCheckMobCubit>(create: (context) => CheckCheckMobCubit()),
  BlocProvider<ChangePasswordCubit>(create: (context) => ChangePasswordCubit()),
  BlocProvider<ShowAdviceCubit>(create: (context) => ShowAdviceCubit()),
  BlocProvider<ApproveAdviceCubit>(create: (context) => ApproveAdviceCubit()),
  BlocProvider<DoneAdviceCubit>(create: (context) => DoneAdviceCubit()),
  BlocProvider<GetUserCubit>(create: (context) => GetUserCubit()),
  BlocProvider<CheckForgetCodeCubit>(
      create: (context) => CheckForgetCodeCubit()),
  BlocProvider<SendChatCubit>(create: (context) => SendChatCubit()),
  BlocProvider<PostRejectCubit>(create: (context) => PostRejectCubit()),
  BlocProvider<ListRejectionCubit>(create: (context) => ListRejectionCubit()),
  BlocProvider<WalletCubit>(create: (context) => WalletCubit()),
  BlocProvider<NotificationCubit>(create: (context) => NotificationCubit()),
  BlocProvider<IsNotificationCubit>(create: (context) => IsNotificationCubit()),
  BlocProvider<IsAdviceCubit>(create: (context) => IsAdviceCubit()),
];

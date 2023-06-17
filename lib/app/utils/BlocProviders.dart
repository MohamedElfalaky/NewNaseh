import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Data/cubit/authentication/category_cubit/category_cubit.dart';
import '../../Data/cubit/FrontEndCubits/cubit/add_cirtificate_cubit.dart';
import '../../Data/cubit/authentication/check_code/check_code_cubit.dart';
import '../../Data/cubit/authentication/city_cubit/city_cubit.dart';
import '../../Data/cubit/authentication/country_cubit/country_cubit.dart';
import '../../Data/cubit/authentication/login_cubit/login_cubit.dart';
import '../../Data/cubit/authentication/nationality_cubit/nationality_cubit.dart';
import '../../Data/cubit/authentication/new_mob/mob_cubit.dart';
import '../../Data/cubit/authentication/register_cubit/register_cubit.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
  BlocProvider<RegisterCubit>(create: (context) => RegisterCubit()),
  BlocProvider<MobCubit>(create: (context) => MobCubit()),
  BlocProvider<CheckCodeCubit>(create: (context) => CheckCodeCubit()),
  BlocProvider<CategoryCubit>(create: (context) => CategoryCubit()),
  BlocProvider<CountryCubit>(create: (context) => CountryCubit()),
  BlocProvider<NationalityCubit>(create: (context) => NationalityCubit()),
  BlocProvider<CityCubit>(create: (context) => CityCubit()),
  BlocProvider<AddCertificateCubit>(create: (context) => AddCertificateCubit()),
];

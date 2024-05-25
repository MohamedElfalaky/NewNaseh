import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/data/cubit/settings_cubits/about_cubit/about_cubit.dart';
import '../../../data/cubit/settings_cubits/about_cubit/about_state.dart';
import '../../../presentation/widgets/custom_loading_widget.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<AboutCubit>().getAbout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Constants.whiteAppColor,
        appBar: AppBar(
            centerTitle: false,
            leadingWidth: 70,
            title: Row(
              children: [
                Text("Know".tr),
              ],
            ),
            leading: const CustomBackButton()),
        body: BlocBuilder<AboutCubit, AboutState>(builder: (context, state) {
          if (state is AboutLoading) {
            return const CustomLoadingIndicator();
          } else if (state is AboutLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHeader(state.response?.data?.name ?? ""),
                  buildBody(state.response?.data?.description ?? ""),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            );
          } else if (state is AboutError) {
            return const Center(child: Text('error'));
          } else {
            return const CustomLoadingIndicator();
          }
        }));
  }
}

Widget buildHeader(title) => Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 5),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );

Widget buildBody(title) => Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
    );

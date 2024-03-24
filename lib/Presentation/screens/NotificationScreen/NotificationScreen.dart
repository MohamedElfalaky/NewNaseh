import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nasooh/Presentation/screens/NotificationScreen/Components/OneNotification.dart';
import 'package:nasooh/Presentation/widgets/noInternet.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';

import '../../../Data/cubit/notification_cubit/notification_cubit.dart';
import '../../../Data/cubit/notification_cubit/notification_state.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  late StreamSubscription<ConnectivityResult> subscription;
  bool? isConnected;
  final controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    MyApplication.checkConnection().then((value) {
      if (value) {
        context.read<NotificationCubit>().getDataNotification();
      } else {
        MyApplication.showToastView(message: "noInternet".tr);
      }
    });

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (mounted) {
        setState(() {
          result == ConnectivityResult.none
              ? isConnected = false
              : isConnected = true;
        });
      }

      if (result != ConnectivityResult.none) {
        context.read<NotificationCubit>().getDataNotification();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final sizee = MediaQuery.of(context).size;
    if (isConnected == null) {
      MyApplication.checkConnection().then((value) {
        setState(() {
          isConnected = value;
        });
      });
    } else if (!isConnected!) {
      MyApplication.showToastView(message: "noInternet".tr);
      return NoInternetWidget(size: sizee);
    }

    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      }, // hide keyboard on tap anywhere

      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Constants.whiteAppColor,
          appBar: AppBar(
            centerTitle: false,
            leadingWidth: 80,
            title: Text("Notifications".tr),
            leading: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: MyBackButton(),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Switch(
                  value: false,
                  onChanged: (value) {},
                ),
              )
            ],
          ),
          body: BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
            if (state is NotificationLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NotificationLoaded) {
              return Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    itemBuilder: (context, index) => OneNotification(
                      orderId: state.response?[index].id ?? 0,
                      description: state.response?[index].description ?? "",
                      date: state.response?[index].date ?? "",
                      notificationId:
                          state.response?[index].id.toString() ?? "0",
                    ),
                    itemCount: state.response?.length ?? 0,
                  ))
                ],
              );
            } else if (state is NotificationError) {
              return const Center(child: Text('error'));
            } else {
              return const Center(child: Text('....'));
            }
          })),
    );
  }
}

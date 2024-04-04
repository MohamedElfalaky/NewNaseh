import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:nasooh/Presentation/screens/WalletScreen/Components/wallet_widget.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/my_application.dart';

import '../../../Data/cubit/wallet_cubit/wallet_cubit.dart';
import '../../../Data/cubit/wallet_cubit/wallet_state.dart';
import '../../../app/styles/icons.dart';
import '../../widgets/custom_loading_widget.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    context.read<WalletCubit>().getDataWallet();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      }, // hide keyboard on tap anywhere

      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Constants.whiteAppColor,
          appBar: AppBar(
              centerTitle: false,
              leadingWidth: 70,
              title: const Row(
                children: [
                  Text("محفظتي"),
                ],
              ),
              leading: CustomBackButton()),
          body:
              BlocBuilder<WalletCubit, WalletState>(builder: (context, state) {
            if (state is WalletLoading) {
              return const CustomLoadingIndicator();
            } else if (state is WalletLoaded) {
              // print(state.response!.transaction.toString());
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: Lottie.asset(myWallet),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "رصيد محفظتي",
                              style: Constants.secondaryTitleRegularFont,
                            ),
                            RichText(
                                text: TextSpan(
                                    text: '${state.response?.balance ?? 0}',
                                    style: Constants.headerNavigationFont
                                        .copyWith(fontSize: 32),
                                    children: [
                                  TextSpan(
                                      text: "ريال سعودي",
                                      style: Constants.subtitleFont.copyWith(
                                          fontWeight: FontWeight.normal))
                                ]))
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemBuilder: (context, index) => WalletWidget(
                      description:
                          state.response?.transaction?[index].description ?? "",
                      value: state.response?.transaction?[index].balance
                              .toString() ??
                          "0",
                      transactionId:
                          state.response?.transaction?[index].id.toString() ??
                              "0",
                    ),
                    itemCount: state.response?.transaction?.length ?? 0,
                  ))
                ],
              );
            } else if (state is WalletError) {
              return const Center(child: Text('error'));
            } else {
              return const Center(child: Text('....'));
            }
          })),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/RegistrationCycle/RegistrationStage6/RegistrationStage6.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/Style/Icons.dart';
import '../../../../../Data/cubit/authentication/category_cubit/category_cubit.dart';
import '../../../../../Data/cubit/authentication/category_cubit/category_state.dart';
import '../../../../../Data/models/Auth_models/category_model.dart';
import '../../../../../app/constants.dart';
import '../../../../../app/utils/myApplication.dart';
import '../../../../../app/utils/registeration_values.dart';

class RegistrationStage5 extends StatefulWidget {
  const RegistrationStage5({Key? key}) : super(key: key);

  @override
  State<RegistrationStage5> createState() => _RegistrationStage5State();
}

class _RegistrationStage5State extends State<RegistrationStage5> {
  List<CategoryData> categoryData = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    context.read<CategoryCubit>().getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: MyButton(
                    isBold: true,
                    txt: "التالي",
                    onPressedHandler: () {
                      MyApplication.navigateTo(
                          context, const RegistrationStage6());
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                  ),
                  child: Text(
                    "خطوة 5 من 7",
                    style: Constants.subtitleRegularFont,
                  ),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          appBar: AppBar(
            centerTitle: false,
            leadingWidth: 70,
            title: const Text("مجالات التخصص"),
            leading: const MyBackButton(),
            actions: [
              Center(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 10),
                  child: Badge(
                    label: const Text("7"),
                    backgroundColor: const Color.fromARGB(255, 138, 138, 144),
                    alignment: const AlignmentDirectional(0, 25),
                    child: Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Constants.primaryAppColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: SvgPicture.asset(
                        selectedSectors,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          body: BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
            if (state is CategoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CategoryLoaded) {
              return _buildCard(context, state.response!);
            } else if (state is CategoryError) {
              return const Center(child: Text('error'));
            } else {
              return const Center(child: Text('....'));
            }
          })),
    );
  }

  List<CategoryData> results = [];

  Widget _buildCard(BuildContext context, CategoryModel model) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: TextFormField(
                  controller: _searchController,
                  onChanged: (val) {
                    setState(() {
                      categoryData = model.data!;
                      List<CategoryData> searchList(String query) {
                        return categoryData
                            .where((item) => item.name!.contains(query))
                            .toList();
                      }

                      results = searchList(_searchController.text);
                      print(results.length);
                    });
                  },
                  decoration: Constants.setRegistrationTextInputDecoration(
                      hintText: "ابحث عن المجالات التي تجيديها...",
                      prefixIcon: SvgPicture.asset(
                        searchIcon,
                        height: 24,
                      )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: _searchController.text.isEmpty
                    ? ListView.builder(
                        itemCount: model.data!.length,
                        itemBuilder: (context, int x) {
                          // List<MyNewModel> newList = model.data!.map((obj) {
                          //   return MyNewModel(id: obj.id!, booleanValue: false);
                          // }).toList();
                          // MyNewModel item = newList[x];

                          return ExpansionTile(
                              tilePadding: const EdgeInsets.all(0),
                              // leading: SizedBox(
                              //     height: 24,
                              //     width: 24,
                              //     child: Checkbox(value: false, onChanged: (s) {})),
                              title: Row(
                                children: [
                                  SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: Checkbox(
                                          value: model.data![x].selected,
                                          onChanged: (bool? s) {
                                            // setState(() {
                                            //   for (var newItem in newList) {
                                            //     newItem.booleanValue = false;
                                            //   }
                                            //   item.booleanValue = true;
                                            // });
                                            // print(item.booleanValue);
                                            // print(item.id);

                                            setState(() {
                                              model.data![x].selected = s;
                                              if (model.data![x].selected ==
                                                  true) {
                                                // print(model.data![x].id);
                                                sendCategory
                                                    .add(model.data![x].id!);

                                                for (var selectItems in model
                                                    .data![x].children!) {
                                                  selectItems.selected = true;
                                                  sendCategory
                                                      .add(selectItems.id!);
                                                }
                                              } else if (model
                                                      .data![x].selected ==
                                                  false) {
                                                sendCategory.removeWhere((e) =>
                                                    e == model.data![x].id);
                                              }

                                              // model.data![x].selected = s;

                                              // newList[x].booleanValue = s!;
                                              // print(
                                              //     " item bool is${newList[x].booleanValue} and item id is ${newList[x].id}");
                                              //
                                              // print(newList[x].booleanValue);
                                            });
                                            debugPrint(
                                                "the send category is ${sendCategory.toSet().toList().toString()}");
                                          })),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      model.data![x].name!,
                                      style: Constants.secondaryTitleFont,
                                    ),
                                  ),
                                ],
                              ),
                              children: model.data![x].children!
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 12, end: 4, top: 4, bottom: 4),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                              height: 24,
                                              width: 24,
                                              child: Checkbox(
                                                  value: e.selected,
                                                  onChanged: (s) {
                                                    setState(() {
                                                      e.selected = s;
                                                      if (e.selected == true) {
                                                        sendCategory.add(e.id!);
                                                      } else if (e.selected ==
                                                          false) {
                                                        sendCategory
                                                            .removeWhere(
                                                                (element) =>
                                                                    element ==
                                                                    e.id);
                                                      }
                                                      debugPrint(
                                                          "the send category is ${sendCategory.toSet().toList().toString()}");
                                                    });
                                                  })),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            e.name!,
                                            style: Constants
                                                .secondaryTitleRegularFont,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList());
                        },
                      )
                    : ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, int x) => ExpansionTile(
                            tilePadding: const EdgeInsets.all(0),
                            // leading: SizedBox(
                            //     height: 24,
                            //     width: 24,
                            //     child: Checkbox(value: false, onChanged: (s) {})),
                            title: Row(
                              children: [
                                SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Checkbox(
                                        value: false,
                                        onChanged: (s) {
                                          setState(() {});
                                        })),
                                const SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  child: Text(
                                    results[x].name!,
                                    style: Constants.secondaryTitleFont,
                                  ),
                                ),
                              ],
                            ),
                            children: results[x]
                                .children!
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 12, end: 4, top: 4, bottom: 4),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: Checkbox(
                                                value: false,
                                                onChanged: (s) {})),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          e.name!,
                                          style: Constants
                                              .secondaryTitleRegularFont,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList()),
                      ),
              ),
              const SizedBox(
                height: 90,
              )
            ],
          )),
    );
  }

/////////////// returns
}

class MyNewModel {
  int id;
  bool booleanValue;

  MyNewModel({required this.id, required this.booleanValue});
}

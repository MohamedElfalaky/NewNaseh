import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../Data/cubit/authentication/city_cubit/city_cubit.dart';
import '../../Data/cubit/authentication/city_cubit/city_state.dart';
import '../../Data/cubit/authentication/country_cubit/country_cubit.dart';
import '../../Data/cubit/authentication/country_cubit/country_state.dart';
import '../../Data/cubit/authentication/nationality_cubit/nationality_cubit.dart';
import '../../Data/cubit/authentication/nationality_cubit/nationality_state.dart';
import '../../Data/cubit/profile/profile_cubit/profile_cubit.dart';
import '../../app/Style/icons.dart';
import '../../app/constants.dart';
import '../../app/utils/registeration_values.dart';
import 'custom_loading_widget.dart';

class CustomDropdownData<T> extends StatelessWidget {
  final dynamic value;
  final String hintData;
  final List<DropdownMenuItem<String>>? items;
  final void Function(dynamic)? onChanged;
 final Widget? prefixIcon;

      const CustomDropdownData({
    Key? key,
    this.prefixIcon,
    required this.value,
    required this.hintData,
    required this.onChanged,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFBDBDBD)),
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            menuMaxHeight: 300.0,
            decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                prefixIcon: Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 12, end: 6, top: 10, bottom: 10),
                  child: Container(
                    width: 30,
                    decoration: const BoxDecoration(
                        border: Border(
                            left: BorderSide(
                                width: 1, color: Color(0xFFBDBDBD)))),
                    margin: const EdgeInsetsDirectional.only(end: 8),
                    padding: const EdgeInsetsDirectional.only(end: 8),
                    child: prefixIcon,
                  ),
                ),
                hintText: hintData,
                hintStyle: const TextStyle(
                  fontFamily: Constants.mainFont,
                  fontSize: 14,
                  color: Constants.fontHintColor,
                )),
            icon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(Icons.arrow_drop_down_outlined,
                  color: Color(0xFFBDBDBD)),
            ),
            isExpanded: true,
            value: value,
            items: items,
            onChanged: onChanged,
          ),
        ));
  }
}

class MyColumnData extends StatefulWidget {
  const MyColumnData({super.key});

  @override
  State<MyColumnData> createState() => _MyColumnDataState();
}

class _MyColumnDataState extends State<MyColumnData> {
  String? countryValue;
  String? cityValue;
  String? nationalityValue;

  Future<void> getData() async {
    await context.read<CountryCubit>().getCountries();
    if(mounted) {
      await context.read<NationalityCubit>().getNationalities();
    }
    final ProfileCubit? profileCubit =context.mounted? ProfileCubit.get(context):null;
    if (profileCubit?.profileModel?.data?.nationalityId != null) {
      nationalityValue =
          profileCubit?.profileModel?.data?.nationalityId?.id.toString();
    }
    if (profileCubit?.profileModel?.data?.countryId != null) {
      countryValue = profileCubit?.profileModel?.data?.countryId?.id.toString();
    }
  }

  @override
  void initState() {
    // context.read<CountryCubit>().getCountries();
    // context.read<NationalityCubit>().getNationalities();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<CountryCubit, CountryState>(builder: (context, state) {

          if (state is CountryLoaded) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: CustomDropdownData(
                  hintData: "بلد الإقامة...",
                  value: countryValue,
                  onChanged: (val) {
                    setState(() {
                      countryValue = val;
                      inputCountry = countryValue;
                    });

                    context.read<CityCubit>().getCities(inputCountry!);
                  },
                  items: state.response!.data!
                      .map((e) => DropdownMenuItem(
                          value: e.id.toString(), child: Text(e.name!)))
                      .toList(),
                  prefixIcon: SvgPicture.asset(
                    countryIcon,
                    height: 24,
                  )),
            );
          }
            return const SizedBox.shrink();

        }),
        BlocBuilder<CityCubit, CityState>(builder: (context, cityState) {
          if (cityState is CityLoading) {
            return const CustomLoadingIndicator();
          } else if (cityState is CityLoaded) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: CustomDropdownData(
                  hintData: "مدينة الإقامة...",
                  value: cityValue,
                  onChanged: (val) {
                    setState(() {
                      cityValue = val;
                      inputCity = cityValue;
                    });
                   },
                  items: cityState.response!.data!
                      .map(
                        (e) => DropdownMenuItem(
                            value: e.id.toString(), child: Text(e.name!)),
                      )
                      .toList(),
                  prefixIcon: SvgPicture.asset(
                    cityIcon,
                    height: 24,
                  )),
            );
          } return const SizedBox.shrink();
        }),
        BlocBuilder<NationalityCubit, NationalityState>(
            builder: (context, newState) {

          if (newState is NationalityLoaded) {
            return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: CustomDropdownData(
                    hintData: "الجنسية...",
                    value: nationalityValue,
                    items: newState.response!.data!
                        .map(
                          (e) => DropdownMenuItem(
                              value: e.id.toString(), child: Text(e.name!)),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        nationalityValue = val;
                        inputNationality = nationalityValue;
                      });
                    },
                    prefixIcon: SvgPicture.asset(
                      nationalityIcon,
                      height: 24,
                    )));
          } else if (newState is NationalityError) {
            return const Center(child: SizedBox());
          } else {
            return const Center(child: SizedBox());
          }
        }),
      ],
    );
  }
}

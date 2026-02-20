import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/helper/countries_list.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/common_bottom_sheet.dart';
import 'package:ryann_dating/app/widgets/custom_image_view.dart';
import 'package:ryann_dating/app/widgets/custom_textfields.dart';
import 'package:ryann_dating/gen/assets.gen.dart';

class CountryPickerWidget extends StatefulWidget {
  const CountryPickerWidget({
    super.key,
    this.selectedCountryCode,
    required this.onCountryChange,
    this.countryList,
  });
  final String? selectedCountryCode;
  final List<CountryCode>? countryList;
  final Function(CountryCode country) onCountryChange;

  @override
  State<CountryPickerWidget> createState() => _CountryPickerWidgetState();
}

class _CountryPickerWidgetState extends State<CountryPickerWidget> {
  late CountryCode selectedCountry;
  @override
  void initState() {
    selectedCountry = countryCodes.firstWhere(
      (e) => e.dialCode == (widget.selectedCountryCode ?? '+61'),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .min,
      children: [
        InkWell(
          borderRadius: 12.radius,
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) =>
                  CountryPickerSheet(countryList: widget.countryList),
            ).then((value) {
              if (value != null) {
                setState(() {
                  selectedCountry = value as CountryCode;
                  widget.onCountryChange(selectedCountry);
                });
              }
            });
          },
          child: Container(
            height: 50,
            color: AppColors.transparent,
            child: Row(
              mainAxisSize: .min,
              spacing: 4.w,
              children: [
                Padding(
                  padding: 16.leftPad.add(4.rightPad),
                  child: CircleAvatar(
                    radius: 10.r,
                    backgroundImage: NetworkImage(
                      'https://flagcdn.com/w160/${selectedCountry.countryCode.toLowerCase()}.png',
                    ),
                  ),
                ),
                Text(selectedCountry.dialCode, style: AppTextStyle.s14w500()),
                CustomImageView(imagePath: Assets.svgIcons.arrowDownSmallIc),
              ],
            ),
          ),
        ),
        Container(
          height: 21,
          width: 1,
          margin: 8.horPad,
          decoration: const BoxDecoration(color: AppColors.borderColor),
        ),
      ],
    );
  }
}

class CountryPickerSheet extends StatefulWidget {
  const CountryPickerSheet({super.key, this.countryList});
  final List<CountryCode>? countryList;

  @override
  State<CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<CountryPickerSheet> {
  final searchController = TextEditingController();
  late List<CountryCode> countryList;

  @override
  void initState() {
    countryList = widget.countryList ?? countryCodes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBottomSheet(
      title: context.l10n.selectCountryCode,
      topWidget: AppTextField(
        contentPadding: 1.allPad,
        bottomPad: 12,
        isDense: true,
        fillColor: AppColors.colorF5F5F5,
        hintColor: AppColors.color525252,
        textInputAction: .search,
        onFieldSubmitted: (value) {
          setState(() {
            countryList = (widget.countryList ?? countryCodes)
                .where(
                  (element) =>
                      element.name.toLowerCase().contains(
                        value.toLowerCase(),
                      ) ||
                      element.dialCode.toLowerCase().contains(
                        value.toLowerCase(),
                      ),
                )
                .toList();
          });
        },
        hintLabel: context.l10n.country,
        prefixIcon: Padding(
          padding: 12.allPad,
          child: CustomImageView(
            imagePath: Assets.svgIcons.searchIc,
            height: 12.h,
            width: 12.w,
          ),
        ),
        onChanged: (String? value) {
          setState(() {
            countryList = (widget.countryList ?? countryCodes)
                .where(
                  (element) =>
                      element.name.toLowerCase().contains(
                        value!.toLowerCase(),
                      ) ||
                      element.dialCode.toLowerCase().contains(
                        value.toLowerCase(),
                      ),
                )
                .toList();
          });
        },
      ),
      bottomWidget: countryList.isEmpty
          ? Center(
              child: Text(
                context.l10n.noCountryFound,
                style: AppTextStyle.s14w500(),
              ),
            )
          : ListView.separated(
              itemCount: countryList.length,
              padding: 24.horPad.add(20.btmPad),
              primary: false,
              separatorBuilder: (context, index) => Divider(height: 24.h),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final country = countryList[index];
                return InkWell(
                  onTap: () => context.pop(country),
                  child: Container(
                    color: AppColors.transparent,
                    margin: 16.topPad,
                    child: Row(
                      spacing: 12.w,
                      children: [
                        CustomImageView(
                          imagePath:
                              'https://flagcdn.com/w160/${country.countryCode.toLowerCase()}.png',
                          radius: 50.radius,
                          width: 24.w,
                          height: 24.w,
                          fit: .cover,
                        ),
                        Expanded(
                          child: Text(
                            country.name,
                            maxLines: 1,
                            overflow: .ellipsis,
                            style: AppTextStyle.s14w400(
                              color: AppColors.textPrimaryColor,
                            ),
                          ),
                        ),
                        Text(
                          country.dialCode,
                          style: AppTextStyle.s14w400(
                            color: AppColors.textPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/country_city_model/country_city_model.dart';
import 'package:ryann_dating/app/pages/authentication/cubit/auth_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/cubit/auth_state.dart';
import 'package:ryann_dating/app/pages/authentication/widgets/common_auth_screen.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/common_btn.dart';
import 'package:ryann_dating/app/widgets/custom_textfields.dart';
import 'package:ryann_dating/app/widgets/shimmer_widgets/country_list_shimmer.dart';

class CitySelectionScreen extends StatelessWidget {
  const CitySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(isRegister: true)..getCountryList(),
      child: Builder(
        builder: (context) {
          return CommonAuthScreen(
            btmWidget: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                final cubit = context.read<AuthCubit>();
                return CommonBtn(
                  title: context.l10n.continues,
                  isDisabled: state.isLoading || cubit.canProceed(),
                  // onTap: () => context.push(AppRoutes.register, extra: cubit),
                  onTap: () => cubit.navigation(context),
                );
              },
            ),
            header: context.l10n.whereAreYouBased,
            headerStyle: AppTextStyle.s18w500(),
            controller: context.read<AuthCubit>().controller,
            onRefresh: () => context.read<AuthCubit>().getCountryList(),
            children: [
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (previous, current) => false,
                builder: (context, state) {
                  return Padding(
                    padding: 8.topPad,
                    child: AppTextField(
                      controller: state.searchController,
                      hintLabel: 'Search for your city...',
                      bottomPad: 0,
                      onChanged: (value) =>
                          context.read<AuthCubit>().updateSearchQuery(value),
                    ),
                  );
                },
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return CountryCitySelector(
                    countryList: state.countries,
                    searchQuery: state.searchQuery,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class CountryCitySelector extends StatefulWidget {
  const CountryCitySelector({
    super.key,
    required this.countryList,
    this.searchQuery = '',
  });
  final List<Country> countryList;
  final String searchQuery;

  @override
  State<CountryCitySelector> createState() => _CountryCitySelectorState();
}

class _CountryCitySelectorState extends State<CountryCitySelector>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: .zero)
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleCountrySelection(AuthCubit cubit, Country? country) {
    if (country != null) cubit.selectCountry(country);

    // Only animate if country has cities
    if (country?.cities?.isNotEmpty ?? false) {
      _animationController.reset();
      _animationController.forward();
    }
  }

  List<Country> _getAllCountriesForInternational(Country? defaultCountry) {
    final result = <Country>[];
    if (defaultCountry != null) result.add(defaultCountry);
    result.addAll(
      widget.countryList
          .where((c) => (c.isInternational ?? true) && c.isoCode != 'AU')
          .toList(),
    );
    return result;
  }

  List<Country> _getFilteredCountries() {
    if (widget.searchQuery.isEmpty) return widget.countryList;

    final query = widget.searchQuery.toLowerCase();
    return widget.countryList
        .map((country) {
          final countryMatches = country.name.toLowerCase().contains(query);
          final matchingCities =
              country.cities
                  ?.where((city) => city.name.toLowerCase().contains(query))
                  .toList() ??
              [];

          if (countryMatches || matchingCities.isNotEmpty) {
            return country.copyWith(cities: matchingCities);
          }
          return null;
        })
        .whereType<Country>()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredCountries = _getFilteredCountries();
    final isSearching = widget.searchQuery.isNotEmpty;

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final cubit = context.read<AuthCubit>();
        final hasSelectedCountryCities =
            state.selectedCountry?.cities?.isNotEmpty ?? false;

        final query = widget.searchQuery.toLowerCase();
        final cityMatchedCountries = filteredCountries
            .where((c) => c.cities?.isNotEmpty ?? false)
            .toList();
        final countryOnlyMatchedCountries = filteredCountries
            .where(
              (c) =>
                  (c.cities?.isEmpty ?? true) &&
                  c.name.toLowerCase().contains(query),
            )
            .toList();

        return Container(
          padding: 14.allPad,
          margin: 8.topPad,
          decoration: BoxDecoration(
            borderRadius: 10.radius,
            color: AppColors.whiteColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 12,
                color: AppColors.blackColor.withValues(alpha: 0.1),
              ),
            ],
          ),
          child: state.isLoading
              ? const CountryListShimmer()
              : filteredCountries.isEmpty
              ? const Center(child: Text('No cities found'))
              : Column(
                  mainAxisSize: .min,
                  crossAxisAlignment: .start,
                  children: [
                    if (!isSearching) ...[
                      // If selected country has cities, show it at top with cities
                      if (hasSelectedCountryCities) ...[
                        _buildCountrySection(context, state, cubit),
                      ],

                      // International Section
                      Padding(
                        padding: 8.topPad,
                        child: _buildSectionHeader('International'),
                      ),

                      // Show all countries in international section
                      ..._getAllCountriesForInternational(
                        state.defaultCountry,
                      ).map((country) {
                        // If this is the selected country without cities, show it as selected
                        if (country == state.selectedCountry &&
                            !hasSelectedCountryCities) {
                          return _buildCityTile(
                            context,
                            state,
                            cubit,
                            country,
                            isCountry: true,
                          );
                        }
                        // If this is the selected country with cities, don't show it here
                        if (country == state.selectedCountry &&
                            hasSelectedCountryCities) {
                          return const SizedBox.shrink();
                        }
                        // Show other countries normally
                        return _buildCityTile(
                          context,
                          state,
                          cubit,
                          country,
                          isCountry: true,
                        );
                      }),
                    ] else ...[
                      // Search Results
                      // 1. Priority: City Matches (Show Header -> Cities)
                      ...cityMatchedCountries.map((country) {
                        return Padding(
                          padding: 4.vertPad,
                          child: Column(
                            crossAxisAlignment: .start,
                            spacing: 4.h,
                            children: [
                              _buildSectionHeader(country.name),
                              ...country.cities?.map((city) {
                                    return _buildCityTile(
                                      context,
                                      state,
                                      cubit,
                                      city,
                                    );
                                  }) ??
                                  [],
                            ],
                          ),
                        );
                      }),

                      // 2. Secondary: Country-only Matches (Show under International)
                      if (countryOnlyMatchedCountries.isNotEmpty) ...[
                        Padding(
                          padding: 12.topPad,
                          child: _buildSectionHeader('International'),
                        ),
                        ...countryOnlyMatchedCountries.map((country) {
                          return _buildCityTile(
                            context,
                            state,
                            cubit,
                            country,
                            isCountry: true,
                          );
                        }),
                      ],
                    ],
                  ],
                ),
        );
      },
    );
  }

  Widget _buildCountrySection(
    BuildContext context,
    AuthState state,
    AuthCubit cubit,
  ) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 8.h,
      children: [
        _buildSectionHeader(state.selectedCountry?.name ?? ''),
        if (state.selectedCountry?.cities?.isNotEmpty ?? false)
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                children:
                    state.selectedCountry?.cities
                        ?.map(
                          (city) => _buildCityTile(context, state, cubit, city),
                        )
                        .toList() ??
                    [],
              ),
            ),
          )
        else
          _buildCityTile(
            context,
            state,
            cubit,
            state.selectedCountry,
            isCountry: true,
          ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(title, style: AppTextStyle.s16w500());
  }

  Widget _buildCityTile(
    BuildContext context,
    AuthState state,
    AuthCubit cubit,
    Country? city, {
    bool isCountry = false,
  }) {
    final isSelected =
        (isCountry ? state.selectedCountry?.name : state.selectedCity?.name) ==
        city?.name;

    return InkWell(
      onTap: () {
        if (isCountry) {
          _handleCountrySelection(cubit, city);
        } else {
          cubit.selectCity(city!);
        }
      },
      child: Padding(
        padding: 8.vertPad,
        child: Row(
          spacing: 8.w,
          children: [
            Container(
              width: 16,
              height: 16,
              margin: 2.allPad,
              padding: 3.allPad,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.blackColor
                      : AppColors.color6C757D,
                  width: 1.2,
                ),
              ),
              child: isSelected
                  ? const CircleAvatar(backgroundColor: AppColors.blackColor)
                  : null,
            ),
            Padding(
              padding: 6.leftPad,
              child: Text(
                city?.name ?? '',
                style: AppTextStyle.s14w400(color: AppColors.textPrimaryColor),
              ),
            ),
            _buildStatusBadge(city?.launchStatus ?? .WAITLIST),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(CityStatus status) {
    switch (status) {
      case .LIVE:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.lightGreenColor,
            borderRadius: 20.radius,
          ),
          child: Row(
            mainAxisSize: .min,
            spacing: 4.w,
            children: [
              Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                  shape: .circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF5BFF5B), Color(0xFF019101)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Text(
                context.l10n.nowLive,
                style: AppTextStyle.s10w400(color: AppColors.greenColor),
              ),
            ],
          ),
        );
      case .launchingNext:
      case .WAITLIST:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.colorF5F5F5,
            borderRadius: 20.radius,
          ),
          child: Row(
            mainAxisSize: .min,
            spacing: 4.w,
            children: [
              Icon(
                status == .WAITLIST ? Icons.email_outlined : Icons.access_time,
                size: 12,
                color: AppColors.textGreyColor,
              ),
              Text(
                status == .WAITLIST
                    ? context.l10n.joinWaitlist
                    : context.l10n.launchingNext,
                style: AppTextStyle.s10w400(),
              ),
            ],
          ),
        );
    }
  }
}

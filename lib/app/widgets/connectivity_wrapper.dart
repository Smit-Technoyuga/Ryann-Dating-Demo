import 'package:flutter/material.dart';
import 'package:ryann_dating/app/widgets/no_internet_banner.dart';

class ConnectivityWrapper extends StatelessWidget {
  const ConnectivityWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return NoInternetBanner(child: child);
  }
}

import 'package:flutter/material.dart';


class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    super.key,
    required this.title,
    this.icon
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize; // default is 56.0
  final String title;
  final Widget? icon;


  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 4,
        centerTitle: true,

        automaticallyImplyLeading: false,

        title:  Text(
          title,

        ));
  }
}
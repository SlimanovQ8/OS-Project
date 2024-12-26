import 'package:b6arya/pages/battery_comparsion_page.dart';
import 'package:b6arya/pages/custom_battery/custom_battery.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/pages/home/home_tap/home_uI.dart';
import '/pages/home/settings_tap/settings_ui.dart';
import '/pages/home/texts.dart';
import '/widgets/common_widgets.dart';
import '/widgets/default_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: _bottomNavIndex == 0 ? "Home" : _bottomNavIndex == 1 ? "Custom Workload" : _bottomNavIndex == 2 ? "Comparison" : "Settings"),
      body: _bottomNavIndex == 0
          ? HomeUi() : _bottomNavIndex == 1 ? CustomBattery() : _bottomNavIndex == 2 ? BatteryComparisonPage()
              : SettingsUi(),


      bottomNavigationBar: customBottomBar(
        context: context,
        bottomNavIndex: _bottomNavIndex,
        onItemSelected: (index) => setState(() => _bottomNavIndex = index),
      ),
    );
  }

  var _bottomNavIndex = 0; //default index of a first screen
}

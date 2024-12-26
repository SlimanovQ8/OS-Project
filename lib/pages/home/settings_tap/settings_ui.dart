import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../provider/theme_provider.dart';
import '../../../shared_preferences/shared_preferences_functions.dart';


class SettingsUi extends StatelessWidget {
  SettingsUi({super.key});

  final double padding = 10;
  final double avatarRadius = 20;
  int selectedRadio = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    selectedRadio = context.locale.toString() == "en" ? 1 : 2;
    return SingleChildScrollView(
      child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.fromLTRB(24, 18, 24, 12),
            child: Row(
              children: [
                const Icon(Icons.widgets),
                const SizedBox(
                  height: 0,
                  width: 12,
                ),
                Text(
                  "common",
                  style: Theme.of(context).textTheme.labelLarge,
                ).tr()
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: Divider(
              thickness: 1.0,
              height: 1.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: ListTile(
              title: const Text("language").tr(),
              leading: const Icon(Icons.language),
              subtitle:
                  Text(context.locale.toString() == "ar" ? "arabic" : "english")
                      .tr(),
              trailing: Icon(context.locale.toString() == "en"
                  ? Icons.keyboard_arrow_right
                  : Icons.keyboard_arrow_left),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder: (context, setStatee) {
                        return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                      left: padding,
                                      top: avatarRadius + padding,
                                      right: padding,
                                      bottom: padding),
                                  margin: EdgeInsets.only(top: avatarRadius),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      borderRadius:
                                          BorderRadius.circular(padding),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black,
                                            offset: Offset(0, 10),
                                            blurRadius: 10),
                                      ]),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const Text(
                                        "language",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600),
                                      ).tr(),
                                      const SizedBox(
                                        height: 22,
                                      ),
                                      RadioListTile(
                                          value: 1,
                                          groupValue: selectedRadio,
                                          title: const Text("English"),
                                          onChanged: (value) {
                                            setStatee(() {
                                              selectedRadio = value as int;
                                            });
                                          }),
                                      RadioListTile(
                                          value: 2,
                                          groupValue: selectedRadio,
                                          title: const Text("العربية"),
                                          onChanged: (value) {
                                            setStatee(() {
                                              selectedRadio = value as int;
                                            });
                                          }),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              //reset();
                                              selectedRadio == 1
                                                  ? context.setLocale(
                                                      const Locale('en'))
                                                  : context.setLocale(
                                                      const Locale('ar'));

                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              "confirm",
                                              style: TextStyle(fontSize: 18),
                                            ).tr()),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ));
                      });
                    });
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: ListTile(
              title: const Text("Theme").tr(),
              leading: Icon(isDark! ? Icons.dark_mode : Icons.light_mode),
              //subtitle: Text("eiss.alsdf@gmail.com"),
              trailing: ToggleSwitch(
                initialLabelIndex: isDark! ? 1 : 0,
                totalSwitches: 2,

                minWidth: 81.0,
                // activeBgColor: const [Colors.indigo],
                // activeFgColor: Colors.white,
                // inactiveBgColor:
                // const Color.fromARGB(255, 185, 185, 185),
                //minHeight: 90.0,
                fontSize: 16.0,
                labels: [
                  'Light'.tr(),
                  'Dark'.tr(),
                ],
                onToggle: (index) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme(index!);
                },
              ),
            ),
          ),

          //begin


        ],
      ),
    );
  }
}

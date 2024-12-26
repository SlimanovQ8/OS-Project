import 'dart:io';

import 'package:b6arya/classes/text_fields_rich_text.dart';
import 'package:b6arya/classes/text_input_formatter.dart';
import 'package:b6arya/firebase/constants.dart';
import 'package:b6arya/firebase/device_functions.dart';
import 'package:b6arya/firebase/user_device_functions.dart';
import 'package:b6arya/main.dart';
import 'package:b6arya/models/user_device.dart';
import 'package:b6arya/themes/theme_helper.dart';
import 'package:b6arya/widgets/common_widgets.dart';
import 'package:b6arya/widgets/default_app_bar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../constants/colors.dart';
import '../../constants/variables.dart';
import '../../models/phone.dart';
import '../home/home_tap/home.dart';

class ChoosePhone extends StatefulWidget {
  const ChoosePhone({super.key});

  @override
  State<ChoosePhone> createState() => _ChoosePhoneState();
}
class _ChoosePhoneState extends State<ChoosePhone> {
  List<bool> isMenuOpened = List.filled(3, false);
  int batteryHealth = -1;
  final TextEditingController _modelController = TextEditingController();
  bool isLoading = false;
  final TextEditingController healthController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: DefaultAppBar(title: "Phone Setup",),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Choose Your Phone", style: TextStyle(fontSize: 24),),

                  ),
                  SizedBox(height: 14,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText().richText(
                          text: "Brand",
                          isOptional: false
                      ),
                      ToggleSwitch(
                        initialLabelIndex: userDeviceBrand,
                        totalSwitches: 3,
                        minWidth: 90.0,

                        //minHeight: 90.0,
                        labels: phoneBrandList,
                        onToggle: (index) {
                          userDeviceBrand = index!;
                          selectedModel = allDevices
                              .where((e) =>
                          e.brand == phoneBrandList[userDeviceBrand])
                              .map((e) => e.model)
                              .first;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 14,),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: AppText().richText(
                        text: "Model",
                        isOptional: false
                    ),
                  ),
                  AppText().dropDownMenu(width: width,
                    title: "Select Model",
                    value: selectedModel,
                    itemsList: allDevices.where((e) =>
                    e.brand == phoneBrandList[userDeviceBrand])
                        .map((e) => e.model)
                        .toList(),
                    translated: false,
                    onChanged: (value) {
                      setState(() {
                        selectedModel = value;
                        isModelSelected = true;
                      });
                    },
                    context: context,
                    isDDOpen: isMenuOpened[0],
                    onOpened: (isOpen) {
                      isMenuOpened[0] = isOpen;
                      setState(() {

                      });
                    },
                    searchController: _modelController,

                  ),
                  SizedBox(height: 14,),
                  Container(
                      alignment: Alignment.bottomLeft,
                      child: AppText().richText(
                        text: "Battery Health",
                      )
                  ),
                  TextFormField(
                    decoration: ThemeHelper().textInputDecoration(
                      labelText: "Enter Battery Health",
                      suffixIcon: Icon(Icons.percent),
                    ),
                    autovalidateMode: AutovalidateMode.always,
                    controller: healthController,
                    style: TextStyle(color: textColor),

                    onChanged: (val) {
                      if (val.isNotEmpty) {
                        if (int.parse(val) >= 100) {
                          healthController.text = "100";
                          batteryHealth = 100;
                        }
                        else {
                          batteryHealth = int.parse(val);
                        }
                      }
                      setState(() {

                      });
                    },
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,

                    maxLines: 1,
                    maxLength: 3,
                    inputFormatters: [
                      // MaxLinesInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  isModelSelected? featureWidget(width: width/1.3, label: "Battery Info", phone: allPhones.where((element) => element.name.contains(selectedModel!)).first): Container(),
                   ElevatedButton(
                      onPressed: isModelSelected ? save : null,
                      child: Text("Save"),
                      style: ButtonStyle(
                        minimumSize: WidgetStateProperty.all( Size(width / 1.4, 50)),
                      ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if(isLoading)
          opacity(),
        if (isLoading)
          loadingIndicator(),
      ],
    );
  }
  void save() async {
    isLoading = true;
    bool isAdded = false;
    String deviceID = await getDeviceID();

          UserDevice userDevice = UserDevice(
            batteryHealth: batteryHealth,
              uuid: deviceID,
              phone:  allPhones.where((element) => element.name.contains(selectedModel!)).first
          );
          await addUserDevice(userDevice).then((onSuccess) {
           isAdded = true;
        }).catchError((error) {
          isLoading = false;
          });
          if (isAdded) {
            myDevice = await getUserDeviceByUuid(deviceID);
            if (myDevice != null) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            }
            else {
              isLoading = false;
            }
          }
          isLoading = false;
          setState(() {

          });
    print(deviceID);
  }
  Widget featureWidget(
      {required double width, required String label, required Phone phone,}) {
    return Container(
      width: width / 1.5,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(phone.name, style: theme.textTheme.titleLarge,),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.battery_std),
                  Text(label.tr(), style: const TextStyle(
                      fontSize: 15
                  ),)
                ],
              )
          ),

          Text("Capacity:    ${phone.batteryCapacity}"),
          Text(batteryHealth == -1 ? "Battery Health: Not Specified" : "Health:    ${batteryHealth}%"),
          Text(batteryHealth == -1 ? "Actual Capacity: ${phone.batteryCapacity}" : "Actual Capacity: ${
              calculateActualCapacity(batteryHealth: batteryHealth, batteryCapacity: phone.batteryCapacity)}"),
        ],
      ),
    );
  }
  
}
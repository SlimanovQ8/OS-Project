import 'package:b6arya/firebase/constants.dart';
import 'package:b6arya/models/custom_workload.dart';
import 'package:b6arya/models/workload.dart';
import 'package:b6arya/pages/custom_battery/widgets/workload_summary_card.dart';
import 'package:b6arya/widgets/default_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../blocs/bloc_classes.dart';
import '../../classes/text_fields_rich_text.dart';
import '../../constants/colors.dart';
import '../../constants/texts.dart';
import '../../constants/variables.dart';
import '../../firebase/battery_calculation.dart';
import '../../main.dart';
import '../../themes/theme_helper.dart';
import '../home/home_tap/home_uI.dart';

class CustomBattery extends StatefulWidget {
  const CustomBattery({super.key});

  @override
  State<CustomBattery> createState() => _CustomBatteryState();
}

String? v;

class _CustomBatteryState extends State<CustomBattery> {
  final TextEditingController workloadsNumberTextController = TextEditingController();

  List<TextEditingController> workLoadDurationTextControllers = [
    TextEditingController()..text = ""
  ];

  List<bool> isDDOpen = [false];

  List<String?> workloadsList= [v];

  List <CustomWorkload> customWorkload = [];
  List <double> batteryDrain = [];

  int tappedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => intB(),
          ),
        ],
        child: BlocBuilder<intB, int>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListView(
                children: [
                  // Current Battery Indicator
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: CircularPercentIndicator(
                        radius: 60.0,
                        lineWidth: 9.0,
                        animationDuration: 2000,
                        animation: true,
                        curve: Curves.ease,
                        percent: currentBattery / 100,
                        center: Text(
                          "${currentBattery.toInt()}%",
                          style: TextStyle(
                            color: textColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        progressColor: greenGradient[1],
                      ),
                    ),
                  ),

                  // Brightness Slider
                  Column(
                    children: [
                      Text(
                        "System Brightness",
                        style: theme.textTheme.titleMedium,
                      ),
                      Slider(
                        min: 0,
                        max: 100,
                        divisions: 100,
                        label: "$currentBrightness",
                        value: currentBrightness,
                        onChanged: (value) {
                          setApplicationBrightness(value / 100);
                          currentBrightness = value;
                          context.read<intB>().emit(currentBrightness.toInt());
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Dynamic Workload Fields
                  Column(
                    children: List.generate(
                      workLoadDurationTextControllers.length,
                          (index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Dropdown for workload selection
                              SizedBox(
                                width: width / 2,
                                child: AppText().dropDownMenu(
                                  width: width,
                                  title: "Select Wortkload",
                                  itemsList: allWorkloads.map((e) => e.name).toList(),
                                  isDDOpen: isDDOpen[index],
                                  context: context,
                                  onOpened: (isOpen) {
                                    isDDOpen[index] = isOpen;
                                    setState(() {});
                                  },
                                  value: workloadsList[index],
                                  onChanged: (value) {
                                    setState(() {
                                      workloadsList[index] = value as String;
                                    });
                                  },
                                ),
                              ),

                              // TextField for minutes
                              SizedBox(
                                width: width / 4,
                                child: TextFormField(
                                  controller: workLoadDurationTextControllers[index],
                                  decoration: ThemeHelper().textInputDecoration(
                                    labelText: "Min",
                                  ),
                                  autovalidateMode: AutovalidateMode.always,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  style: TextStyle(color: textColor),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // Buttons: Calculate + Add Workload
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: _validateAndCalculate,
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            minimumSize: Size(width / 1.8, 50),
                          ),
                          child: Text("Calculate"),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          workLoadDurationTextControllers.add(TextEditingController()..text = "");
                          isDDOpen.add(false);
                          workloadsList.add(v);
                          setState(() {});
                        },
                        child: Text(
                          "+ " + "Add Workload".tr(),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Pie Chart
                  batteryDrain.isEmpty
                      ? Container()
                      : SfCircularChart(
                    palette: topColors,
                    legend: Legend(
                      isVisible: true,
                      position: LegendPosition.left,
                      orientation: LegendItemOrientation.vertical,
                    ),
                    series: <PieSeries<CustomWorkload, String>>[
                      PieSeries<CustomWorkload, String>(
                        onPointTap: (ChartPointDetails details) {
                          tappedIndex = details.pointIndex ?? -1;
                          setState(() {});
                        },
                        explode: false,
                        explodeIndex: 0,
                        dataSource: customWorkload.toList(),
                        xValueMapper: (CustomWorkload data, _) => data.name.toString(),
                        yValueMapper: (CustomWorkload data, _) => data.totalBatteryDrain,
                        dataLabelMapper: (CustomWorkload data, _) => data.totalBatteryDrain.toString(),
                        startAngle: 90,
                        endAngle: 90,
                        dataLabelSettings: const DataLabelSettings(isVisible: true),
                      ),
                    ],
                  ),

                  // If the user taps a pie slice, show the summary card
                  (tappedIndex != -1 && tappedIndex <= customWorkload.length - 1)
                      ? WorkloadSummaryCard(
                    tappedIndex: tappedIndex,
                    customWorkload: customWorkload,
                  )
                      : Container(),
                ],
              ),
            );
          },
        ),
      );
  }

  /// Validate the input fields before calculating
  void _validateAndCalculate() {
    for (int i = 0; i < workLoadDurationTextControllers.length; i++) {
      final minutesText = workLoadDurationTextControllers[i].text.trim();
      final selectedItem = workloadsList[i];

      if (minutesText.isEmpty || minutesText == "0") {
        _showErrorSnackbar("Please enter a valid duration for workload #${i + 1}");
        return;
      }

      if (selectedItem == null || selectedItem.isEmpty) {
        _showErrorSnackbar("Please select a valid workload for workload #${i + 1}");
        return;
      }
    }

    calculate();
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Calculation logic
  calculate() async {
    // Clear old data
    customWorkload.clear();
    batteryDrain.clear();

    for (int i = 0; i < workLoadDurationTextControllers.length; i++) {
      final workloadName = workloadsList[i];
      final durationText = workLoadDurationTextControllers[i].text;
      final selectedWorkload = allWorkloads.firstWhere((e) => e.name == workloadName);

      Map<String, double> catEstimatePerDevice = selectedWorkload.estimatedMahPerDevice;
      bool isPhoneExist = catEstimatePerDevice.containsKey(myDevice!.phone.name);

      if (isPhoneExist) {
        double appPowerConsumptionMw = selectedWorkload.estimatedMahPerDevice[myDevice!.phone.name]!;
        double result = calculateBatteryDrain(
          batteryCapacityMah: myDevice!.phone.batteryCapacity + 0.0,
          batteryVoltageV: 3.85,
          batteryHealthPercent: myDevice!.batteryHealth + 0.0,
          appPowerConsumptionMw: appPowerConsumptionMw,
          maxDisplayPowerMw: 500,
          brightnessPercent: currentBrightness,
          usageTimeMinutes: double.parse(durationText), // from text field
          batteryLevel: currentBattery,
        );

        batteryDrain.add(result);

        // For demonstration, you have a custom formula for distribution:
        double displayPowerConsumptionMw = 500 * (currentBrightness / 100);
        double totalCPUPowerConsumptionMw = appPowerConsumptionMw + displayPowerConsumptionMw;
        double totalPowerConsumptionMw = totalCPUPowerConsumptionMw / 0.35;
        double networkPowerConsumptionMw = 0.25 * totalPowerConsumptionMw;
        double wifiPowerConsumptionMw = 0.25 * totalPowerConsumptionMw;
        double otherPowerConsumptionMw = 0.15 * totalPowerConsumptionMw;

        customWorkload.add(
          CustomWorkload(
            id: selectedWorkload.id,
            name: selectedWorkload.name,
            totalBatteryDrain: result,
            displayPowerConsumptionMw: displayPowerConsumptionMw,
            totalCPUPowerConsumptionMw: totalCPUPowerConsumptionMw,
            totalPowerConsumptionMw: totalPowerConsumptionMw,
            networkPowerConsumptionMw: networkPowerConsumptionMw,
            wifiPowerConsumptionMw: wifiPowerConsumptionMw,
            otherPowerConsumptionMw: otherPowerConsumptionMw,
          ),
        );
      }
    }

    // Sort workloads by battery drain descending
    customWorkload.sort((a, b) => b.totalBatteryDrain.compareTo(a.totalBatteryDrain));

    setState(() {});
  }
}

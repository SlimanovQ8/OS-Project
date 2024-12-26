import 'dart:io';
import 'package:b6arya/api/device_api.dart';
import 'package:b6arya/firebase/constants.dart';
import 'package:b6arya/firebase/device_functions.dart';
import 'package:b6arya/models/user_device.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_marketing_names/device_marketing_names.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:screen_brightness/screen_brightness.dart';

import '../../../blocs/bloc_classes.dart';
import '../../../constants/colors.dart';
import '../../../constants/variables.dart';
import '../../../firebase/battery_calculation.dart';
import '../../../main.dart';
import '../../../models/workload.dart';
import '../../../themes/theme_helper.dart';
import '../../../widgets/common_widgets.dart';

// Keep track of current battery (somewhere in state management as well)
int currentBattery = 0;

class HomeUi extends StatelessWidget {
  HomeUi({super.key});

  /// For user to input how many minutes to estimate
  final TextEditingController estimatedTextController = TextEditingController(text: "60");

  /// Device name placeholders
  String singleDeviceName = "Unknown";
  String singleDeviceNameFromModel = "Unknown";
  String deviceNames = "Unknown";
  String deviceNamesFromModel = "Unknown";

  double usageTimeOnMin = 60;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => intB()),
      ],
      child: BlocBuilder<intB, int>(
        builder: (context, state) {
          return Scaffold(
            /// If you already have a bottom bar in a separate file,
            /// just place the body here and your bottom bar in the parent.
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      /// 1. Battery & Brightness Card
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                          child: Column(
                            children: [
                              // Current Battery Percentage
                              Center(
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
                              const SizedBox(height: 16),

                              // Brightness Slider
                              Text(
                                "System Brightness",
                                style: Theme.of(context).textTheme.titleMedium,
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
                        ),
                      ),

                      const SizedBox(height: 16),

                      /// 2. Device / Battery Info Card
                      if (myDevice != null)
                        Card(

                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: _buildDeviceInfo(context, myDevice!),
                          ),
                        ),

                      const SizedBox(height: 16),

                      /// 3. Battery Estimate + Workloads
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Title row: "Battery estimate after" & minutes
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Battery estimate after",
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  SizedBox(
                                    width: 80,
                                    child: TextFormField(
                                      controller: estimatedTextController,
                                      decoration: ThemeHelper().textInputDecoration(
                                        labelText: "min",
                                      ),
                                      autovalidateMode: AutovalidateMode.always,
                                      style: TextStyle(color: textColor),
                                      onChanged: (value) {
                                        if (value.isEmpty) {
                                          usageTimeOnMin = 0;
                                        } else {
                                          usageTimeOnMin = double.tryParse(value) ?? 0;
                                        }
                                        context.read<intB>().emit(usageTimeOnMin.toInt());
                                      },
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      maxLines: 1,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              /// Workload list
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: allWorkloads.length,
                                itemBuilder: (BuildContext con, int index) {
                                  return _buildWorkloadCard(context, allWorkloads[index]);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Builds the device info card content
  Widget _buildDeviceInfo(BuildContext context, UserDevice device) {
    return Container(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Device Name
          Text(
            device.phone.name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          // "Battery Info" Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.battery_std),
              const SizedBox(width: 6),
              Text(
                "Battery Info".tr(),
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Battery capacity, health, actual capacity
          Text("Capacity:    ${device.phone.batteryCapacity}",
              style: Theme.of(context).textTheme.bodyLarge),
          Text("Health:    ${device.batteryHealth}%",
              style: Theme.of(context).textTheme.bodyLarge),
          Text(
            "Actual Capacity: ${calculateActualCapacity(batteryHealth: device.batteryHealth, batteryCapacity: device.phone.batteryCapacity)}",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  /// Builds each workload entry with name, sample apps, estimated drain, and a circular indicator for estimated battery level
  Widget _buildWorkloadCard(BuildContext context, Workload workload) {
    // Calculate the drain and battery level
    final double drain = calculateBatteryDrain(
      batteryCapacityMah: myDevice!.phone.batteryCapacity + 0.0,
      batteryVoltageV: 3.85,
      batteryHealthPercent: myDevice!.batteryHealth + 0.0,
      appPowerConsumptionMw: workload.estimatedMahPerDevice.values.first,
      maxDisplayPowerMw: 500,
      brightnessPercent: currentBrightness,
      usageTimeMinutes: usageTimeOnMin,
      batteryLevel: currentBattery,
    );

    // If you have logic for an "estimatedBatteryLevel", define or compute it here:
    // e.g. final double estimatedBatteryLevel = currentBattery - drain (just as an example).
    // For now, let's just pretend we have some nextBatteryLevel:
    final double nextBatteryLevel = (currentBattery - drain).clamp(0, 100);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: customBoxDecoration(
        shadowColor: shadowColors[2],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Workload name + sample apps
            Text(
              workload.name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              workload.sampleApps.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 8),

            // Row with Estimated Drain + Next Battery Level
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Estimated Drain
                Text(
                  "Estimated Drain ${drain.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                // Battery circular indicator
                CircularPercentIndicator(
                  radius: 35.0,
                  lineWidth: 4.0,
                  percent: nextBatteryLevel <= 0.0 ? 0 : (nextBatteryLevel / 100),
                  center: Text(
                    "${nextBatteryLevel <= 0.0 ? 0 : nextBatteryLevel.toInt()}%",
                    style: TextStyle(color: textColor),
                  ),
                  progressColor: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

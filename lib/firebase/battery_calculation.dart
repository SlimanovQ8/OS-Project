import 'package:battery_plus/battery_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:screen_brightness/screen_brightness.dart';
double estimatedBatteryLevel = 88;
double calculateBatteryDrain({
  required double batteryCapacityMah,       // Battery Capacity in mAh
  required double batteryVoltageV,         // Battery Voltage in V
  required double batteryHealthPercent,    // Battery Health in %
  required double appPowerConsumptionMw,   // App Power Consumption in mW
  required double maxDisplayPowerMw,       // Max Display Power in mW
  required double brightnessPercent,       // Brightness Level in %
  required double usageTimeMinutes,        // Usage Time in minutes
  required int batteryLevel,
}) {
  // Adjust Battery Capacity for Health
  double effectiveBatteryCapacityMah = batteryCapacityMah * (batteryHealthPercent / 100);
  print(effectiveBatteryCapacityMah);
  // Total Battery Energy in mWh
  double totalBatteryEnergyMwh = effectiveBatteryCapacityMah * batteryVoltageV;
  print(totalBatteryEnergyMwh);
  // Display Power Consumption in mW
  double displayPowerConsumptionMw = maxDisplayPowerMw * (brightnessPercent / 100);
  // Total Power Consumption in mW
  double totalCPUPowerConsumptionMw = appPowerConsumptionMw + displayPowerConsumptionMw;
  double totalPowerConsumptionMw = totalCPUPowerConsumptionMw / 0.35;
  double networkPowerConsumptionMw = 0.25 * totalPowerConsumptionMw;
  double wifiPowerConsumptionMw = 0.25 * totalPowerConsumptionMw;
  double otherPowerConsumptionMw = 0.15 * totalPowerConsumptionMw;


  // Energy Consumed in mWh
  double energyConsumedMwh = totalPowerConsumptionMw * (usageTimeMinutes / 60);

  print("apc $appPowerConsumptionMw tpc $totalPowerConsumptionMw");
  // Battery Drain Percentage
  double batteryDrainPercent = (energyConsumedMwh / totalBatteryEnergyMwh) * 100;

  String expectedBattery = batteryDrainPercent.toStringAsFixed(2);
  batteryDrainPercent = double.parse(expectedBattery);
  estimatedBatteryLevel = batteryLevel - batteryDrainPercent;
  return batteryDrainPercent;
}
Future<int> currentBatteryLevel() async {
  int level = await Battery().batteryLevel;
  return level;
}

double currentBrightness = 0;
Future<double> get systemBrightness async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();


  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  print('Running on ${androidInfo.brand}');  // e.g. "Moto G (4)"

  try {

    double brightness = await ScreenBrightness.instance.system;
    print(brightness);
    currentBrightness = brightness * 100;
    return brightness;
  } catch (e) {
    print(e);
    throw 'Failed to get system brightness';
  }
}
Future<void> setApplicationBrightness(double brightness) async {
  try {
    await ScreenBrightness.instance
        .setSystemScreenBrightness(brightness);
  } catch (e) {
    debugPrint(e.toString());
    throw e.toString();
  }
}
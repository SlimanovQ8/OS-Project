import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';

class BatteryEstimator extends StatefulWidget {
  @override
  _BatteryEstimatorState createState() => _BatteryEstimatorState();
}

class _BatteryEstimatorState extends State<BatteryEstimator> {
  final Battery _battery = Battery();
  int _batteryLevel = 100;
  double _batteryCapacity = 4000; // in mAh, example value
  double _batteryVoltage = 3.7; // in Volts, average value
  double _appPowerConsumption = 500; // in mW, example for Instagram
  double _duration = 1.0; // in hours, user input

  @override
  void initState() {
    super.initState();
    _initBatteryLevel();
  }

  Future<void> _initBatteryLevel() async {
    int level = await _battery.batteryLevel;
    setState(() {
      _batteryLevel = level;
    });
  }

  double _calculateExpectedBatteryLevel() {
    // Total Battery Energy in mWh
    double totalBatteryEnergy = _batteryCapacity * _batteryVoltage;

    // Energy Consumption in mWh
    double energyConsumption = _appPowerConsumption * _duration;

    // Battery Drain Percentage
    double batteryDrainPercentage = (energyConsumption / totalBatteryEnergy) * 100;

    // Expected Battery Level
    double expectedBatteryLevel = _batteryLevel - batteryDrainPercentage;
    return expectedBatteryLevel.clamp(0, 100);
  }

  @override
  Widget build(BuildContext context) {
    double expectedLevel = _calculateExpectedBatteryLevel();

    return Scaffold(
      appBar: AppBar(title: Text('Battery Estimator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Current Battery Level: $_batteryLevel%'),
            SizedBox(height: 20),
            Text('Expected Battery Level after $_duration hour(s) of usage: ${expectedLevel.toStringAsFixed(2)}%'),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/bloc_classes.dart';
import '../../constants/colors.dart';
import '../../constants/variables.dart';
import '../../firebase/battery_calculation.dart';
import '../../models/phone.dart';
import '../../models/workload.dart';
import '../../themes/theme_helper.dart';
import '../../widgets/default_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';

import '../main.dart';

class BatteryComparisonPage extends StatefulWidget {
  const BatteryComparisonPage({Key? key}) : super(key: key);

  @override
  State<BatteryComparisonPage> createState() => _BatteryComparisonPageState();
}

class _BatteryComparisonPageState extends State<BatteryComparisonPage> {
  /// List of phones fetched from Firestore
  List<Phone> allPhones = [];

  /// The user-selected phone from the dropdown
  Phone? selectedPhone;

  /// A text controller for usage minutes
  final TextEditingController usageMinutesController =
  TextEditingController(text: "60");

  /// Indicates if data is being loaded
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAllPhones();
  }

  /// Fetch all phones from Firestore
  Future<void> _fetchAllPhones() async {
    try {
      final QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection("Phones").get();

      // Map each doc to a Phone model
      allPhones = snapshot.docs.map((doc) => Phone.fromDocument(doc)).toList();
    } catch (e) {
      debugPrint("Error fetching phones: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  /// Compare battery drain for the same usage scenario
  double _calculateBatteryDrainForPhone(Phone phone, double usageMinutes) {
    // Hard-coded for demonstration
    const double appPowerConsumptionMw = 500;
    const double brightnessPercent = 50;
    const double maxDisplayPowerMw = 500;

    // For demonstration, assume 100% battery health for the 'other' phone
    double batteryHealthPercent = 100;

    double result = calculateBatteryDrain(
      batteryCapacityMah: phone.batteryCapacity + 0.0,
      batteryVoltageV: 3.85,
      batteryHealthPercent: batteryHealthPercent,
      appPowerConsumptionMw: appPowerConsumptionMw,
      maxDisplayPowerMw: maxDisplayPowerMw,
      brightnessPercent: brightnessPercent,
      usageTimeMinutes: usageMinutes,
      batteryLevel: 100, // for comparison
    );
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => intB()),
      ],
      child: Scaffold(
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              _buildMyPhoneInfo(context),
              const SizedBox(height: 16),
              _buildSelectPhoneDropdown(context),
              const SizedBox(height: 16),
              _buildUsageTimeInput(context),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: selectedPhone == null
                    ? null
                    : () {
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text("Compare"),
              ),
              const SizedBox(height: 16),
              if (selectedPhone != null) _buildComparisonResults(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Display the user phone info (from myDevice)
  Widget _buildMyPhoneInfo(BuildContext context) {
    if (myDevice == null) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: const Text("No current phone data found."),
      );
    }

    final phone = myDevice!.phone;
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("My Phone", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text("Name: ${phone.name}"),
            Text("Battery: ${phone.batteryCapacity} mAh"),
            Text("CPU Frequency: ${phone.cpuFrequency} MHz"),
            Text("RAM: ${phone.ram} MB"),
            Text("Nits Range: ${phone.minimumNits}-${phone.maximumNits}"),
          ],
        ),
      ),
    );
  }

  /// Dropdown to select another phone
  Widget _buildSelectPhoneDropdown(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: DropdownButton<Phone>(
          isExpanded: true,
          hint: const Text("Select another phone"),
          value: selectedPhone,
          onChanged: (Phone? newValue) {
            setState(() {
              selectedPhone = newValue;
            });
          },
          items: allPhones.map<DropdownMenuItem<Phone>>((Phone phone) {
            return DropdownMenuItem<Phone>(
              value: phone,
              child: Text(phone.name),
            );
          }).toList(),
        ),
      ),
    );
  }

  /// Text field for usage minutes
  Widget _buildUsageTimeInput(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextFormField(
          controller: usageMinutesController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration:
          ThemeHelper().textInputDecoration(labelText: "Usage minutes"),
        ),
      ),
    );
  }

  /// Build a row showing both phones' estimated drain side by side
  Widget _buildComparisonResults(BuildContext context) {
    if (myDevice == null) {
      return const SizedBox.shrink();
    }

    final double usageTime =
        double.tryParse(usageMinutesController.text) ?? 0.0;

    // Calculate battery drain for user's phone
    final myPhone = myDevice!.phone;
    double myPhoneDrain = _calculateBatteryDrainForPhone(myPhone, usageTime);

    // Calculate battery drain for selected phone
    double otherPhoneDrain =
    _calculateBatteryDrainForPhone(selectedPhone!, usageTime);

    return Card(
      color: containerColors[0],
      shadowColor: shadowColors[0],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Comparison Results",
                style: Theme.of(context).textTheme.titleLarge),
            const Divider(thickness: 1, height: 20),
            Row(
              children: [
                /// Card for My Phone
                Expanded(
                  child: _buildPhoneDrainCard(
                    phoneName: myPhone.name,
                    estimatedDrain: myPhoneDrain,
                    context: context,
                    isMyPhone: true,
                  ),
                ),
                const SizedBox(width: 12),
                /// Card for Selected Phone
                Expanded(
                  child: _buildPhoneDrainCard(
                    phoneName: selectedPhone!.name,
                    estimatedDrain: otherPhoneDrain,
                    context: context,
                    isMyPhone: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Show difference or interpret which is better
            _buildInterpretation(myPhone.name, myPhoneDrain,
                selectedPhone!.name, otherPhoneDrain),
          ],
        ),
      ),
    );
  }

  /// A styled card for each phone's estimated drain
  Widget _buildPhoneDrainCard({
    required String phoneName,
    required double estimatedDrain,
    required BuildContext context,
    required bool isMyPhone,
  }) {
    return SizedBox(
      height: height /4,
      child: Card(

        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                isMyPhone ? "My Phone" : "Other Phone",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(phoneName,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[700],
                    fontStyle: FontStyle.italic,
                  )),
              const SizedBox(height: 8),
              Text(
                "Estimated Drain: ${estimatedDrain.toStringAsFixed(2)}%",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.blueGrey[900],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInterpretation(String myPhoneName, double myDrain,
      String otherPhoneName, double otherDrain) {
    double difference = (myDrain - otherDrain).abs();
    String text;

    if (myDrain < otherDrain) {
      text =
      "$myPhoneName drains ${difference.toStringAsFixed(2)}% \nless battery than $otherPhoneName for the same usage.";
    } else if (myDrain > otherDrain) {
      text =
      "$myPhoneName drains ${difference.toStringAsFixed(2)}% \nmore battery than $otherPhoneName for the same usage.";
    } else {
      text = "Both phones have the same estimated drain for this scenario.";
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.start,
      ),
    );
  }
}

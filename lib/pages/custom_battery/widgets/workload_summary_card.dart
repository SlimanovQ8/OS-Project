import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/custom_workload.dart';

class WorkloadSummaryCard extends StatelessWidget {
  final int tappedIndex;
  final List<CustomWorkload> customWorkload;

  const WorkloadSummaryCard({
    Key? key,
    required this.tappedIndex,
    required this.customWorkload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workload = customWorkload[tappedIndex];

    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
// Workload Name
            Text(
              workload.name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

// Row for the Percentage Drains
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildConsumptionColumn(
                    label: "CPU",
                    value: "${_calculatePercentage(workload.totalCPUPowerConsumptionMw, workload.totalPowerConsumptionMw)}%",
                    context: context
                ),
                _buildConsumptionColumn(
                    label: "Wi-Fi",
                    value: "${_calculatePercentage(workload.wifiPowerConsumptionMw, workload.totalPowerConsumptionMw)}%",
                    context: context
                ),
                _buildConsumptionColumn(
                    label: "Network",
                    value: "${_calculatePercentage(workload.networkPowerConsumptionMw, workload.totalPowerConsumptionMw)}%",
                    context: context
                ),
                _buildConsumptionColumn(
                    label: "Display",
                    value: "${_calculatePercentage(workload.displayPowerConsumptionMw, workload.totalPowerConsumptionMw)}%",
                    context: context
                ),
                _buildConsumptionColumn(
                    label: "Other",
                    value: "${_calculatePercentage(workload.otherPowerConsumptionMw, workload.totalPowerConsumptionMw)}%",
                    context: context
                ),
              ],
            ),

            const SizedBox(height: 24),

// Row for the Power Consumption in mW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildConsumptionColumn(
                    label: "CPU",
                    value: "${workload.totalCPUPowerConsumptionMw.toStringAsFixed(2)}",
                    context: context
                ),
                _buildConsumptionColumn(
                    label: "Wi-Fi ",
                    value: "${workload.wifiPowerConsumptionMw.toStringAsFixed(2)}",
                    context: context
                ),
                _buildConsumptionColumn(
                    label: "Network",
                    value: "${workload.networkPowerConsumptionMw.toStringAsFixed(2)}",
                    context: context
                ),
                _buildConsumptionColumn(
                    label: "Display",
                    value: "${workload.displayPowerConsumptionMw.toStringAsFixed(2)}",
                    context: context
                ),
                _buildConsumptionColumn(
                    label: "Other",
                    value: "${workload.otherPowerConsumptionMw.toStringAsFixed(2)}",
                    context: context
                ),
              ],
            ),

            const SizedBox(height: 24),

// Row for total battery drain (14.61% etc.)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total Battery Drain: ",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${workload.totalBatteryDrain}%",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

// Helper method to build each Column in the Row
  Widget _buildConsumptionColumn({
    required String label,
    required String value,
    required BuildContext context,
  }) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.blueGrey[700],
            ),
          ),
        ],
      ),
    );
  }

// Example: calculates (part / total) * 100 for each consumption to show its % of total
  String _calculatePercentage(double part, double total) {
    if (total == 0) return "0";
    double percentage = (part / total) * 100;
    return percentage.toStringAsFixed(1);
  }
}

// Helper method for building table cells
Widget _buildTableCell(String text, {bool isHeader = false}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      style: TextStyle(
        fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        fontSize: isHeader ? 16 : 14,
      ),
    ),
  );
}
//                       Card(
//                         elevation: 3,
//                         margin: const EdgeInsets.all(16),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             children: [
//                               Text(
//                                 "${customWorkload[tappedIndex].name}",
//                                 style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//                               Table(
//                                 border: TableBorder.all(
//                                   color: Colors.grey.shade300,
//                                   width: 1,
//                                 ),
//                                 children: [
// // Table Header
//                                   TableRow(
//                                     decoration: BoxDecoration(color: Colors.grey.shade200),
//                                     children: [
//                                       _buildTableCell("Metric", isHeader: true),
//                                       _buildTableCell("Value", isHeader: true),
//                                     ],
//                                   ),
//
// // Battery Drain Row
//                                   TableRow(
//                                     children: [
//                                       _buildTableCell("Total Battery Drain"),
//                                       _buildTableCell("${customWorkload[tappedIndex].totalBatteryDrain}%"),
//                                     ],
//                                   ),
//
// // Total Power Consumption Row
//                                   TableRow(
//                                     children: [
//                                       _buildTableCell("Total Power (mW)"),
//                                       _buildTableCell("${customWorkload[tappedIndex].totalPowerConsumptionMw}"),
//                                     ],
//                                   ),
//
// // CPU Row
//                                   TableRow(
//                                     children: [
//                                       _buildTableCell("CPU (mW)"),
//                                       _buildTableCell("${customWorkload[tappedIndex].totalCPUPowerConsumptionMw}"),
//                                     ],
//                                   ),
//
// // Wi-Fi Row
//                                   TableRow(
//                                     children: [
//                                       _buildTableCell("Wi-Fi (mW)"),
//                                       _buildTableCell("${customWorkload[tappedIndex].wifiPowerConsumptionMw}"),
//                                     ],
//                                   ),
//
// // Network Row
//                                   TableRow(
//                                     children: [
//                                       _buildTableCell("Network (mW)"),
//                                       _buildTableCell("${customWorkload[tappedIndex].networkPowerConsumptionMw}"),
//                                     ],
//                                   ),
//
// // Display Row
//                                   TableRow(
//                                     children: [
//                                       _buildTableCell("Display (mW)"),
//                                       _buildTableCell("${customWorkload[tappedIndex].displayPowerConsumptionMw}"),
//                                     ],
//                                   ),
//
// // Other Row
//                                   TableRow(
//                                     children: [
//                                       _buildTableCell("Other (mW)"),
//                                       _buildTableCell("${customWorkload[tappedIndex].otherPowerConsumptionMw}"),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
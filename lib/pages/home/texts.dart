import 'package:flutter/cupertino.dart';
import '/constants/texts.dart';

class Texts extends StatelessWidget {
  const Texts({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Large",
            style: displayText(context)[0],
          ),
          Text(
            "Medium",
            style: displayText(context)[1],
          ),
          Text(
            "Small",
            style: displayText(context)[2],
          ),
          SizedBox(height: 16),
          Text(
            "Large",
            style: headlineText(context)[0],
          ),
          Text(
            "Medium",
            style: headlineText(context)[1],
          ),
          Text(
            "Small",
            style: headlineText(context)[2],
          ),
          SizedBox(height: 16),
          Text(
            "Large",
            style: titleText(context)[0],
          ),
          Text(
            "Medium",
            style: titleText(context)[1],
          ),
          Text(
            "Small",
            style: titleText(context)[2],
          ),
          SizedBox(height: 16),
          Text(
            "Large",
            style: bodyText(context)[0],
          ),
          Text(
            "Medium",
            style: bodyText(context)[1],
          ),
          Text(
            "Small",
            style: bodyText(context)[2],
          ),
          SizedBox(height: 16),
          Text(
            "Large",
            style: labelText(context)[0],
          ),
          Text(
            "Medium",
            style: labelText(context)[1],
          ),
          Text(
            "Small",
            style: labelText(context)[2],
          ),
        ],
      ),
    );
  }
}

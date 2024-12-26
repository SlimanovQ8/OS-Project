import 'package:flutter/material.dart';

List<TextStyle> displayText(BuildContext context) => [
  Theme.of(context).textTheme.displayLarge!, // 0
  Theme.of(context).textTheme.displayMedium!, // 1
  Theme.of(context).textTheme.displaySmall!, // 2

];

List<TextStyle> headlineText(BuildContext context) => [
  Theme.of(context).textTheme.headlineLarge!,
  Theme.of(context).textTheme.headlineMedium!,
  Theme.of(context).textTheme.headlineSmall!,

];

List<TextStyle> titleText(BuildContext context) => [
  Theme.of(context).textTheme.titleLarge!,
  Theme.of(context).textTheme.titleMedium!,
  Theme.of(context).textTheme.titleSmall!,
];


List<TextStyle> bodyText(BuildContext context) => [
  Theme.of(context).textTheme.bodyLarge!,
  Theme.of(context).textTheme.bodyMedium!,
  Theme.of(context).textTheme.bodySmall!,
];

List<TextStyle> labelText(BuildContext context) => [
  Theme.of(context).textTheme.labelLarge!,
  Theme.of(context).textTheme.labelMedium!,
  Theme.of(context).textTheme.labelSmall!,
];
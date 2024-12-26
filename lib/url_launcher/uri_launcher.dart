import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

launchWhatsapp(String phoneNumber) async {
  var whatsapp = "965$phoneNumber";
  var whatsappAndroid = Uri.parse("https://wa.me/$whatsapp");
  if (await canLaunchUrl(whatsappAndroid)) {
    await launchUrl(whatsappAndroid,
        mode: LaunchMode.externalNonBrowserApplication);
  } else {}
}

launchInstagram(String username) async {
  var nativeUrl = Uri.parse("instagram://user?username=$username");
  var webUrl = Uri.parse("https://www.instagram.com/$username/");
  if (await canLaunchUrl(nativeUrl)) {
    await launchUrl(
      nativeUrl,
    );
  } else if (await canLaunchUrl(webUrl)) {
    await launchUrl(webUrl);
  } else {
    debugPrint("can't open Instagram");
  }
}

launchApp(String account) async {
  var nativeUrl = Uri.parse(account);
  var webUrl = Uri.parse(account);
  if (await canLaunchUrl(nativeUrl)) {
    await launchUrl(
      nativeUrl,
    );
  } else if (await canLaunchUrl(webUrl)) {
    await launchUrl(webUrl);
  } else {
  }
}

void launchMail() async {
  var mailUrl = Uri.parse('mailto:rentlyappq8@gmail.com');
  try {
    await launchUrl(mailUrl);
  } catch (e) {
    await Clipboard.setData(const ClipboardData(text: "rentlyappq8@gmail.com"));
  }
}
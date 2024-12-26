import 'package:b6arya/api/device_api.dart';
import 'package:b6arya/firebase/battery_calculation.dart';
import 'package:b6arya/firebase/device_functions.dart';
import 'package:b6arya/firebase/user_device_functions.dart';
import 'package:b6arya/models/user_device.dart';
import 'package:b6arya/pages/custom_battery/custom_battery.dart';
import 'package:b6arya/pages/home/home_tap/home_uI.dart';
import 'package:b6arya/pages/startup/choose_phone.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase/auth_functions.dart';
import 'firebase/workload_function.dart';
import 'firebase_options.dart';
import 'provider/theme_provider.dart';
import 'shared_preferences/shared_preferences_functions.dart';
import 'themes/dark.dart';
import 'themes/light.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/variables.dart';
import 'pages/home/home_tap/home.dart';
UserDevice?  myDevice;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await EasyLocalization.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await getDevices();
    await getPhones();
      await retrieveCurrentDevice();

     String deviceID = await getDeviceID();
      myDevice = await getUserDeviceByUuid(deviceID);
    if(myDevice != null){
      print('edfv');
  }
  //await addWorkloadsToFirestore();
  await getWorkloads();
    await systemBrightness;
    currentBattery = await currentBatteryLevel();
// await getDeviceSpec();
  //await updateCurrentUser();
  initScreen = preferences.getInt('initScreen');
  isDark = preferences.getBool('isDark');
  isDark ??= false;


  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: EasyLocalization(
          supportedLocales: const [
            Locale(
              'en',
            ),
            Locale('ar')
          ],
          path:
          'assets/locales', // <-- change the path of the translation files
          fallbackLocale: Locale('ar'),
          child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      theme = Theme.of(context);
      return MaterialApp(
          navigatorKey: navigatorKey,
          theme: lightTheme(),
          darkTheme: darkTheme(),
          localizationsDelegates: context.localizationDelegates,
          debugShowCheckedModeBanner: false,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          themeMode: isDark == null
              ? ThemeMode.system
              : isDark!
              ? ThemeMode.dark
              : ThemeMode.light,
          home:
          // FirebaseAuth.instance.currentUser != null ?
          // const HomePage()
          //     :
          // const LogInPage()
       myDevice == null ? const ChoosePhone() : const HomePage()
      );
    });
  }
}
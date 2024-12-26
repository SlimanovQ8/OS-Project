import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/buttons.dart';
import '../../constants/colors.dart';
import '../../constants/icons.dart';
import '../constants/variables.dart';
import '../url_launcher/uri_launcher.dart';
import 'custom_animated_bottom_bar.dart';

Widget loadingIndicator() {
  return const Opacity(
    opacity: 0.6,
    child: ModalBarrier(dismissible: false, color: Colors.black),
  );
}


BoxDecoration customBoxDecoration({double? blurRadius, double? borderRadius, Color? decorationColor, Color? shadowColor}) {
  return BoxDecoration(
      color: decorationColor?? backgroundColor,
      boxShadow: [
        BoxShadow(
            blurRadius: blurRadius?? 4,
            color: shadowColor?? thirdlyColor
        )
      ],
      borderRadius: BorderRadius.circular(borderRadius?? 15)
  );
}
Widget opacity() {
  return const Center(
    child: SizedBox(
      width: 50,
      height: 50,
      child: CircularProgressIndicator(
        color: appButtons,
      ),
    ),
  );
}

void showCallSheet(
    {required BuildContext context, required List<String> phoneNumbers}) {

  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration:  BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: theme.scaffoldBackgroundColor
          ),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 9,
                ),
                Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      phoneNumbers.length,
                      (index) => ListTile(
                        trailing:   customButtonWithIcon(
                            width: 110,
                            height: 42,
                            icon: Icons.call,
                            borderRadius: 15,
                            maxSize: const Size(200, 200),
                            text: "Call".tr(),
                            onPressed: () {

                              makePhoneCall(phoneNumbers[index]);

                            }),
                        title: Text(phoneNumbers[index]),
                        onTap: () {},
                      ),
                    )),
              ],
            ),
          ),
        );
      });
}

void showWhatsappSheet(
    {required List<String> phoneNumbers, required BuildContext context}) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration:  BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  phoneNumbers.length,
                  (index) => ListTile(
                    trailing: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff25d366),
                            textStyle: TextStyle(
                                fontSize:
                                    (width + height) * (18 / widthPlusHeight),
                              color: Colors.white
                            )),
                        onPressed: () {
                          launchWhatsapp(phoneNumbers[index]);
                        },
                        label: Text("Whatsapp".tr(), style: const TextStyle(color: Colors.white),),
                        icon: Image.asset(
                          "assets/icons/whatsapp1.png",
                          width: 20,
                          height: 20,
                          color: Colors.white,
                        )),
                    title: Text(phoneNumbers[index]),
                    onTap: () {},
                  ),
                )),
          ),
        );
      });
}

Widget settingListTile(
    {required String title,
    required String subtitle,
    required IconData leadingTitle,
    required BuildContext context,
    required Widget screen}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
    child: ListTile(
      title: Text(title).tr(),
      leading: Icon(leadingTitle),
      subtitle: Text(subtitle),
      trailing: Icon(context.locale.toString() == "en"
          ? Icons.keyboard_arrow_right
          : Icons.keyboard_arrow_left),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => screen,
            ));
      },
    ),
  );
}

Widget circleAvatarPic({required String picture}) {
  return Container(
    height: 60,
    width: 60,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.5),
      borderRadius: BorderRadius.circular(10),
    ),
    child: CachedNetworkImage(
      imageUrl: picture,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    ),
  );
}

Widget squareAvatarPic(
    {required String picture,
      double? height,
      double? width,
      double? borderRadius}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius ?? 20.0), //or 15.0

    child: Container(
      height: height ?? 60,
      width: width ?? 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: CachedNetworkImage(
        imageUrl: picture,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    ),
  );
}

Widget errorWidget(width, height, BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(68, 255, 255, 255),
        leadingWidth: (width + height) * (90 / widthPlusHeight),
        title: Text(
          "Post Ad",
          style: TextStyle(
              fontSize: (width + height) * (26 / widthPlusHeight),
              color: Colors.black),
        ).tr(),
        centerTitle: true,
        leading: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            IconButton(
              icon: arrowIcon,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text("There was an error"),
      ));
}

// Custom list tile definition
class CustomListTile extends StatelessWidget {
  final Widget? leading; // Optional leading widget
  final Text? title; // Required title text
  final Widget? subTitle; // Optional subtitle text
  final Function? onTap; // Optional tap event handler
  final Function? onLongPress; // Optional long press event handler
  final Function? onDoubleTap; // Optional double tap event handler
  final Widget? trailing; // Optional trailing widget
  final Color? tileColor; // Optional tile background color
  final double? height; // Required height for the custom list tile

  // Constructor for the custom list tile
  const CustomListTile({
    super.key,
    this.leading,
    this.title,
    this.subTitle,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.trailing,
    this.tileColor,
    required this.height, // Make height required for clarity
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          color: Theme.of(context).shadowColor), // Material design container for the list tile
      child: InkWell(
        // Tappable area with event handlers
        onTap: () => onTap, // Tap event handler
        onDoubleTap: () => onDoubleTap, // Double tap event handler
        onLongPress: () => onLongPress, // Long press event handler
        child: SizedBox(
          // Constrain the size of the list tile
          height: height, // Set custom height from constructor
          child: Row(
            // Row layout for list item content
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                // Padding for the leading widget
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: leading, // Display leading widget
              ),
              Expanded(
                // Expanded section for title and subtitle
                child: Column(
                  // Column layout for title and subtitle
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text left
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: title ?? const SizedBox(),
                    ), // Display title or empty space
                    const SizedBox(
                        height: 10), // Spacing between title and subtitle
                    subTitle ??
                        const SizedBox(), // Display subtitle or empty space
                  ],
                ),
              ),
              Container(
                // Padding for the trailing widget
                padding: const EdgeInsets.only(top: 8.0),
                child: trailing, // Display trailing widget
              )
            ],
          ),
        ),
      ),
    );
  }
}
Widget pictureIcon(
    {required String assetName, Color? color}) {
  return Column(
    children: [
      Container(
          height: 50,
          width: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white30,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Image.asset(
            assetName,
            width: 50,
            height: 45,
            color: color,
          )),
    ],
  );
}
snackBar({required String message, required BuildContext context}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ),
  );
}

BoxDecoration lightBoxDecoration({required String languageCode}) {
  return BoxDecoration(
    gradient: LinearGradient(colors: [  Color(0xff0061ff),  Color(0xff1b6bff)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    borderRadius: BorderRadius.circular(50),
    color: Colors.grey[200],
    boxShadow: const [
      BoxShadow(
          offset: Offset(0, 10),
          blurRadius: 50,
          color: Color(0xffEEEEEE)
      ),
    ],
  );
}

Container authHeader(BuildContext context, {required String title, required String image}) {
  return Container(
    height: 300,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(context.locale.languageCode == "en" ?90: 0),
          bottomLeft: Radius.circular(context.locale.languageCode == "en" ?0: 90)
      ),
      gradient: LinearGradient(colors: [blueGradient[0], Colors.blue.shade700],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    child: Stack(

      children: [
        ModalRoute.of(context)!.isFirst? Container() :Positioned(
          right: context.locale.toString() == "en"
              ? null
              : 30 / 2,
          left: context.locale.toString() == "en"
              ? 30 / 2
              : null,
          top: 60,
          child: InkWell(
            child: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,

            ),
            onTap: () async {
              //
              Navigator.pop(context);

            },
          ),
        ),
        Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Image.asset(
                    "assets/images/$image",
                    height: 130,
                    width: 130,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      right: context.locale.languageCode == "en" ? 0: 20,
                      top: 20,
                      left: context.locale.languageCode == "en" ? 20 : 0
                  ),
                  alignment: context.locale.languageCode == "en" ? Alignment.bottomLeft :Alignment.bottomRight,
                  child: Text(
                    title.tr(),
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ),
                )
              ],
            )
        ),
      ],
    ),
  );
}
Widget customBottomBar({required BuildContext context, required int bottomNavIndex, required Function(int) onItemSelected}) {
  return CustomAnimatedBottomBar(
    containerHeight: 70,
    backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
    selectedIndex: bottomNavIndex,
    showElevation: true,
    itemCornerRadius: 12,
    curve: Curves.ease,

    onItemSelected: onItemSelected,
    items: <BottomNavyBarItem>[
      BottomNavyBarItem(
        icon: bottomNavIndex != 0 ? const Icon(Icons.home_outlined): homeIcon,
        title: const Text('home').tr(),
        activeColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
        inactiveColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor!,
        textAlign: TextAlign.center,
      ),

      BottomNavyBarItem(
        icon: bottomNavIndex != 1 ? const Icon(Icons.dashboard_customize_outlined): Icon(Icons.dashboard_customize_rounded),
        title: const Text('Custom').tr(),
        activeColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
        inactiveColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor!,
        textAlign: TextAlign.center,
      ),
      BottomNavyBarItem(
        icon: bottomNavIndex != 2 ? const Icon(Icons.compare_outlined): Icon(Icons.compare_rounded),
        title: const Text('Compare').tr(),
        activeColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
        inactiveColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor!,
        textAlign: TextAlign.center,
      ),
      BottomNavyBarItem(
        icon: bottomNavIndex != 1 ? const Icon(Icons.settings_outlined): settingIcon,
        title: const Text('setting').tr(),
        activeColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
        inactiveColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor!,
        textAlign: TextAlign.center,
      ),
    ],
  );
}
import 'package:b6arya/constants/variables.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/texts.dart';

class AppText {

  Padding richText({ required String text,TextStyle? textStyle, TextStyle? starTextStyle, bool isOptional = false }) {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0 , 0),
      child: RichText(
          text:  TextSpan(children: [
            TextSpan(
                text:  text,
                style: textStyle?? theme.textTheme.titleMedium,
            ),
           isOptional ? const TextSpan() : TextSpan(
                text: '*',
                style: starTextStyle ?? theme.textTheme.titleMedium
            ),
          ]
          )
      ),
    );
  }
 Container dropDownMenu({required double width, required String title,
   required List<String> itemsList,  String? value, required ValueChanged onChanged, required BuildContext context, bool? translated,
   TextEditingController? searchController, required ValueChanged onOpened, required bool isDDOpen
 }) {
    return                   Container(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,

          hint: Text(title.tr(), style: bodyText(context)[1],),
          items: itemsList
              .map((item) => DropdownMenuItem<String>(
            value: item,
            child: translated != null ? Text(
              item,
              style: const TextStyle(
                fontSize: 14,
                //fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ) : Text(
              item,
              style: const TextStyle(
                fontSize: 14,
                //fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ).tr(),
          ))
              .toList(),
          value: value,

          onChanged: onChanged,
          iconStyleData:   IconStyleData(
            icon: const Icon(Icons.arrow_downward_rounded),
            iconSize: 17,
            iconEnabledColor: Theme.of(context).iconTheme.color


          ),
          menuItemStyleData: const MenuItemStyleData(
              height: 40,
          ),

          buttonStyleData: ButtonStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
               color: Theme.of(context).cardColor,
                  border: !isDDOpen ? null: Border.all(color: Theme.of(context).iconTheme.color!, width: 2)

              ),
              padding: const EdgeInsets.all(6)
          ),

          //buttonElevation: 2,
          dropdownStyleData:  DropdownStyleData(


            maxHeight: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).secondaryHeaderColor,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  spreadRadius: 1.5,
                  blurRadius: 6,
                  offset: const Offset(1,
                      4), // changes position of shadow
                ),
              ],
            ),

            scrollbarTheme: const ScrollbarThemeData(
                radius: Radius.circular(8),
                thumbVisibility: WidgetStatePropertyAll(true)
            ),
            elevation: 10,
          ),

          dropdownSearchData: DropdownSearchData(
            searchController: searchController,
            searchInnerWidgetHeight: 70,
            searchInnerWidget: Container(
              height: 70,
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: searchController,
                decoration:  InputDecoration(
                  hintText: 'Search...'.tr(),
                  prefixIcon: const Icon(Icons.search),
                ),


              ),
            ),
            searchMatchFn: (item, searchValue) {

              return  item.value.toString().toLowerCase().contains(searchValue.toLowerCase()) || item.value.toString().tr().toLowerCase().contains(searchValue.toLowerCase());
            },
          ),

          onMenuStateChange: onOpened,
          //offset: const Offset(-10, 0),
        ),
      ),
    );

 }
}
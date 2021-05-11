import 'package:flutter/material.dart';
import 'package:ecom/bloc/bloc_checkout.dart';
import 'package:ecom/bloc/bloc_home.dart';
import 'package:ecom/bloc/bloc_order.dart';
import 'package:ecom/emuns/checkOutType.dart';
import 'package:ecom/emuns/ratingType.dart';
import 'package:ecom/emuns/orderType.dart';
import 'package:ecom/main.dart';
import 'package:ecom/models/responce/getAllOrderResponceModel.dart';
import 'package:ecom/screens/homeWidget.dart';
import 'package:ecom/utils/appTheme.dart';
import 'package:ecom/screens/splashWidget.dart';

class CheckOutButton {

  Widget getCheckOutTab(CheckOutType checkOutType) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: []..addAll(CheckOutType.values.map((type) {
        return getButtonUI(type,type==checkOutType);
      }).toList()),
    );

  }

  Widget getButtonUI(CheckOutType checkOutType, bool isSelected) {
    return Container(
        margin: EdgeInsets.all(5),
        width: 90,
        child:  Padding(
          padding: const EdgeInsets.all(2),
          child: Center(
            child: Text(
              checkOutType.toString().split(".")[1],
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 15,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                fontFamily: "Normal",
                color: isSelected?themeTextHighLightColor:themeTextColor,
              ),

            ),
          ),
        ),
    );
  }
}
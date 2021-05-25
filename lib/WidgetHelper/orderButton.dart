import 'package:ecom/utils/languages_local.dart';
import 'package:flutter/material.dart';
import 'package:ecom/bloc/bloc_home.dart';
import 'package:ecom/bloc/bloc_order.dart';
import 'package:ecom/emuns/ratingType.dart';
import 'package:ecom/emuns/orderType.dart';
import 'package:ecom/main.dart';
import 'package:ecom/models/responce/getAllOrderResponceModel.dart';
import 'package:ecom/screens/homeWidget.dart';
import 'package:ecom/utils/appTheme.dart';
import 'package:ecom/screens/splashWidget.dart';

class OrderButton {
  OrderStatus orderStatus;
  Widget getOrderTypes(OrderStatus selectedOrderStatus) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: List<Widget>.generate(
        OrderStatus.values.length,
        (int index) {
          final int count = OrderStatus.values.length;
          return getButtonUI(OrderStatus.values[index],
              OrderStatus.values[index] == selectedOrderStatus);
        },
      ),
    );
  }

  Widget getButtonUI(OrderStatus orderStatus, bool isSelected) {
    return Container(
        margin: EdgeInsets.all(5),
        width: 90,
        child: InkWell(
          onTap: () {
            List<GetOrderResponce> _temporder = new List();
            if (orderStatus == OrderStatus.any)
              _temporder = orders;
            else
              orders.forEach((order) {
                if (order.status == orderStatus.toString().split(".")[1])
                  _temporder.add(order);
              });

            orderBloc.refreshOrders(_temporder);
            orderBloc.selectOrderType(orderStatus);
          },
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Center(
              child: Text(
                LocalLanguageString()
                    .wordValue(orderStatus.toString().split(".")[1]),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  fontFamily: "Normal",
                  color: isSelected ? themeTextHighLightColor : themeTextColor,
                ),
              ),
            ),
          ),
        ));
  }
}

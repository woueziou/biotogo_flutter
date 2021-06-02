import 'package:ecom/models/request/createOrderModel.dart';
import 'package:flutter/material.dart';
import 'package:ecom/bloc/bloc_checkout.dart';
import 'package:ecom/emuns/checkOutType.dart';
import 'package:ecom/screens/splashWidget.dart';
import 'package:ecom/utils/appTheme.dart';
import 'package:ecom/utils/languages_local.dart';
import 'package:intl/intl.dart';

class CheckOutShippingScreen extends StatefulWidget {
  bool isFreeShipment;
  CheckOutShippingScreen(this.isFreeShipment);
  @override
  _CheckOutShippingState createState() => new _CheckOutShippingState();
}

int shippingCost = 0;
var shippingLines = ShippingLines(
    methodId: '1',
    methodTitle:
        '"Livraison gratuite au siège Bio TOGO à Adidogomé, Blv 30 Août à coté de la Poste +228 92 36 11 11',
    total: '0');

class _CheckOutShippingState extends State<CheckOutShippingScreen> {
  final String REQUIRED = "__ *";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _groupValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (shippingZoneMethod.length > 0)
      shippingCost =
          int.parse(widget.isFreeShipment ? 0 : shippingZoneMethod[0].cost);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: themeBG,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    Map map = ModalRoute.of(context).settings.arguments as Map;

    return SingleChildScrollView(
      padding:
          EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 10.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: []
            ..addAll(shippingZoneMethod != null && shippingZoneMethod.length > 0
                ? shippingZoneMethod.map((method) {
                    return _myRadioButton(
                      title: method.title +
                          " (" +
                          (widget.isFreeShipment
                              ? LocalLanguageString().free
                              : method.cost) +
                          ")",
                      value: shippingZoneMethod.indexOf(method),
                      onChanged: (newValue) => setState(() {
                        shippingLines = new ShippingLines(
                            methodId: method.id.toString(),
                            methodTitle: method.title,
                            total: method.cost);
                        _groupValue = newValue;
                        shippingCost =
                            widget.isFreeShipment ? 0 : int.parse(method.cost);
                      }),
                    );
                  }).toList()
                : [
                    Center(
                      child: Text(
                        LocalLanguageString().shippingnotavailable,
                        style: TextStyle(
                          fontFamily: "Normal",
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: themeTextColor,
                        ),
                      ),
                    )
                  ])
            ..add(SaveButton())),
    );
  }

  Widget _myRadioButton({String title, int value, Function onChanged}) {
    return RadioListTile(
      value: value,
      groupValue: _groupValue,
      onChanged: onChanged,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "Normal",
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: themeTextColor,
        ),
      ),
    );
  }

  SaveButton() {
    return GestureDetector(
        onTap: () {
          checkOutBloc.selectCheckOut(CheckOutType.PAYMENT);
        },
        child: Container(
          padding: EdgeInsets.only(top: 30),
          width: double.infinity,
          child: Text(
            LocalLanguageString().gotopayment,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Normal",
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: themeTextColor,
            ),
          ),
        ));
  }
}

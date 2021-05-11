import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecom/models/request/customerBillingModel.dart';
import 'package:ecom/models/request/customerCreateModel.dart';
import 'package:ecom/utils/appTheme.dart';
import 'package:ecom/utils/languages_local.dart';
import 'package:ecom/utils/prefrences.dart';

class ProfileInfo extends StatefulWidget {
  final Function onTap;
  const ProfileInfo({Key key, this.onTap}) : super(key: key);

  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {

  final String REQUIRED="__ *";

  TextEditingController firstnameController = new TextEditingController();
  TextEditingController lastController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController companyController = new TextEditingController();
  TextEditingController primaryAddressController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();
  TextEditingController postalcodeController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  @override
  void initState() { 
    super.initState();

    Billing billing=getCustomerDetailsPref().billing;
    firstnameController.text=billing.first_name;
    lastController.text=billing.last_name;
    emailController.text=billing.email;
    companyController.text=billing.company;
    primaryAddressController.text=billing.address_1;
    cityController.text=billing.city;
    // countrySelected=billing.country;
    stateController.text=billing.state;
    postalcodeController.text=billing.postcode;
    phoneController.text=billing.phone;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: LocalLanguageString().firstname,
              labelStyle: TextStyle(
                color: themeTextColor,
              ),
            ),
            controller: firstnameController,
            style: TextStyle(
                fontFamily: "Normal",
                color: themeTextColor,
                fontSize: 17,
                fontWeight: FontWeight.w700
            ),
          ),

          TextField(
            decoration: InputDecoration(
              labelText: LocalLanguageString().lastname,
              labelStyle: TextStyle(
                color: themeTextColor,
              ),
            ), controller: lastController,
            style: TextStyle(
                fontFamily: "Normal",
                color: themeTextColor,
                fontSize: 17,
                fontWeight: FontWeight.w700
            ),
          ),

          TextField(decoration: InputDecoration(
            labelText: LocalLanguageString().email,
            labelStyle: TextStyle(
              color: themeTextColor,
            ),
          ), controller: emailController,
            style: TextStyle(
                fontFamily: "Normal",
                color: themeTextColor,
                fontSize: 17,
                fontWeight: FontWeight.w700
            ),
          ),

          TextField(decoration: InputDecoration(
            labelText: LocalLanguageString().company,
            labelStyle: TextStyle(
              color: themeTextColor,
            ),
          ), controller: companyController,
            style: TextStyle(
                fontFamily: "Normal",
                color: themeTextColor,
                fontSize: 17,
                fontWeight: FontWeight.w700
            ),
          ),

          TextField(decoration: InputDecoration(
            labelText: LocalLanguageString().address,
            labelStyle: TextStyle(
              color: themeTextColor,
            ),
          ), controller: primaryAddressController,
            style: TextStyle(
                fontFamily: "Normal",
                color: themeTextColor,
                fontSize: 17,
                fontWeight: FontWeight.w700
            ),
          ),

          TextField(decoration: InputDecoration(
            labelText: LocalLanguageString().city,
            labelStyle: TextStyle(
              color: themeTextColor,
            ),
          ), controller: cityController,
            style: TextStyle(
                fontFamily: "Normal",
                color: themeTextColor,
                fontSize: 17,
                fontWeight: FontWeight.w700
            ),
          ),

          TextField(decoration: InputDecoration(
            labelText: LocalLanguageString().state,
            labelStyle: TextStyle(
              color: themeTextColor,
            ),
          ), controller: stateController,
            style: TextStyle(
                fontFamily: "Normal",
                color: themeTextColor,
                fontSize: 17,
                fontWeight: FontWeight.w700
            ),
          ),

          TextField(decoration: InputDecoration(
            labelText: LocalLanguageString().postalcode,
            labelStyle: TextStyle(
              color: themeTextColor,
            ),
          ), controller: postalcodeController,
            style: TextStyle(
                fontFamily: "Normal",
                color: themeTextColor,
                fontSize: 17,
                fontWeight: FontWeight.w700
            ),
          ),

          // GestureDetector(
          //     onTap: () {
          //       _openCountryPicker();
          //     },
          //     child: Container(
          //       margin: EdgeInsets.only(top: 10),
          //       child: Card(
          //           color: themeBG,
          //           child: Container(
          //             padding: EdgeInsets.all(8),
          //             color: themeBG,
          //             margin: EdgeInsets.only(top: 10),
          //             child: Text(
          //               countrySelected == ""
          //                   ? LocalLanguageString().country
          //                   : countrySelected,
          //               textAlign: TextAlign.center,
          //               style: TextStyle(
          //                   fontFamily: "Normal",
          //                   color: themeTextColor,
          //                   fontSize: 17,
          //                   fontWeight: FontWeight.w700
          //               ),
          //             ),
          //           )
          //       ),
          //     )
          // ),

          TextField(decoration: InputDecoration(
            labelText: LocalLanguageString().phone,
            labelStyle: TextStyle(
              color: themeTextColor,
            ),
          ), controller: phoneController,
            style: TextStyle(
                fontFamily: "Normal",
                color: themeTextColor,
                fontSize: 17,
                fontWeight: FontWeight.w700
            ),
          ),
          Divider(),

          SaveButton(),

        ]);
  }

  SaveButton( ) {
    return GestureDetector(
      onTap: () {
        CreateCustomer customer = getCustomerDetailsPref();
        customer.shipping.first_name = customer.billing.first_name = customer.first_name = firstnameController.text;
        customer.shipping.last_name = customer.billing.last_name = customer.last_name = lastController.text;
        customer.shipping.company = customer.billing.company = companyController.text;
        customer.shipping.address_2 = customer.shipping.address_1 = customer.billing.address_1 = primaryAddressController.text;
        customer.shipping.city = customer.billing.city = cityController.text;
        customer.shipping.state = customer.billing.state = stateController.text;
        customer.shipping.postcode = customer.billing.postcode = postalcodeController.text;
        customer.shipping.country = customer.billing.country = "";
        customer.billing.email = customer.email = emailController.text;
        customer.billing.phone = phoneController.text;
        setCustomerDetailsPref(customer);
        widget.onTap();
      },
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(15),
        child: Text(
          LocalLanguageString().save,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Normal",
              color: themeTextColor,
              fontSize: 22,
              fontWeight: FontWeight.w700
          ),
        ),
      )
    );
  }
  // String countrySelected;
  // void _openCountryPicker() => showCupertinoModalPopup<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return CountryPickerCupertino(
  //         pickerSheetHeight: 300.0,
  //         onValuePicked: (Country country) => setState(() => countrySelected = country.name),
  //       );
  //     });
}
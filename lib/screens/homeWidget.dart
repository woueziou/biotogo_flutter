import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecom/WidgetHelper/CustomIcons.dart';
import 'package:ecom/WidgetHelper/homeCategoryHeader.dart';
import 'package:ecom/WidgetHelper/filters.dart';
import 'package:ecom/bloc/bloc_home.dart';
import 'package:ecom/list_views/home_product_grid_view.dart';
import 'package:ecom/list_views/home_product_list_view.dart';
import 'package:ecom/main.dart';
import 'package:ecom/models/responce/getAllProductsResponceModel.dart';
import 'package:ecom/screens/homefragments/cartWidget.dart';
import 'package:ecom/screens/homefragments/categoryWidget.dart';
import 'package:ecom/screens/homefragments/productsWidget.dart';
import 'package:ecom/screens/homefragments/settingwidget.dart';
import 'package:ecom/screens/splashWidget.dart';
import 'package:ecom/screens/userProfileWidget.dart';
import 'package:ecom/utils/appTheme.dart';
import 'package:ecom/utils/consts.dart';
import 'package:ecom/utils/languages_local.dart';
import 'package:ecom/utils/prefrences.dart';
import 'package:package_info/package_info.dart';

class HomeScreen extends StatefulWidget  {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen>   {

  List cartList;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool enabled = false; // tracks if drawer should be opened or not
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prefs.setBool(ISFIRSTOPEN, false);
//    FirebaseFirestore.instance.collection('versions').document("updatedVersion").get().then((value) {
//      bool updateNow=value.data()["updateNow"];
//      String versionandroid=value.data()["versionandroid"];
//      String versionios=value.data()["versionios"];
//      if(updateNow)
//      {
//        PackageInfo.fromPlatform().then((packageInfo){
//          String versionName = packageInfo.version;
//          String versionCode = packageInfo.buildNumber;
//
//          if (
//          ((Platform.isIOS &&versionName!=versionios) || (Platform.isAndroid &&versionName!=versionandroid))
//          ){
//            Navigator.pushNamed(context, '/update' );
//          }
//        });
//      }
//    });

  }
  @override
  Widget build(BuildContext context) {


    cartList=getCartProductsPref();
    return DefaultTabController(  // Added
      length: TabBarCount,  // Added
      initialIndex: 0, //Added
      child:  Scaffold(
        key: _scaffoldKey,
        // assign key to Scaffold
        drawer: drawerWidget(),
        backgroundColor: themeBG,
        bottomNavigationBar: navTabItem(),
        body: SafeArea(
          child:body(),
        )
      )
    );
  }


  Widget body() {
    return Container(
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                color: themeAppBar,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    drawerButtonIcon(() {
                      _scaffoldKey.currentState.openDrawer();
                    }, Icons.menu),
                    Text(
                      APPNAME+" Store",
                      style: TextStyle(
                        color: themeAppBarItems,
                          fontSize: 20.0,
                          fontFamily: "Header",
                          fontWeight: FontWeight.bold,
                      ),
                    ), Container(),

                  ],
                ),
              )
          ),
          Expanded(
            flex: 10,
            child: TabBarView(
              children: [
                ProductScreen(),
                CategoryScreen(),
                CartScreen(false),
                SettingScreen(() {
                  setState(() {});
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  drawerWidget() {

    return Drawer(
        child: StreamBuilder(
          stream: homeBloc.getProductCategoryStreamController.stream,
          initialData: categories,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.data != null ? Container(
                color: themeBG,
                child: ListView(
                  children: [

                    Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              child:  Text(
                                APPNAME+" Store",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Header",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: themeTextColor,
                                ),
                              ),
                            ),
                            Image.asset(
                              'assets/logo.png',
                              width: 50,
                              height: 50,
                            ),
                          ],
                        )
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, "/home");
                        },
                        child: Container(
                          color: themeBG,
                          padding: EdgeInsets.all(20),
                          child: Text(
                            LocalLanguageString().home,
                            style: TextStyle(
                              fontFamily: "Header",
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: themeTextColor,
                            ),
                          ),
                        ),
                    ),

                    Container(
                        child:Container(
                          color: themeBG,
                          padding: EdgeInsets.only(top: 20.0,
                              left: 6.0,
                              right: 6.0,
                              bottom: 6.0),
                          child: ExpansionTile(
                            initiallyExpanded: true,
                            title: Text(
                              LocalLanguageString().bycategory,
                              style: TextStyle(
                                fontFamily: "Header",
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: themeTextColor,
                              ),
                            ),
                            children: []
                              ..add(
                                  Divider(height: 1,)
                              )
                              ..addAll(
                                List.generate(categories.length, (index) {
                                  return getListItem(
                                      categories[index].image != null
                                          ? categories[index].image.src
                                          : "",
                                      categories[index].name,
                                      "",
                                      categories[index].description,
                                      Icons.arrow_forward_ios,
                                          () {
                                            List<GetAllProducts> _subProduct=List();
                                            products.forEach((element) {
                                              if(element.categories.contains(categories[index].name.toString()))
                                              {
                                                _subProduct.add(element);
                                              }
                                            });
                                            Navigator.pushNamed(context, '/subproduct', arguments: {'_subProducts': _subProduct, '_title': categories[index].name});

                                      }
                                  );
                                }
                                ),
                              ),
                          ),
                        )
                    )
                  ],
                )
            ) : Container(color: themeBG,);
          },
        )
    );
  }
  Widget getListItem(String categoryUrl,String title,String extendedTitle,String description,IconData trailing,Function callback){

    return ListTile(
      onTap: callback,
      title: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontFamily: "Normal",
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: themeTextColor,
            ),
          ),
          SizedBox(
            width: 16.0,
          ),
          Text(
            extendedTitle,
            style: TextStyle(
              fontFamily: "Normal",
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: themeTextColor,
            ),
          ),
        ],
      ),
      trailing: Icon(
        trailing,
        size: 12,
      ),
    );
  }

}

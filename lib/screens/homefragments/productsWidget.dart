import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:ecom/WidgetHelper/CustomIcons.dart';
import 'package:ecom/WidgetHelper/homeCategoryHeader.dart';
import 'package:ecom/WidgetHelper/filters.dart';
import 'package:ecom/WidgetHelper/homeTagHeader.dart';
import 'package:ecom/bloc/bloc_home.dart';
import 'package:ecom/list_views/home_product_grid_view.dart';
import 'package:ecom/list_views/home_product_list_view.dart';
import 'package:ecom/main.dart';
import 'package:ecom/models/responce/getAllProductsResponceModel.dart';
import 'package:ecom/screens/homefragments/cartWidget.dart';
import 'package:ecom/screens/homefragments/categoryWidget.dart';
import 'package:ecom/screens/splashWidget.dart';
import 'package:ecom/screens/userProfileWidget.dart';
import 'package:ecom/utils/appTheme.dart';
import 'package:ecom/utils/consts.dart';
import 'package:ecom/utils/languages_local.dart';
import 'package:ecom/utils/prefrences.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:share/share.dart';

class ProductScreen extends StatefulWidget  {

  @override
  _ProductScreenState createState() => new _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> with TickerProviderStateMixin , CategoryButton{
  int itemsToShow=0;
  final int PAGINATIONGAP=6;
  AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    itemsToShow = (itemsToShow + PAGINATIONGAP) > products.length ? products.length : (itemsToShow + PAGINATIONGAP);
    super.initState();
  }

  bool _onScrollNotification(ScrollNotification notification) {
    print("");
    if (notification is ScrollEndNotification) {
      final before = notification.metrics.extentBefore;
      final max = notification.metrics.maxScrollExtent;

      if (before == max) {
        setState(() {
          itemsToShow = (itemsToShow + PAGINATIONGAP) > products.length ? products.length : (itemsToShow + PAGINATIONGAP);
        });
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: themeBG,
      body: Container(
        child: NotificationListener(
            onNotification: _onScrollNotification,
            child: ListView(
              children: [
                getSearchBarUI(),
                getCategoryUI(context),
                TagSlidingCard().getTagsHeader(),
                Divider(),
                getPopularProductUI(),
              ],
            )
        ) ,
      )
    );

  }


  Widget getPopularProductUI() {
    return Container(
      child:  Column(
        children: [
          Container(
            padding:  EdgeInsets.all( 8.0,),
            margin:  EdgeInsets.only(top: 13.0,),
            alignment: Alignment.centerLeft,
            child: Text(
              LocalLanguageString().popularproducts,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                letterSpacing: 0.27,
                fontFamily: "Normal",
                color: themeTextColor,
              ),
            ),
          ),
          Container(
              child: ( prefs.getBool(ISGRID) ?? false)?
              StreamBuilder(
                stream: homeBloc.getProductStreamController.stream,
                initialData: products,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.data!=null?HomeProductListView(
                    products: snapshot.data.sublist(0,snapshot.data.length>=itemsToShow?itemsToShow:snapshot.data.length),

                    callBack: (String productId) {
                      Navigator.pushNamed(context, '/homeproductdetail', arguments: {'_productId': productId});
                    },
                  ):Container();
                },
              ):
              StreamBuilder(
                stream: homeBloc.getProductStreamController.stream,
                initialData: products,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.data!=null?Container(
                    child: HomeProductGridView(
                      products: snapshot.data.sublist(0,snapshot.data.length>=itemsToShow?itemsToShow:snapshot.data.length),

                      callBack: (String productId) {
                        Navigator.pushNamed(context, '/homeproductdetail', arguments: {'_productId': productId});
                      },
                    ),
                  ):Container();
                },
              )
          )
        ],
      ),
    );

  }


  Widget getSearchBarUI() {

    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 10),
              child: Row(
                children: <Widget>[
                  SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(
                        Icons.search,
                        color: themeTextColor,
                      )
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontFamily: "Normal",
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: themeTextColor,
                        ),
                        decoration: InputDecoration(
                          labelText: LocalLanguageString().searchforproducts,
                          border: InputBorder.none,
                          helperStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Normal",
                            color: themeTextColor,
                          ),
                          labelStyle: TextStyle(
                            fontSize: 12,
                            color: themeTextColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Normal",
                          ),
                        ),
                        onChanged: (value) {
                          List<GetAllProducts> _products=new List();

                          products.forEach((data){
                            if (data.title.toLowerCase().contains(value.toLowerCase())){
                              _products.add(data);
                            }
                          });
                          homeBloc.refreshProducts(_products);

                        },
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child:  IconButton(
                icon: Icon(
                  Icons.list,
                  color: themeTextColor,
                ),
                onPressed: () {
                  prefs.setBool(ISGRID,!( prefs.getBool(ISGRID) ?? false)).then((isDone){
                    setState(() {});
                  });
                },
              ),
            ),
          ),Expanded(
            flex: 1,
            child:Center(
              child:  IconButton(
                icon: Icon(
                  Icons.filter_list,
                  color: themeTextColor,
                ),
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: themeBG,
                    context: context,
                    builder: (sheetContext) => BottomSheet(
                      builder: (_) => Filters( ),
                      onClosing: (){},
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

}

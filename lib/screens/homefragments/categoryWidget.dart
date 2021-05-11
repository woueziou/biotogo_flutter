import 'dart:ui';
//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ecom/WidgetHelper/CustomIcons.dart';
import 'package:ecom/bloc/bloc_home.dart';
import 'package:ecom/models/responce/getAllCategoriesResponceModel.dart';
import 'package:ecom/models/responce/getAllProductsResponceModel.dart';
import 'package:ecom/screens/splashWidget.dart';
import 'package:ecom/utils/appTheme.dart';
import 'package:ecom/utils/languages_local.dart';
import 'package:progress_indicators/progress_indicators.dart';


class CategoryScreen extends StatefulWidget {

  @override
  _CategoryScreenState createState() => new _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>  {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: themeBG,
      body: Container(
        padding: EdgeInsets.all(10),
          child: ListView(
            children: categories.map((cat) => ItemView(data: cat)).toList()
//            Container(height: 90,width: 90,color: Colors.lightBlueAccent,)
          )
      ),
    );

  }

}

class ItemView extends StatelessWidget {
  const ItemView({Key key, this.data }) : super(key: key);

  final GetAllProductCategories data;

  @override
  Widget build(BuildContext context) {
    double ITEMHEIGHT=120;
    List<GetAllProducts> _subProduct=List();
    products.forEach((element) {
      if(element.categories.contains(data.name.toString()))
      {
        _subProduct.add(element);
      }
    });
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/subproduct', arguments: {'_subProducts': _subProduct, '_title': data.name});
      },
      child: Container(

        margin: EdgeInsets.all(8),
        child: Stack(
          children: <Widget>[
            data.image!=null?
            Container(
              width: double.infinity,
                height: ITEMHEIGHT,
                child: Image.network(
                  data.image.src,
                  fit: BoxFit.cover,
                )
//                CachedNetworkImage(
//                  imageUrl: data.image.src,
//                  imageBuilder: (context, imageProvider) => Container(
//                    decoration: BoxDecoration(
//                      borderRadius: BorderRadius.all(
//                          Radius.circular(8.0) //                 <--- border radius here
//                      ),
//                      image: DecorationImage(
//                        image: imageProvider,
//                        fit: BoxFit.cover,
//                      ),
//                    ),
//                  ),
//                  placeholder: (context, url) => Center(child: JumpingDotsProgressIndicator(fontSize: 20.0,)),
//                  errorWidget: (context, url, error) => Center(child:Icon(Icons.filter_b_and_w),),
//                )
            )
                :Container(),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                alignment: Alignment.bottomRight,
                height: ITEMHEIGHT,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.0),
                  borderRadius: BorderRadius.all(
                      Radius.circular(8.0) //                 <--- border radius here
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/cornorRB.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Text(
                    data.name  ,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: "Header",
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: themeTextColor
                    ),
                  ),
                )
              ),
            )

          ],
        ),
      )
    );

  }
}

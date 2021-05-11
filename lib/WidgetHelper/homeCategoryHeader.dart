//import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:ecom/bloc/bloc_home.dart';
import 'package:ecom/models/responce/getAllCategoriesResponceModel.dart';
import 'package:ecom/models/responce/getAllProductsResponceModel.dart';
import 'package:ecom/screens/splashWidget.dart';
import 'package:ecom/utils/appTheme.dart';
import 'package:ecom/utils/languages_local.dart';
import 'package:progress_indicators/progress_indicators.dart';

class CategoryButton {

  Widget getCategoryUI(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding:  EdgeInsets.all( 8.0,),
          margin:  EdgeInsets.only(top: 13.0,),
          alignment: Alignment.centerLeft,
          child: Text(
            LocalLanguageString().categories,
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
        StreamBuilder(
          stream: homeBloc.getProductCategoryStreamController.stream,
          initialData: categories,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.data!=null && categories.length>0?
            Container(
                height: 100,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: ListView(
                  children: categories.map((index) => getButtonUI(context,index)).toList(),
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                )
            ): PlayStoreShimmer(
              isPurplishMode: false,
              hasBottomSecondLine: false,
              isDarkMode: false,
            ) ;
          },
        )

      ],
    );


  }

  Widget getButtonUI(BuildContext context,GetAllProductCategories categoryIndex) {
    return Container(
        margin: const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
        child: GestureDetector(
          onTap: (){
            List<GetAllProducts> _subProduct=List();
            products.forEach((element) {
              if(element.categories.contains(categoryIndex.name.toString()))
                {
                  _subProduct.add(element);
                }
            });
            Navigator.pushNamed(context, '/subproduct', arguments: {'_subProducts': _subProduct, '_title': categoryIndex.name});
          },
          child: Flex(
            direction: Axis.vertical,
            children: [
              categoryIndex.image!=null&&categoryIndex.image.src!=null?
              ClipOval(
                  child:
          //        Image.network(
          //           categoryIndex.image.src,
          //           fit: BoxFit.cover,
          //           height: 43,
          //           width: 43,
          //         )
                 CachedNetworkImage(
                   imageUrl: categoryIndex.image.src,
                   imageBuilder: (context, imageProvider) => Container(
                     width: 50,
                     height: 50,
                     decoration: BoxDecoration(
                       image: DecorationImage(
                         image: imageProvider,
                         fit: BoxFit.cover,
                       ),
                     ),
                   ),
                   placeholder: (context, url) => Center(child: JumpingDotsProgressIndicator(fontSize: 20.0,)),
                   errorWidget: (context, url, error) => Center(child:Icon(Icons.filter_b_and_w),),
                 )

              ):Container( color :Colors.transparent,width: 50, height: 50,),
              Expanded(
                flex: 1,
                child: Container(
                  child: Text(
                    categoryIndex.name,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      fontFamily: "Normal",
                      color: themeTextColor,
                    ),
                  ),
                )
              ),
            ],
          ),
        )
    );

  }
}
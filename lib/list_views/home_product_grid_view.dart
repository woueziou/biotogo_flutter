//import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:ecom/WidgetHelper/CustomIcons.dart';
import 'package:ecom/models/request/createOrderModel.dart';
import 'package:ecom/models/responce/getAllProductsResponceModel.dart';
import 'package:ecom/screens/splashWidget.dart';
import 'package:ecom/utils/appTheme.dart';
import 'package:ecom/utils/languages_local.dart';
import 'package:ecom/utils/prefrences.dart';
import 'package:progress_indicators/progress_indicators.dart';

class HomeProductGridView extends StatefulWidget {
  final List<GetAllProducts> products;
  final Function callBack;

  const HomeProductGridView({Key key, this.products, this.callBack}) : super(key: key);
  @override
  _PopularProductGridViewState createState() => _PopularProductGridViewState();
}

class _PopularProductGridViewState extends State<HomeProductGridView> with TickerProviderStateMixin {
  AnimationController animationController;
  List wishList;
  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    wishList=getWhishlistPref();
    return  widget.products.length>0?GridView(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 3.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 0.65,//w/h
      ),
      padding: const EdgeInsets.all(8),
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      children: List<Widget>.generate(
        widget.products.length,
            (int index) {
          return GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, '/homeproductdetail', arguments: {'_productId': widget.products[index].id});
            },
            child: itemView(widget.products[index],),
          );
        },
      ),
    ):ListTileShimmer(
      isPurplishMode: false,
      hasBottomBox: false,
      isDarkMode: false,
    );
  }
  Widget itemView(GetAllProducts data) {
    bool isWishListed=false;

    bool isCartItem=getCartProductsPref().firstWhere((element) => element.product_id==data.id,orElse:() => null)!=null;

    wishList.forEach((element) {
      if(element==data.id)
        isWishListed=true;
    });
    return  Container(
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[

          Expanded(
              flex: 7,
              child: Stack(
                children: [
                  Container(
                      width: double.infinity,
                      child:data.images.length>0?ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          child:
                          // Image.network(
                          //   data.images[0].src,
                          //   fit: BoxFit.cover,
                          // ),
                         CachedNetworkImage(
                           imageUrl: data.images[0].src,
                           imageBuilder: (context, imageProvider) => Container(
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
                      ):Container(height: 80,width: 80,)
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        data.on_sale?Container(
                          alignment: Alignment.topLeft,
                          height: 40,

                          child: Image.asset("assets/sale.png",width: 40,height: 40,)
                        ):Container(width: 40,height: 40,),

                        InkWell(
                          onTap: (){
                            if(isWishListed)
                              removeFromWishList(data.id);
                            else
                              addWhishlistPref(data.id);
                            setState(() {});
                          },
                          child: Image.asset( isWishListed?"assets/fav.png":"assets/unfav.png",width: 30,height: 30,),
                        ),
                      ],
                    )
                  )
                ],
              )
          ),

          Expanded(
            flex: 5,
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 5,),
                      Container(
                        child: Text(
                          data.title==null?"":data.title,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: "Normal",
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            letterSpacing: 0.27,
                            color: themeTextColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        padding: EdgeInsets.all(3),
                        child: getReviews(data),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        padding: EdgeInsets.all(3),
                        child: Text(
                          LocalLanguageString().totalsales+" :"+"  ${data.total_sales}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Normal",
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: themeTextColor,
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(3),
                          child: Row(
                            children: [
                              Text(
                                LocalLanguageString().cost+" :"+" ${data.price} ${currencyCode==null?"":currencyCode}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Normal",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: themeTextColor,
                                ),
                              ),
                              data.on_sale?
                              data.regular_price!=null?Text(" ${data.regular_price} ${currencyCode==null?"":currencyCode}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Normal",
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 10,
                                  color: themeTextColor.withOpacity(0.5),
                                ),
                              ):Container()
                                  :Container()
                            ],
                          )
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: (){
                      if(isCartItem)
                        delCartProductsPref(data.id);
                      else
                        addORupdateCartProductsPref(Line_items(data.id, -1, 1));
                      setState(() {});
                    },
                    child: Image.asset(
                      isCartItem?"assets/removecart.png":"assets/addcart.png",width: 25,height: 25,color:isCartItem?themeTextColor:themeTextHighLightColor,
                    ),

                  ),
                )
              ],
            )
          )
        ],
      ),
    );
  }
}

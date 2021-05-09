import 'package:ecom/models/responce/getAllProductsResponceModel.dart';

class GetAllCoupon{
  int id;
  String code;
  String amount;
  String discount_type;
  String description;
  String date_expires;//
  int usage_count;//
  List<int> product_ids;
  List<int> excluded_product_ids;
  int usage_limit;//
  bool free_shipping;//
  List<int> product_categories;
  List<int> excluded_product_categories;
  bool exclude_sale_items;
  String minimum_amount;
  String maximum_amount;


  GetAllCoupon(this.id, this.code, this.amount, this.discount_type,
      this.description, this.date_expires, this.usage_count,
      this.product_ids, this.excluded_product_ids, this.usage_limit,
      this.free_shipping, this.product_categories,
      this.excluded_product_categories, this.exclude_sale_items,
      this.minimum_amount, this.maximum_amount);

  GetAllCoupon.fromJson(Map<String, dynamic> json){
    id = json['id'];
    code = json['code'];
    amount = json['amount'];
    discount_type = json['discount_type'];
    description = json['description'];
    date_expires = json['date_expires'];
    usage_count = json['usage_count'];
    product_ids =  List<int>.from(json['product_ids'].map((data) => data).toList());
    excluded_product_ids =  List<int>.from(json['excluded_product_ids'].map((data) => data).toList());
    usage_limit = json['usage_limit'];
    free_shipping = json['free_shipping'];
    product_categories =  List<int>.from(json['product_categories'].map((data) => data).toList());
    excluded_product_categories =  List<int>.from(json['excluded_product_categories'].map((data) => data).toList());
    exclude_sale_items = json['exclude_sale_items'];
    minimum_amount = json['minimum_amount'];
    maximum_amount = json['maximum_amount'];
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'code': code,
        'amount': amount,
        'discount_type': discount_type,
        'description': description,
        'date_expires': date_expires,
        'usage_count': usage_count,
        'product_ids': product_ids,
        'excluded_product_ids': excluded_product_ids,
        'excluded_product_ids': excluded_product_ids,
        'usage_limit': usage_limit,
        'free_shipping': free_shipping,
        'product_categories': product_categories,
        'excluded_product_categories': excluded_product_categories,
        'exclude_sale_items': exclude_sale_items,
        'minimum_amount': minimum_amount,
        'maximum_amount': maximum_amount,
      };
}

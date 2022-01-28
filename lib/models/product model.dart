class Product {
  List<ProductModel> products = [];

  Product.fromJson(Map<String, dynamic> json) {
    json['products'].forEach((value) {
      products.add(ProductModel.fromJson(value));
    });
  }
}

class ProductModel {

  int? id;
  String? name;
  String? title;
  String? description;
  int? price;
  int? discount;
  String? discountType;
  int? inStock;
  String? image;
  String? priceFinalText;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    discount = json['discount'];
    discountType = json['discount_type'];
    inStock = json['in_stock'];
    image = json['avatar'];
    priceFinalText = json['price_final_text'];
  }


// {
// "id": 1,
// "name": "Man White Regular Fit Polo Neck Polo T-Shirt",   string
// "title": "Man White T-Shirt",                          string
// "description": null,                                 string/null
// "price": 200,                                        double
// "discount": 0,                                       int
// "discount_type": null,                               string ( FIXED | PERCENTAGE ) /null
// "currency": "EGP",                                   String
// "in_stock": 30,                                      int
// "avatar": "https:\/\/retail.amit-learning.com\/images\/products\/mFXrS9i3y07IT9ic7jgcfq90GtMhf91WdlydLsnt.jpg",
// "price_final": 200,
// "price_final_text": "200 EGP"                        /////// m3ana
// },
}

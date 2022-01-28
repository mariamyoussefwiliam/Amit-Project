import 'package:amit_project/models/product%20model.dart';

class CategoryProductsModel
{
  int? id;
  String? name;
  String? image;
  List<ProductModel> products=[];
  CategoryProductsModel.fromJson(Map<String,dynamic> json)
  {
    id=json['id'];
    name=json['name'];
    image=json['avatar'];

    json['products'].forEach((value) {
      products.add(ProductModel.fromJson(value));
    });
  }
}
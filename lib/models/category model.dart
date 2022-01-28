class CategoryModel
{
List<CategoryDataModel> categories=[];

CategoryModel.fromJson(Map<String, dynamic> json) {
  json['categories'].forEach((value) {
    categories.add(CategoryDataModel.fromJson(value));
  });
}
}

class CategoryDataModel
{
  int? id;
  String? name;
  String? image;
  CategoryDataModel.fromJson(Map<String,dynamic> json)
  {
    id=json['id'];
    name=json['name'];
    image=json['avatar'];
  }
}

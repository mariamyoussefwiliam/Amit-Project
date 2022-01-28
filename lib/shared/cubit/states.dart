import 'package:amit_project/models/category%20model.dart';
import 'package:amit_project/models/categoryProducts.dart';
import 'package:amit_project/models/product%20model.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class ChangeIndexState extends HomeStates {}

class SwapBetweenLoginAndRegisterState extends HomeStates {}

class GetProductDataLoadingState extends HomeStates {}

class GetProductDataSuccessState extends HomeStates {
  final Product productModel;

  GetProductDataSuccessState(this.productModel);
}

class GetProductDataErrorState extends HomeStates {
  final String error;

  GetProductDataErrorState(this.error);
}

class GetProductDetailsDataLoadingState extends HomeStates {}

class GetProductDetailsDataSuccessState extends HomeStates {
  final ProductModel productModel;

  GetProductDetailsDataSuccessState(this.productModel);
}

class GetProductDetailsDataErrorState extends HomeStates {
  final String error;

  GetProductDetailsDataErrorState(this.error);
}

class GetCategoriesDataLoadingState extends HomeStates {}

class GetCategoriesDataSuccessState extends HomeStates {
  final CategoryModel categoryModel;

  GetCategoriesDataSuccessState(this.categoryModel);
}

class GetCategoriesDataErrorState extends HomeStates {
  final String error;

  GetCategoriesDataErrorState(this.error);
}


class GetCategoryProductsDataLoadingState extends HomeStates {}

class GetCategoryProductsDataSuccessState extends HomeStates {
  final CategoryProductsModel categoryProductsModel;

  GetCategoryProductsDataSuccessState(this.categoryProductsModel);
}

class GetCategoryProductsDataErrorState extends HomeStates {
  final String error;

  GetCategoryProductsDataErrorState(this.error);
}

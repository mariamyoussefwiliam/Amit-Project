import 'package:amit_project/models/category%20model.dart';
import 'package:amit_project/models/categoryProducts.dart';
import 'package:amit_project/models/product%20model.dart';
import 'package:amit_project/moduels/cartScreen.dart';
import 'package:amit_project/moduels/categoryScreen.dart';
import 'package:amit_project/moduels/homeScreen.dart';
import 'package:amit_project/moduels/menuScreen.dart';
import 'package:amit_project/shared/cubit/states.dart';
import 'package:amit_project/shared/network/end_points.dart';
import 'package:amit_project/shared/network/remote/dio-helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  var screens = [
    const HomeScreen(),
    CategoryScreen(),
    const CartScreen(),
    MenuScreen(),
  ];
  int index = 0;

  void changeIndex(int currentIndex) {
    index = currentIndex;
    emit(ChangeIndexState());
  }

  int login = 0;

  void swapBetweenLoginAndRegister(current) //login index 0 register index 1
  {
    login = current;
    emit(SwapBetweenLoginAndRegisterState());
  }


  Product? productModel;

  void getProductData( {String? token}) {
    emit(GetProductDataLoadingState());
    DioHelper.getData(url: products).then((value) {
      productModel = Product.fromJson(value.data);

    //  print(productModel!.products[0].id);
      emit(GetProductDataSuccessState(productModel!));
    }).catchError((onError) {
      emit(GetProductDataErrorState(onError.toString()));
      print(onError.toString());
    });
  }




  ProductModel? productDetailsModel;

  void getProductDetailsData( {required int productId,String? token}) {
    emit(GetProductDetailsDataLoadingState());
    DioHelper.getData(url: "$products/$productId").then((value) {
      productDetailsModel = ProductModel.fromJson(value.data['product']);
      print(value.data);
      emit(GetProductDetailsDataSuccessState(productDetailsModel!));
    }).catchError((onError) {
      emit(GetProductDetailsDataErrorState(onError.toString()));
      print(onError.toString());
    });
  }






  CategoryModel? categoryModel;

  void getCategoriesData( {String? token}) {
    emit(GetCategoriesDataLoadingState());
    DioHelper.getData(url: categories).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
     // print(value.data);
      emit(GetCategoriesDataSuccessState(categoryModel!));
    }).catchError((onError) {
      emit(GetCategoriesDataErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  CategoryProductsModel? categoryProductsModel;

  void getCategoryProductsData( {required int categoryId,String? token}) {
    emit(GetCategoryProductsDataLoadingState());
    DioHelper.getData(url: "$categories/$categoryId").then((value) {
      categoryProductsModel = CategoryProductsModel.fromJson(value.data['category']);
      print(value.data);
      emit(GetCategoryProductsDataSuccessState(categoryProductsModel!));
    }).catchError((onError) {
      emit(GetCategoryProductsDataErrorState(onError.toString()));
      print(onError.toString());
    });
  }



}


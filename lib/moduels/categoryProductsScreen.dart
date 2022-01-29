import 'package:amit_project/models/categoryProducts.dart';
import 'package:amit_project/models/product%20model.dart';
import 'package:amit_project/shared/component/component.dart';
import 'package:amit_project/shared/component/constant.dart';
import 'package:amit_project/shared/cubit/cubit.dart';
import 'package:amit_project/shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CategoryProductScreen extends StatelessWidget {
  final int catId;
  const CategoryProductScreen(this.catId,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryProductsModel? categoryProductsModel =HomeCubit.get(context).categoryProductsModel;
    var size = MediaQuery.of(context).size.width;
    var height = 0.0;
    if (size < 600) {
      height = 1.7;
    } else {
      height = 1.25;
    }

    var cubit;
    return BlocProvider(
      create: (context)=>HomeCubit()..getCategoryProductsData(categoryId: catId),
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){
          if(state is GetCategoryProductsDataSuccessState)
          {
            cubit = HomeCubit
                .get(context)
                .categoryProductsModel;
          }
          if(state is AddCartItemState)
          {
            showMessage(msg: "Item Added Successfully",color: Colors.green);
          }
        },
        builder:(context,state)=> Scaffold(
          appBar: AppBar(
            leading:       Padding(
              padding: const EdgeInsets.all(9.0),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: defaultColor)),
                child: Center(
                  child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: defaultColor,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SingleChildScrollView(
              child: ConditionalBuilder(
                 condition:cubit!=null&&state is! GetCategoryProductsDataLoadingState ,
                 builder:(context)=>Column(
                   children: [
                     const    SizedBox(height: 15,),
                     GridView.count(
                       shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                       crossAxisSpacing: 8,
                       mainAxisSpacing: 8,
                       crossAxisCount: 2,
                       childAspectRatio: 1 / height,
                       children: List.generate(
                         cubit.products.length,
                             (index) => productBuilder(context,index,cubit.products[index]),
                       ),
                     ),
                     const    SizedBox(height: 15,),
                   ],
                 ) ,
                 fallback: (context)=>const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

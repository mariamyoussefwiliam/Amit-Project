import 'package:amit_project/models/product%20model.dart';
import 'package:amit_project/shared/component/component.dart';
import 'package:amit_project/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var cubit=HomeCubit.get(context).productModel!.products[0].id;
    // print(cubit);
    Product? productModel =HomeCubit.get(context).productModel;
    var size = MediaQuery.of(context).size.width;
    var height = 0.0;
    if (size < 600) {
      height = 1.7;
    } else {
      height = 1.25;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Column(
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
                productModel!.products.length,
                (index) => productBuilder(context,index,productModel.products[index]),
              ),
            ),
            const    SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}

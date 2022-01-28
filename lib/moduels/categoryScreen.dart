import 'package:amit_project/models/category%20model.dart';
import 'package:amit_project/shared/component/component.dart';
import 'package:amit_project/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {

  CategoryScreen({Key? key}) : super(key: key);
  List images = [
    "https://hips.hearstapps.com/elle/assets/cm/15/02/54ac157e4177d_-_elle-00-fashion-week-inspo-opener-h-elh.jpg",
    "https://victormatara.com/wp-content/uploads/2021/05/List-Of-Best-Online-Electronic-Shops-In-Kenya.jpg",
    "https://image.shutterstock.com/image-photo/baby-accessories-bathing-on-table-260nw-277700819.jpg",
    "https://www.pure360.com/wp-content/uploads/2018/06/shutterstock_518732392.jpg",
    "https://www.cnet.com/a/img/iJxo9AIxiXHqVoqm6nGISKtKwPI=/2020/08/18/b7168aea-9f7e-47bb-9f31-4cb8ad92fbc7/lg-note-20-ultra-5g-iphone-11-se-google-pixel-4a-lg-velvet-6133.jpg",
    "https://image.shutterstock.com/image-photo/supermarket-aisle-empty-red-shopping-260nw-1688252332.jpg",
  ];
  List lable = [
    "Fashion",
    "Electronics",
    "Baby Products",
    "Health & Beauty",
    "Phones",
    "Supermarket",
  ];

  @override
  Widget build(BuildContext context) {
    CategoryModel? categoryModel =HomeCubit.get(context).categoryModel;
    return SingleChildScrollView(
      child: Column(
        children: [
         const  SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GridView.count(
              shrinkWrap: true,
              physics:const  NeverScrollableScrollPhysics(),
              crossAxisCount: 1,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1 /0.45,
              children: List.generate(categoryModel!.categories.length,
                  (index) => categoryBuilder(context, categoryModel.categories[index].image!, categoryModel.categories[index].name!,categoryModel.categories[index].id),),
            ),
          ),
          const  SizedBox(height: 15,),
        ],
      ),
    );
  }
}

import 'package:amit_project/layout/homeLayout.dart';
import 'package:amit_project/models/product%20model.dart';
import 'package:amit_project/shared/component/component.dart';
import 'package:amit_project/shared/component/constant.dart';
import 'package:amit_project/shared/cubit/cubit.dart';
import 'package:amit_project/shared/cubit/states.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int producrtId;

  ProductDetailsScreen(this.producrtId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit;
    return  BlocProvider(
        create:(context)=>HomeCubit()..getProductDetailsData(productId: producrtId),
        child:BlocConsumer<HomeCubit, HomeStates>(
            listener: (context, state) {
              if(state is GetProductDetailsDataSuccessState)
              {
                cubit = HomeCubit
                    .get(context)
                    .productDetailsModel;
              }
              if(state is AddCartItemState)
              {
                showMessage(msg: "Item Added Successfully",color: Colors.green);
              }
              if(state is LoginPleaseState)
              {
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.INFO,
                    width: 340,
                    buttonsBorderRadius:const  BorderRadius.all(
                        Radius.circular(2)),
                    headerAnimationLoop: false,
                    animType: AnimType.BOTTOMSLIDE,
                    title: 'info',
                    desc:
                    'Before add to cart Login Or Register please...?',
                    btnCancelOnPress: () {},
                    ).show();
                // showMessage(msg: "Item Deleted Successfully",color: Colors.green);
              }


            },
            builder: (context, state) {


              return Scaffold(
                backgroundColor: Colors.white,
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
                body: ConditionalBuilder(
                  condition: state is! GetProductDetailsDataLoadingState&&cubit!=null,
                  builder: (context) => SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 5),
                              child: Row(
                                children: [
                                  Text(cubit.title.split(" ")[0],style:const TextStyle(color: defaultColor,fontSize: 20,fontWeight: FontWeight.bold),),

                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 30,
                                            height: 25,
                                            child: const Center(
                                              child: Text(
                                                "5.6",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              color: defaultColor,
                                              borderRadius:
                                              BorderRadius.circular(2),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              ),
                                              const Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              ),
                                              const Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.grey[200],
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.grey[200],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Center(child: buildProductDetails(context, cubit))
                          ],
                        ),
                      ),
                    ),
                  ),
                  fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
                ),
              );
            })
    );
  }

  Widget MyDivider() => Column(
    children: [
      const SizedBox(
        height: 5,
      ),
      Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[200],
      ),
      const SizedBox(
        height: 5,
      ),
    ],
  );

  Widget buildProductDetails(context, ProductModel model) {
    print(model.priceFinalText);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          Column(
            children: [
              Center(
                child: Container(
                  height: 300,
                  width: 350,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image(
                    image: NetworkImage(
                      //  "https://image.made-in-china.com/2f0j00gpLRHTArqFkt/Custom-T-Shirts-100-Cotton-Men-Tshirt-Tee-Shirt-Printing-T-Shirt-Polo-T-Shirt-for-Men-Women-Plain-T-Shirt.jpg",
                        model.image ?? ""),

                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children:  [
                Text(
                  //   "${model.price}",
                  "${model.priceFinalText}",
                  style: const TextStyle(
                    fontSize: 20,
                    color: defaultColor,
                    fontWeight: FontWeight.bold,
                    // fontFamily: 'Font1',
                  ),
                ),

                const   SizedBox(width: 20,),
                if (model.discount != 0)
                  Text(
                    "${model.price}",
                    style:const  TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                const  Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child:
                  addOrDelete(context, model)

                ),
              ],
            ),
          ),
          MyDivider(),
          Text(
            // model.name.split(" ")[0]
            model.title!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              //   model.name,
              model.name!,
              style:const TextStyle(
                //fontWeight: FontWeight.bold,
                fontSize: 14,
                height: 1.3,
                color: Colors.grey,
              ),
            ),
          ),
          MyDivider(),
          if(model.description!=null)
            const Text(
              "Description",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),

          const SizedBox(
            height: 10,
          ),
          if(model.description!=null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child:  Center(
                  child:

                  Text(
                    model.description??"",
                    style:const TextStyle(
                      // fontFamily: "FONT1",
                      // fontWeight: FontWeight.w600,
                        color: Colors.black38),
                  ),
                ),
              ),
            ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
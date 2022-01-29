import 'package:amit_project/models/product%20model.dart';
import 'package:amit_project/moduels/Category/categoryProductsScreen.dart';
import 'package:amit_project/moduels/Product/productDetails.dart';
import 'package:amit_project/shared/cubit/cubit.dart';
import 'package:amit_project/shared/cubit/states.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constant.dart';

Widget customTextFormField(
    {required String lable,
      bool obsecure = false,
      required IconData prefix,
      IconData? suffixIcon,
      bool suffix = false,
      Function? fun,
      required String error,
      required TextEditingController controller,
      TextInputType type = TextInputType.text,
      bool? enable,
      onpressed}) {
  return TextFormField(
    validator: (s) {
      if (s!.trim().isEmpty) {
        return error;
      }
      if (lable == "Email" && s.trimLeft().length < 11) {
        if (!s.contains("@gmail.com")) {
          return "Your Email Must have @gmail.com";
        }
        return "Incorrect Email";
      }
      if (lable == "Email" && (s.contains("-") || s.contains("/"))) {
        return "Email doesn't allow - or /";
      }
      if (lable == "Password" && s.trimLeft().length < 8) {
        return "Password Can't be less than 8 Character";
      }

      return null;
    },
    controller: controller,
    obscureText: obsecure,
    cursorColor: defaultColor,
    keyboardType: type,
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: defaultColor,
        ),
      ),
      prefixIcon: Icon(
        prefix,
        color: Colors.grey,
      ),
      suffixIcon: suffix
          ? IconButton(
        icon: Icon(
          suffixIcon,
          color: Colors.black,
        ),
        onPressed: () {
          fun!();
        },
      )
          : null,
      labelText: lable,
      enabled: enable == null ? true : enable,
      labelStyle: const TextStyle(color: Colors.black),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}

Widget productBuilder(context, index, ProductModel model) {
  return Container(
    width: MediaQuery.of(context).size.width / 2.2,
    height: MediaQuery.of(context).size.height / 2.7,
    child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(model.id!))).then((value) {
                  HomeCubit.get(context).refresh();
        });
      },
      child: Material(
        shadowColor: Colors.grey[300],
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Stack(
              children: [
                Image(
                  image: NetworkImage(
                    //   "https://image.made-in-china.com/2f0j00gpLRHTArqFkt/Custom-T-Shirts-100-Cotton-Men-Tshirt-Tee-Shirt-Printing-T-Shirt-Polo-T-Shirt-for-Men-Women-Plain-T-Shirt.jpg",
                      model.image!),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width / 2.5,
                ),
                if (model.discount != 0)
                  Positioned(
                    top: 20,
                    right: 0,
                    child: Container(
                      width: 80,
                      height: 25,
                      color: Colors.grey,
                      child:const Center(
                          child: Text(
                            "Discount",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                    child: Text(
                      model.title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Text(
                      model.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      addOrDelete(context, model),
                      const Spacer(),
                      Row(
                        children: [
                          if (model.discount != 0)
                            Text(
                              "${model.price!}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            model.priceFinalText!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 14,
                                color: defaultColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget categoryBuilder(context, String image, String category, id) {
  return InkWell(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CategoryProductScreen(id))).then((value) {
        HomeCubit.get(context).refresh();
      });
    },
    child: Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              image:
              DecorationImage(image: NetworkImage(image), fit: BoxFit.fill),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.3),
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(
                child: Text(
                  category,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget emptyPage(
    {required context, required String image, required String text}) =>
    Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Image(
                image: NetworkImage(
                  image,
                ),
                width: 170,
                height: 110,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: defaultColor.withOpacity(0.8),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );

Widget buildCartItem(context, index,ProductModel  model) {
  return SafeArea(
    child: Dismissible(
      key: UniqueKey(),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(model.id!))).then((value) {
            HomeCubit.get(context).refresh();
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Material(
            shadowColor: Colors.grey[300],
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image(
                          image: NetworkImage(
                            // "https://image.made-in-china.com/2f0j00gpLRHTArqFkt/Custom-T-Shirts-100-Cotton-Men-Tshirt-Tee-Shirt-Printing-T-Shirt-Polo-T-Shirt-for-Men-Women-Plain-T-Shirt.jpg",
                              model.image!),
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (model.discount != 0)
                        Container(
                          width: 80,
                          height: 20,
                          color: Colors.red,
                          child: const Center(
                            child: Text(
                              "DISCOUNT",
                              style:
                              TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.title!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            model.name!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[700]),
                          ),
                          const Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                model.priceFinalText!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 14, color: defaultColor),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              if (model.discount != 0)
                                Text(
                                  "${model.price!}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.lineThrough),
                                ),
                              const Spacer(),
                              // Container(
                              //   width: 25,
                              //   height: 25,
                              //   child: MaterialButton(
                              //     onPressed: () {},
                              //     child: const Text(
                              //       "+",
                              //       style: TextStyle(
                              //         color: Colors.white,
                              //         fontSize: 13,
                              //
                              //
                              //       ),
                              //       textAlign: TextAlign.end,
                              //
                              //     ),
                              //     color: defaultColor,
                              //   ),
                              // ),
                              // const SizedBox(width: 8,),
                              // Container(
                              //   width: 30,
                              //   child: const Center(
                              //     child: Text(
                              //       "1",
                              //       style: TextStyle(
                              //         color: defaultColor,
                              //         fontSize: 16,
                              //
                              //
                              //       ),
                              //       textAlign: TextAlign.end,
                              //
                              //     ),
                              //   ),
                              // ),
                              // const SizedBox(width: 8,),
                              Container(
                                width: 30,
                                height: 30,
                                child: MaterialButton(
                                  onPressed: () {
                                    AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.WARNING,
                                        width: 340,
                                        buttonsBorderRadius:const  BorderRadius.all(
                                            Radius.circular(2)),
                                        headerAnimationLoop: false,
                                        animType: AnimType.BOTTOMSLIDE,
                                        title: 'Question',
                                        desc:
                                        'Are you Sure Delete This Item ...?',
                                        btnCancelOnPress: () {},
                                        btnOkOnPress: () {
                                          HomeCubit.get(context)
                                              .deleteCartItem(index,model.id!);
                                        }).show();
                                    // HomeCubit.get(context)
                                    //     .deleteCartItem(index);
                                  },
                                  child: const Text(
                                    "-",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 23,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  color: defaultColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      confirmDismiss: (direction) {
        return Future.value(direction == DismissDirection.horizontal);
      },
      onDismissed: (direction) {},
    ),
  );
}


Widget addOrDelete(context,ProductModel model)

{
  return   SizedBox(
    width: 35,
    height: 32,

    child:

    BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder:(context,state)=> IconButton(

        onPressed: ()
        {
          if(Token!=null&&Token!="")
             {
               if(HomeCubit.get(context).cartItemColor[model.id]==false||HomeCubit.get(context).cartItemColor[model.id]==null)
               {
                 HomeCubit.get(context).addCartItem(model);

               }
               else
               {
                 HomeCubit.get(context).deleteCartItem(indexx[model.id]!,model.id!);
               }
             }
          else
            {
              HomeCubit.get(context).loginPlease();
            }


        },
        icon: Icon(Icons.shopping_cart_outlined,color:HomeCubit.get(context).cartItemColor[model.id]==true? defaultColor:Colors.grey,size: 30,),
      ),
    ),
  );
}

void showMessage({@required msg, Color color = Colors.red}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}
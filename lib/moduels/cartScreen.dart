import 'package:amit_project/models/product%20model.dart';
import 'package:amit_project/moduels/login%20and%20register/loginScreen.dart';
import 'package:amit_project/moduels/login%20and%20register/registerScreen.dart';
import 'package:amit_project/shared/component/component.dart';
import 'package:amit_project/shared/cubit/cubit.dart';
import 'package:amit_project/shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//buildCartItem( context, index)
class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
     List<ProductModel>  list =HomeCubit.get(context).cartItems;
        return ConditionalBuilder(
            condition: false,
            builder: (context) {
              return cubit.login == 0 ? LoginScreen() : RegisterScreen();
            },
            fallback: (context) {
              return ConditionalBuilder(
                condition: list.isNotEmpty,
                builder:(context)=> SingleChildScrollView(
                  child: Column(
                    children: [
                    const   SizedBox(height: 15,),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => buildCartItem(context, index,list[index]),
                        itemCount: list.length,
                        separatorBuilder
                        :(context,index)=> const SizedBox(height: 10,),),
                      const   SizedBox(height: 15,),
                    ],
                  ),
                ),
                fallback: (context)=>emptyPage(
                    context: context,
                    image:"https://freepngimg.com/download/web_design/42851-3-cart-free-clipart-hd.png",
                    text: "Ouhh... Cart is Empty"),
              );
            });
      },
    );
  }
}

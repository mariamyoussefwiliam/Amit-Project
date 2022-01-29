import 'package:amit_project/shared/component/component.dart';
import 'package:amit_project/shared/component/constant.dart';
import 'package:amit_project/shared/cubit/cubit.dart';
import 'package:amit_project/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if(state is AddCartItemState)
            {
              showMessage(msg: "Item Added Successfully",color: Colors.green);
            }
          if(state is RemoveCartItemState)
          {
            showMessage(msg: "Item Deleted Successfully",color: Colors.green);
          }
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);

          return Scaffold(
            body: cubit.screens[cubit.index],
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(.1),
                  )
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                  child: GNav(
                    textStyle:const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
                      gap: 8,
                      activeColor: defaultColor,
                      iconSize: 24,
                      padding:
                        const  EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      duration:const Duration(milliseconds: 400),
                      tabBackgroundColor: Colors.grey[100]!,
                      color: Colors.black,
                      tabs: const [
                        GButton(
                          icon: Icons.home,
                          text: 'Home',
                        ),
                        GButton(
                          icon: Icons.category_outlined,
                          text: 'Category',
                        ),
                        GButton(
                          icon: Icons.shopping_cart_outlined,
                          text: 'Cart',
                        ),
                        GButton(
                          icon: Icons.person,
                          text: 'Profile',
                        ),
                      ],
                      selectedIndex: cubit.index,
                      onTabChange: (value) {
                        cubit.changeIndex(value);
                      }),
                ),
              ),
            ),

            // BottomNavigationBar(
            //   type: BottomNavigationBarType.fixed,
            //   currentIndex: cubit.index,
            //   onTap: (value) {
            //     cubit.changeIndex(value);
            //   },
            //   items: const [
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.home),
            //       title: Text("Home"),
            //     ),
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.category_outlined),
            //       title: Text("Category"),
            //     ),
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.shopping_cart_outlined),
            //       title: Text("Cart"),
            //     ),
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.menu),
            //       title: Text("Menu"),
            //     ),
            //   ],
            // ),
          );
        });
  }
}

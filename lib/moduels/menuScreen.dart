import 'package:amit_project/shared/component/component.dart';
import 'package:amit_project/shared/component/constant.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
   MenuScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return  SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
         // height:  MediaQuery.of(context).size.height/1.11,
          color: Colors.white,
          child: Center(
            child: Column(
              children: [
                // Container(
                //   width: double.infinity,
                //   height: MediaQuery.of(context).size.height/10,
                //   color: defaultColor,
                // ),
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height/10+ 120,
                      decoration: const BoxDecoration(
                          color: defaultColor,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.elliptical(400, 150),
                          )),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20,top: 70),
                        child: Material(
                          elevation: 5,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg',
                            //data!.image
                            fit: BoxFit.cover,
                            height: 170,
                            width: 170,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                   const    SizedBox(
                        height: 60,
                      ),

                      Padding(
                       padding:const  EdgeInsets.only(left: 8.0),
                       child:  Text("User Profile",style: TextStyle(fontSize: 25,color: Colors.grey[600])),
                     ),
                      const    SizedBox(
                        height: 25,
                      ),
                      customTextFormField(

                          enable: false,
                          onpressed: (){},
                          prefix: Icons.person, controller: nameController, error: '', lable: "Mariam Youssef"


                      ),
                      const    SizedBox(
                        height: 25,
                      ),

                      customTextFormField(

                          enable: false,
                          onpressed: (){},
                          prefix: Icons.email, controller: emailController, error: '', lable: 'MariamYoussef@gmail.com'


                      ),
                      const    SizedBox(
                        height: 25,
                      ),

                      const    SizedBox(
                        height: 25,
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

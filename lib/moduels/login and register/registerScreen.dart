import 'package:amit_project/moduels/login%20and%20register/cubit/state.dart';
import 'package:amit_project/shared/component/component.dart';
import 'package:amit_project/shared/component/constant.dart';
import 'package:amit_project/shared/cubit/cubit.dart';
import 'package:amit_project/shared/cubit/states.dart';
import 'package:amit_project/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool enaleEye = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            showMessage(msg: "registration done Successfully",color: Colors.green);
            CacheHelper.put(key: "token", value: state.model.token);
            HomeCubit.get(context).changeIndex(2);
            CacheHelper.put(key: "email", value:emailController.text);
            CacheHelper.put(key: "user name", value:emailController.text.split("@gmail.com")[0]);
            email=  CacheHelper.get(key: "email");
            name=  CacheHelper.get(key: "user name");
          }
          else{
            if(state is RegisterErrorState)
            {
              showMessage(msg: "error");
            }
          }
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return SafeArea(
            child: Container(
              color: Colors.white,
              height: double.infinity,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Text("Login",
                          //     style:
                          //         TextStyle(color: defaultColor, fontSize: 40)),
                          Image(
                            image: const AssetImage("assets/images/amit.jpg"),
                            width: MediaQuery.of(context).size.width / 1.3,
                            height: 90,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 1.35,
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                customTextFormField(
                                  error: "Name must be not empty",
                                  controller: nameController,
                                  type: TextInputType.text,
                                  lable: "Name",
                                  prefix: Icons.person,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                customTextFormField(
                                  error: "Email must be not empty",
                                  controller: emailController,
                                  type: TextInputType.emailAddress,
                                  lable: "Email",
                                  prefix: Icons.email,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                customTextFormField(
                                  error: "Password must be not empty",
                                  controller: passwordController,
                                  obsecure: !enaleEye,
                                  suffix: true,
                                  suffixIcon: !enaleEye
                                      ? Icons.remove_red_eye_sharp
                                      : Icons.remove_red_eye_outlined,
                                  fun: () {
                                    setState(() {
                                      enaleEye = !enaleEye;
                                    });
                                  },
                                  lable: "Password",
                                  prefix: Icons.lock,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                  //  width: MediaQuery.of(context).size.width / 4,
                                  ),
                              Container(
                                decoration: BoxDecoration(
                                  color: defaultColor,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                width: MediaQuery.of(context).size.width / 1.55,
                                height: 40,
                                child: MaterialButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      LoginCubit.get(context).UserRegister(name:nameController.text,email: emailController.text,password: passwordController.text);
                                    }
                                  },
                                  child: const Text(
                                    "SignUp",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          TextButton(
                              onPressed: () {
                                cubit.swapBetweenLoginAndRegister(0);
                              },
                              child: const Text(
                                  "Have an account ?\n \t \t\t \t Go Login.",
                                  style: TextStyle(color: Colors.black87)))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
/*

* */

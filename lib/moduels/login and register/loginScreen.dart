import 'package:amit_project/layout/homeLayout.dart';
import 'package:amit_project/moduels/login%20and%20register/cubit/cubit.dart';
import 'package:amit_project/moduels/login%20and%20register/cubit/state.dart';
import 'package:amit_project/shared/component/component.dart';
import 'package:amit_project/shared/component/constant.dart';
import 'package:amit_project/shared/cubit/cubit.dart';
import 'package:amit_project/shared/cubit/states.dart';
import 'package:amit_project/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool enaleEye = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {

      if (state is LoginSuccessState) {
        showMessage(msg: "login Successfully",color: Colors.green);
        CacheHelper.put(key: "token", value: state.model.token);
        Token=state.model.token;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) {
            return HomeLayout();
          }),
              (Route<dynamic> route) => false,
        );
        CacheHelper.put(key: "email", value:emailController.text);
        CacheHelper.put(key: "user name", value:emailController.text.split("@gmail.com")[0]);
        email=  CacheHelper.get(key: "email");
        name=  CacheHelper.get(key: "user name");
        }
      else{
        if(state is LoginErrorState)
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

                                     LoginCubit.get(context).UserLogin(email: emailController.text,password: passwordController.text);
                                      // Navigator.push(context,
                                      //     MaterialPageRoute(builder: (context) {
                                      //   return const HomeScreen();
                                      // }));
                                    }
                                  },
                                  child: const Text(
                                    "LOGIN",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                          TextButton(
                              onPressed: () {
                                cubit.swapBetweenLoginAndRegister(1);
                              },
                              child: const Text("Go SignUp",
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

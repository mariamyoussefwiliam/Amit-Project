import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    TextInputType type = TextInputType.text}) {
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
      labelStyle: const TextStyle(color: Colors.black),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}

Widget productBuilder(context) {
  return Container(
    decoration: const BoxDecoration(
      boxShadow: [BoxShadow(color: Colors.black)],
      color: Colors.white,
    ),
    width: MediaQuery.of(context).size.width / 2.2,
    height: MediaQuery.of(context).size.height / 2.7,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: const NetworkImage(
            "https://image.made-in-china.com/2f0j00gpLRHTArqFkt/Custom-T-Shirts-100-Cotton-Men-Tshirt-Tee-Shirt-Printing-T-Shirt-Polo-T-Shirt-for-Men-Women-Plain-T-Shirt.jpg",
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.width / 3,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
                child: Text(
                  "Product Name Product Name Product Name Product Name",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 50,
                child: Text(
                  "Product Description Product Description Product Description Product Description",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 35,
                    height: 35,
                    child: MaterialButton(
                      onPressed: () {},
                      child: const Text(
                        "+",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      color: defaultColor,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "200 EGP",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: defaultColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget categoryBuilder(context, String image, String category) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.fill),
        ),
      ),
      Container(
        color: Colors.black.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            category,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    ],
  );
}

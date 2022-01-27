import 'package:amit_project/shared/component/component.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    var height = 0.0;
    if (size < 600) {
      height = 1.6;
    } else {
      height = 1.12;
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
                11,
                (index) => productBuilder(context,index),
              ),
            ),
            const    SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}

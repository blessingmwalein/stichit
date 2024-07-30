import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/home/widgets/rug_calculator.dart';
import 'package:stichit/ui_commons/buttons/custom_button.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({super.key});

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  // Assume we have a counter for the number of rugs
  final int rugCounter = 10;

  final List<String> imgList = [
    'assets/images/r1.jpeg',
    'assets/images/r2.jpeg',
    'assets/images/r3.jpeg',
    'assets/images/r4.jpeg',
    'assets/images/r5.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 40, top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome to Stichit',
                    style: TextStyle(
                      fontSize: 30, // Increased font size
                      color: CustomColors.black,
                      fontWeight: FontWeight.w900, // Bold text
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'At Stichit, we specialize in creating beautiful, custom-made rugs that are perfect for any space. Whether you need a rug for your living room, bedroom, or office, we have got you covered with a wide range of designs and sizes to choose from.',
                    style: TextStyle(
                      fontSize: 16,
                      color: CustomColors.black
                          .withOpacity(0.6), // Reduced opacity
                    ),
                  ),
                  const SizedBox(height: 30),
                  imageSlider(),
                  const SizedBox(height: 30),
                  Container(
                    height: 60,
                    child: CustomButton(
                      label: 'Place Order',
                      isOutline: false,
                      radius: 40,
                      
                      primaryColor: CustomColors.black,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Expanded(
            child:RugCalculatorForm()
          ),
        ],
      ),
    );
  }

  Widget imageSlider() {
    return Container(
      height: 180, // Adjust height as needed
      width: double.infinity ,
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          // aspectRatio: 16/3, // Adjust aspect ratio as needed
          enlargeCenterPage: false,
          viewportFraction: 0.2, // Adjust this to control image size
          // initialPage: 0,
          enableInfiniteScroll: true,
        ),
        items: imgList.map((item) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            child: Image.asset(item, fit: BoxFit.cover, width: 1000),
          ),
        )).toList(),
      ),
    );
  }
}

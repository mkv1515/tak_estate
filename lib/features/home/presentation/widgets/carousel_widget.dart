import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tak/core/constants/constants.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  @override
  Widget build(BuildContext context) {
    final CarouselController controller = CarouselController();
    final List<Widget> imageSliders = imgList.map((item) {
      String heading = '';
      if (imgList.indexOf(item) == 0) {
        heading = 'Tak Continental Estate';
      }
      if (imgList.indexOf(item) == 1) {
        heading = '.... good life begins here';
      }
      if (imgList.indexOf(item) == 2) {
        heading = '.... all the comfort of a modern home';
      }
      if (imgList.indexOf(item) == 3) {
        heading = '....natural and comfortable living';
      }
      return Container(
        margin: EdgeInsets.all(5.0.w),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0.r)),
            child: Stack(
              children: <Widget>[
                Image.network(item, fit: BoxFit.cover, width: 1000.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 10.0.w, horizontal: 20.0.h),
                    child: Text(
                      heading,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      );
    }).toList();

    return SizedBox(
      height: 230.h,
      child: Column(children: [
        Expanded(
          child: CarouselSlider(
            items: imageSliders,
            carouselController: controller,
            options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {}),
          ),
        ),
      ]),
    );
  }
}

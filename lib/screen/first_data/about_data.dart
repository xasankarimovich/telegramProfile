import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:telegramprofile/models/data_id.dart';

class AboutData extends StatefulWidget {
  final int id;

  const AboutData({super.key, required this.id});

  @override
  State<AboutData> createState() => _AboutDataState();
}

class _AboutDataState extends State<AboutData> {
  AboutCar? aboutCar;
  bool isCheck = true;

  Future<void> aboutCarData() async {
    Response response = await http.get(Uri.parse(
        'https://easyenglishuzb.free.mockoapp.net/companies/${widget.id}'));
    try {
      if (response.statusCode == 200) {
        aboutCar = AboutCar.fromJson(jsonDecode(response.body));
        isCheck = false;
        setState(() {});
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  void initState() {
    aboutCarData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(

      value: const SystemUiOverlayStyle(
        systemStatusBarContrastEnforced: false,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,

      ),
      child: Scaffold(
        body: isCheck
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : Column(
          children: [
            CarouselSlider(
              items: List.generate(
                aboutCar!.carPics.length,
                    (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        24.r,
                      ),
                      child: Image.network(
                        aboutCar!.carPics[index],
                        height: 200.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
              options: CarouselOptions(
                height: 0.33 * MediaQuery.of(context).size.height,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 10),
                autoPlayCurve: Curves.linear,
                enlargeCenterPage: true,
                enlargeFactor: 0,
                onPageChanged: (v, d) {},
                scrollDirection: Axis.horizontal,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(aboutCar!.logo)),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  aboutCar!.carModel,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Year: ${aboutCar!.establishedYear}',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16.sp),
                    ),
                  ),
                  Text(
                    'Price: ${aboutCar!.averagePrice}',
                    style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16.sp),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      aboutCar!.description,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 12.sp),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

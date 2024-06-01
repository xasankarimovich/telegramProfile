import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:telegramprofile/models/data.dart';
import '../first_data/about_data.dart';

class SecontData extends StatefulWidget {
  const SecontData({super.key});

  @override
  State<SecontData> createState() => _SecontDataState();
}

class _SecontDataState extends State<SecontData> {
  Future<List<CarModel>?> carModelData() async {
    Response response;
    try {
      response = await http
          .get(Uri.parse("https://easyenglishuzb.free.mockoapp.net/companies"));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        return (jsonData['data'] as List?)
                ?.map((e) => CarModel.fromJson(e))
                .toList() ??
            [];
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
          body: FutureBuilder(
              future: carModelData(),
              builder: (
                context,
                AsyncSnapshot<List<CarModel>?> snapshot,
              ) {
                if (snapshot.data != null) {
                  List<CarModel> carData = snapshot.data as List<CarModel>;
                  return Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                            itemCount: carData.length,
                            padding: EdgeInsets.all(16.w),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.6,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              return Ink(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: Colors.white,
                                ),
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(16.r),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AboutData(
                                            id: carData[index].id,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(10.w),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                              width: 100.w,
                                              height: 100.h,
                                              child: Image.network(
                                                  carData[index].logo,
                                                  fit: BoxFit.contain)),
                                          Text(
                                            carData[index].carModel,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            'Price:  ${carData[index].price}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            'Year:  ${carData[index].year}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    )),
                              );
                            }),
                      )
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
    );
  }
}

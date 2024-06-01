import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:telegramprofile/models/data.dart';

import 'about_data.dart';

class FirstData extends StatefulWidget {
  const FirstData({super.key});

  @override
  State<FirstData> createState() => _FirstDataState();
}

class _FirstDataState extends State<FirstData> {
  bool isCheck = true;

  List<CarModel>? carDataList;

  Future<void> carModelData() async {
    Response response = await http.get(
        Uri.parse('https://easyenglishuzb.free.mockoapp.net/companies'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      carDataList =
          (jsonData['data'] as List).map((e) => CarModel.fromJson(e)).toList();
      isCheck = false;
      setState(() {});
    }
    else {
      print('Hata: ${response.statusCode}');
      throw Exception();
    }
  }

  @override
  void initState() {
    carModelData();
    print('data___________________${carDataList?[0].carModel}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF3F3F3),
        body: isCheck?
        const Center(
          child: CircularProgressIndicator(),
        ):Column(
          children: [
            Expanded(
              child:  GridView.builder(
                  itemCount: carDataList?.length,
                  padding: EdgeInsets.all(16.w),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          onTap:(){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AboutData(
                                  id: carDataList![index].id,
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
                                    child: Image.network(carDataList![index].logo,
                                        fit: BoxFit.contain)
                                ),
                                Text(carDataList![index].carModel,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                SizedBox(height: 5.h,),
                                Text('Price:  ${carDataList![index].price}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                                SizedBox(height: 5.h,),
                                Text('Year:  ${carDataList![index].year}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                    );
                  }),
            )
          ],
        )
    );
  }
}

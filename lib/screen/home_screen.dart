import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telegramprofile/screen/second_data/second_data.dart';

import 'first_data/first_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Ink(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(16.r)
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16.r),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FirstData(),),);
                    },
                    child: Center(
                      child: Text("One",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp
                        ),),
                    ),
                  )
              ),
              SizedBox(height: 20.h,),
              Ink(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(16.r)
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16.r),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SecontData()));
                    },
                    child: Center(
                      child: Text("Two",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp
                        ),),
                    ),
                  )
              ),
            ],
          ),
        )
    );
  }
}

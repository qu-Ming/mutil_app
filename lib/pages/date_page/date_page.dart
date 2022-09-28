import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:mutil_app/components/circle_avatar_component.dart';

import '../../utils/const/app_colors.dart';

class DatePage extends StatefulWidget {
  const DatePage({Key? key}) : super(key: key);

  @override
  State<DatePage> createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  String date = '${DateTime.parse('2017-12-09')}';
  int? dayBeen;

  // String formatDay = '';
  // DateTime? pickDate;

  // DateTime ngayHomNay = DateTime.now();

  // DateTime dayNow = DateTime.now();
  String assetImageN = 'assets/backgrounds/image.jpeg';

  String assetImageM = 'assets/backgrounds/image2.jpeg';

  String background = 'assets/backgrounds/background.jpg';
  @override
  void initState() {
    super.initState();
    readDay();
    // readDate();
  }

  bool seeDay = true;
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(background), fit: BoxFit.cover)),
                    child: Column(
                      children: [
                        // Text(
                        //   "Ngày quen: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(date))}",
                        //   style: const TextStyle(
                        //     fontFamily: "Poppins",
                        //     fontSize: 12,
                        //   ),
                        // ),

                        Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: Text(
                            seeDay == true
                                ? "Ngày bên nhau"
                                : "Tháng năm bên nhau",
                            style: const TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 12,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            onClick();
                          },
                          child: Text(
                            seeDay == true ? '$dayBeen ngày' : '4N 6T 23N',
                            style: const TextStyle(
                                fontFamily: "Poppins",
                                color: AppColors.colorPink,
                                fontSize: 50.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -50,
                    right: 0,
                    left: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (() {
                            openDialog(context);
                          }),
                          child: CircleAvatarComponent(
                            name: 'Ngân',
                            assetImage: assetImageM,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: LikeButton(
                            size: 40.0,
                            countPostion: CountPostion.bottom,
                            likeBuilder: (isLiked) {
                              final color = isLiked
                                  ? AppColors.colorPink
                                  : AppColors.colorGrey2;

                              return Icon(
                                Icons.favorite,
                                color: color,
                                size: 40.0,
                              );
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: (() {
                            openDialog(context);
                          }),
                          child: CircleAvatarComponent(
                            name: 'Minh',
                            assetImage: assetImageN,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                clipBehavior: Clip.none,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 95.0, left: 50.0, right: 50.0),
                child: LinearProgressIndicator(
                  color: AppColors.colorPink,
                  backgroundColor: AppColors.colorGrey,
                  value: 0.7,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Future readDate() async {
  //   final prefs = await SharedPreferences.getInstance();

  //   setState(() {
  //     date = prefs.getString('number_key') ?? date;
  //   });
  // }

  // Future openCalender() async {
  //   pickDate = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(2000),
  //       lastDate: DateTime.now());
  //   final prefs = await SharedPreferences.getInstance();

  //   setState(() {
  //     if (pickDate != null) {
  //       prefs.clear();
  //       date = (prefs.getString('number_key') ?? '') + '$pickDate';
  //       dayBeen = DateTime.now().difference(DateTime.parse(date)).inDays;
  //       prefs.setString('number_key', pickDate.toString());
  //     } else {
  //       print('Close');
  //     }
  //     Navigator.pop(context);
  //   });
  // }

  // Future deleteDate() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   await preferences.remove('number_key');
  //   setState(() {
  //     date = '${DateTime.parse('2000-12-17')}';
  //     dayBeen = 0;
  //   });
  // }

  Future readDay() async {
    dayBeen = DateTime.now().difference(DateTime.parse(date)).inDays;
  }

  openDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Đổi ảnh'),
              content: TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Nhập đường liên kết ảnh vào'),
              ),
              actions: [
                Center(
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text('Xác nhận')))
              ],
            ));
  }

  onClick() {
    setState(() {
      seeDay = !seeDay;
    });
  }
}

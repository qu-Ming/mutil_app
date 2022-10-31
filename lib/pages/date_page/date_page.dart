import 'dart:io';
import 'package:image/image.dart' as img;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:like_button/like_button.dart';
import 'package:mutil_app/components/circle_avatar_component.dart';
import 'package:mutil_app/components/text_component.dart';
import 'package:mutil_app/utils/const/app_dimens.dart';

import '../../utils/const/app_colors.dart';

class DatePage extends StatefulWidget {
  const DatePage({Key? key}) : super(key: key);

  @override
  State<DatePage> createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  @override
  void initState() {
    super.initState();
    readDay();
  }

  String dayBeenTogether = '';
  String sodau = '';
  String socuoi = '';

  double? distance;

  int? nam;
  int? thang;
  int? ngay;

  int n = 1;

  String assetImageN = 'assets/backgrounds/image.jpeg';

  String assetImageM = 'assets/backgrounds/image2.JPEG';

  String background = 'assets/backgrounds/bglo.jpg';
  bool seeDay = true;
  bool isLiked = false;

  XFile? hinhAnh1;
  XFile? hinhAnh2;
  Future openGallary() async {
    try {
      hinhAnh1 = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (hinhAnh1 == null) {
        return;
      }
      final imageTem = XFile(hinhAnh1!.path);
      setState(() {
        hinhAnh1 = imageTem;
      });
    } on PlatformException catch (e) {
      print('Failed $e');
    }
  }

  Future openCamera() async {
    hinhAnh2 = await ImagePicker().pickImage(source: ImageSource.camera);
  }

  Future openGallary2() async {
    try {
      hinhAnh2 = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (hinhAnh2 == null) {
        return;
      }
      final imageTem = XFile(hinhAnh2!.path);
      setState(() {
        hinhAnh2 = imageTem;
      });
    } on PlatformException catch (e) {
      print('Failed $e');
    }
  }

  Future openCamera2() async {
    hinhAnh2 = await ImagePicker().pickImage(source: ImageSource.camera);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.65,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(background), fit: BoxFit.cover)),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.more_vert,
                              color: AppColors.colorWhite,
                            ),
                          ),
                        ),
                        Text(
                          seeDay == true
                              ? "Ngày bên nhau"
                              : "Tháng năm bên nhau",
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            onClick();
                          },
                          child: Text(
                            seeDay == true
                                ? '$dayBeenTogether ngày'
                                : '${nam}N ${thang}T ${ngay}n',
                            style: const TextStyle(
                                fontFamily: "Poppins",
                                color: AppColors.colorWhite,
                                fontSize: 45.0,
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
                        hinhAnh1 == null
                            ? GestureDetector(
                                onTap: (() {
                                  openDialog();
                                }),
                                child: CircleAvatarComponent(
                                  name: 'Ngân',
                                  assetImage: assetImageM,
                                ),
                              )
                            : Column(
                                children: [
                                  ClipOval(
                                    child: Image.file(
                                      File(hinhAnh1!.path),
                                      fit: BoxFit.cover,
                                      height: 75.0,
                                      width: 75.0,
                                    ),
                                  ),
                                  const TextComponent(
                                    text: 'Ngân',
                                    fontWeight: FontWeight.w600,
                                    colorText: AppColors.colorPink,
                                  )
                                ],
                              ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: LikeButton(
                            size: 40.0,
                            countPostion: CountPostion.bottom,
                            likeBuilder: (isLiked) {
                              final color = isLiked
                                  ? AppColors.colorLightRed
                                  : AppColors.colorGrey2;

                              return Icon(
                                Icons.favorite,
                                color: color,
                                size: 40.0,
                              );
                            },
                          ),
                        ),
                        hinhAnh2 == null
                            ? GestureDetector(
                                onTap: (() {
                                  openDialog2();
                                }),
                                child: CircleAvatarComponent(
                                  name: 'Minh',
                                  assetImage: assetImageN,
                                ),
                              )
                            : Column(
                                children: [
                                  ClipOval(
                                    child: Image.file(
                                      File(hinhAnh2!.path),
                                      fit: BoxFit.cover,
                                      height: 75.0,
                                      width: 75.0,
                                    ),
                                  ),
                                  const TextComponent(
                                    text: 'Minh',
                                    fontWeight: FontWeight.w600,
                                    colorText: AppColors.colorPink,
                                  )
                                ],
                              ),
                      ],
                    ),
                  ),
                ],
                clipBehavior: Clip.none,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 90, 10, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextComponent(
                      text: sodau,
                      colorText: AppColors.colorPink,
                      textSize: AppDimens.text_size_14,
                    ),
                    SizedBox(
                      height: 7,
                      width: 250,
                      child: LinearProgressIndicator(
                        color: AppColors.colorLightRed,
                        backgroundColor: AppColors.colorGrey,
                        value: distance,
                      ),
                    ),
                    TextComponent(
                      text: socuoi,
                      textSize: AppDimens.text_size_14,
                      colorText: AppColors.colorPink,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  readDay() {
    String date = '${DateTime.parse('2017-12-09')}';
    int? dayBeen;

    dayBeen = DateTime.now().difference(DateTime.parse(date)).inDays;

    int nghin = ((dayBeen % 10000) / 1000).floor();
    int tram = ((dayBeen % 1000) / 100).floor();
    int chuc = ((dayBeen % 100) / 10).floor();
    int donVi = ((dayBeen % 10)).floor();

    int chucInt = dayBeen % 100;

    dayBeenTogether = '$nghin$tram$chuc$donVi';

    sodau = '$nghin$tram${chuc = 0}${donVi = 0}';

    socuoi = '$nghin${tram + 1}${chuc = 0}${donVi = 0}';

    distance = chucInt / (int.parse(socuoi) - int.parse(sodau));

    nam = (dayBeen / 365).floor();
    thang = ((dayBeen % 365) / 30).floor();
    ngay = ((dayBeen % 365) % 30);
  }

  openDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Đổi ảnh'),
              content: SizedBox(
                height: 100.0,
                child: Column(children: [
                  ElevatedButton(
                      onPressed: () {
                        openGallary();
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.colorPink)),
                      child: const Text('Thư viện')),
                  ElevatedButton(
                      onPressed: () {
                        openCamera();
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.colorPink)),
                      child: const Text('Máy ảnh')),
                ]),
              ),
            ));
  }

  openDialog2() {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Đổi ảnh'),
              content: SizedBox(
                height: 100.0,
                child: Column(children: [
                  ElevatedButton(
                      onPressed: () {
                        openGallary2();
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.colorPink)),
                      child: const Text('Thư viện')),
                  ElevatedButton(
                      onPressed: () {
                        openCamera2();
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.colorPink)),
                      child: const Text('Máy ảnh')),
                ]),
              ),
            ));
  }

  onClick() {
    setState(
      () {
        seeDay = !seeDay;
      },
    );
  }

  onTaped() {
    n = n++;
  }
}

import 'package:flutter/material.dart';
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

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    readDay();
  }

  bool seeDay = true;
  bool isLiked = false;

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
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
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
                            seeDay == true
                                ? '$dayBeenTogether ngày'
                                : '${nam}N ${thang}T ${ngay}N',
                            style: const TextStyle(
                                fontFamily: "Poppins",
                                color: AppColors.colorWhite,
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
                            openDialog();
                          }),
                          child: CircleAvatarComponent(
                              name: 'Ngân', assetImage: assetImageM),
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
                        GestureDetector(
                          onTap: (() {
                            openDialog();
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
              // Padding(
              //   padding:
              //       const EdgeInsets.only(top: 95.0, left: 60.0, right: 60.0),
              //   child: LinearProgressIndicator(
              //     color: AppColors.colorLightRed,
              //     backgroundColor: AppColors.colorGrey,
              //     value: distance,
              //   ),
              // ),
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

  Future readDay() async {
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

  Future openGallary() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    } else {
      final imageTem = XFile(image.path);
    }
  }

  Future openCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
  }
}

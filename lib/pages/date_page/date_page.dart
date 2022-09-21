import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mutil_app/components/circle_avatar_component.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/const/app_colors.dart';

class DatePage extends StatefulWidget {
  const DatePage({Key? key}) : super(key: key);

  @override
  State<DatePage> createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  String date = '${DateTime.parse('2000-12-17')}';
  int? dayBeen;
  String formatDay = '';
  DateTime? pickDate;
  @override
  void initState() {
    super.initState();
    readDate();
  }

  DateTime dayNow = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.colorPink2,
        elevation: 0,
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: InkWell(
                          onTap: () {
                            openCalender();
                          },
                          child: const Text('Chọn ngày kỷ niệm')),
                    ),
                    PopupMenuItem(
                      child: InkWell(
                          onTap: () {
                            deleteDate();
                            Navigator.pop(context);
                          },
                          child: const Text('Đặt lại ngày')),
                    )
                  ])
        ],
      ),
      body: SafeArea(
        child: BodyDatePage(date: date, dayBeen: dayBeen),
      ),
    );
  }

  Future readDate() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      date = prefs.getString('number_key') ?? date;
      dayBeen = (prefs.getInt('key') ?? 0);
    });
  }

  Future openCalender() async {
    pickDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now());
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      if (pickDate != null) {
        prefs.clear();
        date = (prefs.getString('number_key') ?? '') + '$pickDate';
        dayBeen = (prefs.getInt('key') ?? 0) +
            DateTime.now().difference(DateTime.parse(date)).inDays;
        prefs.setString('number_key', pickDate.toString());
        prefs.setInt('key', dayBeen!);
      } else {
        print('Close');
      }
      Navigator.pop(context);
    });
  }

  Future deleteDate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('number_key');
    await preferences.remove('key');
    setState(() {
      date = '${DateTime.parse('2000-12-17')}';
      dayBeen = 0;
    });
  }
}

class BodyDatePage extends StatelessWidget {
  const BodyDatePage({
    Key? key,
    required this.date,
    required this.dayBeen,
  }) : super(key: key);

  final String date;
  final int? dayBeen;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.colorPink2,
              ),
              child: Column(
                children: [
                  Text(
                    DateFormat('dd-MM-yyyy').format(DateTime.parse(date)),
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    dayBeen == null ? 'null' : '$dayBeen ngày',
                    style: const TextStyle(
                        fontFamily: "Poppins",
                        color: AppColors.colorWhite,
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: -40,
              right: 0,
              left: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatarComponent(
                    name: 'Ngan',
                    urlImage:
                        'https://i.chungta.vn/2019/08/16/20190816152753-1565947732.png',
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(
                      Icons.favorite,
                      size: 50.0,
                      color: AppColors.colorPink,
                    ),
                  ),
                  CircleAvatarComponent(
                    name: 'Ngan',
                    urlImage:
                        'https://i.chungta.vn/2019/08/16/20190816152753-1565947732.png',
                  ),
                ],
              ),
            ),
          ],
          clipBehavior: Clip.none,
        ),
      ],
    );
  }
}

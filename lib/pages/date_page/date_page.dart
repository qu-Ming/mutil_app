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
                            Navigator.pop(context);
                          },
                          child: const Text('Điều chỉnh trang')),
                    ),
                    PopupMenuItem(
                      child: InkWell(
                          onTap: () {
                            deleteDate();
                            Navigator.pop(context);
                          },
                          child: const Text('Đặt lại ngày')),
                    ),
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
              height: MediaQuery.of(context).size.height * 0.25,
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
              bottom: -50,
              right: 0,
              left: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatarComponent(
                    name: 'Quang Minh',
                    urlImage:
                        'https://scontent.fsgn5-6.fna.fbcdn.net/v/t39.30808-6/241511531_1256987988087163_2217690422918080997_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=174925&_nc_ohc=1IjmUD_2KMEAX_Zk9_G&_nc_ht=scontent.fsgn5-6.fna&oh=00_AT-ymoHLzuWHEawQuvofprrBLbI0Cq_1cPNOUkh2QTQxVA&oe=632F32D0',
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
                    name: 'Diệu Ngân',
                    urlImage:
                        'https://scontent.fsgn5-10.fna.fbcdn.net/v/t39.30808-6/287544885_736797004225025_1577202089837034274_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=174925&_nc_ohc=kWn_7be0RIwAX-0PPYm&_nc_ht=scontent.fsgn5-10.fna&oh=00_AT8LxBYBBsg-FGZRyYZx1ET-JbNLFfp5-D0aTJbAunwSMA&oe=632EB73C',
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

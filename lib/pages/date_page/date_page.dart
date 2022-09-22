import 'package:flutter/material.dart';
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
  String urlM =
      'https://scontent.fsgn5-6.fna.fbcdn.net/v/t39.30808-6/241511531_1256987988087163_2217690422918080997_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=174925&_nc_ohc=1IjmUD_2KMEAX_Zk9_G&_nc_ht=scontent.fsgn5-6.fna&oh=00_AT-ymoHLzuWHEawQuvofprrBLbI0Cq_1cPNOUkh2QTQxVA&oe=632F32D0';

  String urlN =
      'https://scontent.fsgn5-10.fna.fbcdn.net/v/t39.30808-6/287544885_736797004225025_1577202089837034274_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=174925&_nc_ohc=kWn_7be0RIwAX-0PPYm&_nc_ht=scontent.fsgn5-10.fna&oh=00_AT8LxBYBBsg-FGZRyYZx1ET-JbNLFfp5-D0aTJbAunwSMA&oe=632EB73C';
  @override
  void initState() {
    super.initState();
    readDay();
    // readDate();
  }

  bool seeDay = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.colorPink,
        elevation: 0,
        actions: const [
          // PopupMenuButton(
          //     itemBuilder: (context) => [
          //           PopupMenuItem(
          //             child: InkWell(
          //                 onTap: () {
          //                   openCalender();
          //                 },
          //                 child: const Text('Chọn ngày kỷ niệm')),
          //           ),
          //           PopupMenuItem(
          //             child: InkWell(
          //                 onTap: () {
          //                   Navigator.pop(context);
          //                 },
          //                 child: const Text('Điều chỉnh trang')),
          //           ),
          //           PopupMenuItem(
          //             child: InkWell(
          //                 onTap: () {
          //                   deleteDate();
          //                   Navigator.pop(context);
          //                 },
          //                 child: const Text('Đặt lại ngày')),
          //           ),
          //         ])
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.22,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.colorPink,
                ),
                child: Column(
                  children: [
                    // Text(
                    //   "Ngày quen: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(date))}",
                    //   style: const TextStyle(
                    //     fontFamily: "Poppins",
                    //     fontSize: 12,
                    //   ),
                    // ),
                    Text(
                      seeDay == true ? "Ngày bên nhau" : "Năm tháng bên nhau",
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
                        seeDay == true ? '$dayBeen ngày' : 'aas',
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
                        openDialog(context);
                      }),
                      child: CircleAvatarComponent(
                        name: 'Minh',
                        urlImage: urlM,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(
                        Icons.favorite,
                        size: 55.0,
                        color: AppColors.colorLightRed,
                      ),
                    ),
                    GestureDetector(
                      onTap: (() {
                        openDialog(context);
                      }),
                      child: CircleAvatarComponent(
                        name: 'Ngân',
                        urlImage: urlN,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            clipBehavior: Clip.none,
          ),
        ],
      )),
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
                decoration:
                    const InputDecoration(labelText: 'Nhập link avt vào'),
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

import 'package:flutter/material.dart';
import 'package:mutil_app/pages/random_page/percent.dart';
import 'package:mutil_app/pages/random_page/random.dart';
import '../../utils/const/app_colors.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({Key? key}) : super(key: key);

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.colorPink4,
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: DefaultTabController(
            length: 2,
            child: SafeArea(
              child: Column(
                children: const [
                  TabBar(
                    labelColor: AppColors.colorPink,
                    indicatorColor: AppColors.colorGrey2,
                    unselectedLabelColor: AppColors.colorGrey2,
                    tabs: [
                      Tab(
                        icon: Icon(
                          Icons.shuffle,
                        ),
                      ),
                      Tab(
                        icon: Icon(Icons.calculate),
                      )
                    ],
                  ),
                  Expanded(
                      child: TabBarView(
                    children: [RandomTab(), PercentTab()],
                  ))
                ],
              ),
            ),
          ),
        ));
  }
}

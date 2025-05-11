import 'package:code_quest/core/local_storage/storage_helper.dart';
import 'package:code_quest/core/theme/color_manager.dart';
import 'package:code_quest/core/theme/text_styles_manager.dart';
import 'package:code_quest/features/appointments_screen/presentation/appointments_screen.dart';
import 'package:code_quest/features/authentication/presentation/login_screen.dart';
import 'package:code_quest/features/providers_screen/presentation/specialist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Spacer(),
                  Text(
                    'Hi ${LocalStorage.getData(key: Constants.loggedInUser) ?? ''} Welcome',
                    style: getRegularStyle(fontSize: 0.022.sh),
                  ),
                  Spacer(),
                  InkWell(
                      onTap: () {
                        LocalStorage.removeData(key: Constants.loggedInEmail);
                        LocalStorage.removeData(
                          key: Constants.loggedInUser,
                        );
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => LoginScreen()),
                            (Route<dynamic> route) => false);
                      },
                      child: Icon(
                        Icons.logout,
                        color: Colors.red,
                      )),
                ],
              ),
            ),
            10.verticalSpace,
            Center(
              child: Container(
                height: 50,
                width: 0.9.sw,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                currentIndex = 0;
                              });
                            },
                            child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: currentIndex == 0
                                      ? ColorManager.white
                                      : ColorManager.lightPrimary,
                                ),
                                child: Center(
                                  child: Text(
                                    'Specialists',
                                    style: getMediumStyle(
                                        color: currentIndex == 0
                                            ? ColorManager.primary
                                            : ColorManager.black),
                                  ),
                                ))),
                      ),
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                currentIndex = 1;
                              });
                            },
                            child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: currentIndex == 1
                                      ? ColorManager.white
                                      : ColorManager.lightPrimary,
                                ),
                                child: Center(
                                  child: Text(
                                    'Appointments',
                                    style: getMediumStyle(
                                        color: currentIndex == 1
                                            ? ColorManager.primary
                                            : ColorManager.black),
                                  ),
                                ))),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            10.verticalSpace,
            Expanded(
                child: currentIndex == 0
                    ? SpecialistsScreen()
                    : AppointmentsScreen())
          ],
        ),
      ),
    );
  }
}

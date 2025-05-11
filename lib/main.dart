import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/utils/constants.dart';
import 'core/local_storage/storage_helper.dart';
import 'core/service_injection/injection_imports.dart';
import 'features/authentication/presentation/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'features/providers_screen/presentation/specialist_screen.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await Firebase.initializeApp();
  await LocalStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: 'Code Quest',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: Colors.white,
          ),
        ),
        home: LocalStorage.getData(key: Constants.registeredEmails) != null
            ? const HomeScreen()
            : LoginScreen(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:glades/view/login_page.dart';
import 'package:glades/view/provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'core/data/di.dart';
import 'core/network/app_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeCore(environment: Environment.staging);
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderMainClass(inject())),
        // ChangeNotifierProvider(create: (_) => GoogleSignInProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: ResponsiveSizer(builder: (context, orientation, screenType) {
          return const LoginPage();
        }),
      ),
    );
  }
}

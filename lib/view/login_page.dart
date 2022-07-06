import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glades/view/provider/provider.dart';
import 'package:glades/view/widget/color.dart';
import 'package:glades/view/widget/texr_form_field.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:glades/view/provider/google_sign_in.provider.dart';

import '../core/validator.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginProvider? loginProvider;

  final _globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    loginProvider = Provider.of<LoginProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "GLADES",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColor.primary,
        ),
        body: Form(
          key: _globalKey,
          child: Center(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'LOGIN',
                      style: TextStyle(
                          color: Color.fromARGB(255, 11, 8, 163),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    EditTextForm(
                      controller: emailController,
                      validator: Validators.validateString(),
                      label: 'email',
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    EditTextForm(
                      controller: passwordController,
                      validator: Validators.validateString(),
                      label: 'password',
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    InkWell(
                      onTap: () => implSnackBar(
                          context, 'You can\'t sign in using Google for now'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/google.svg',
                            width: 34,
                            height: 34,
                          ),
                          SizedBox(
                            width: 2.h,
                          ),
                          Text(
                            'Sign in with Google',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_globalKey.currentState!.validate()) {
                              loginProvider!.login(
                                  context: context,
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: 4.w,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              primary: AppColor.primary),
                          child: Consumer<LoginProvider>(
                            builder: (_, provider, __) {
                              return provider.isLogin
                                  ? SpinKitWave(
                                      color: Colors.white,
                                      size: 25.sp,
                                    )
                                  : Text(
                                      'SUBMIT',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                    );
                            },
                          )),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

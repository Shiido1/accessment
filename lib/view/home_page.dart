import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:glades/core/validator.dart';
import 'package:glades/view/bank_screen.dart';
import 'package:glades/view/provider/provider.dart';
import 'package:glades/view/widget/color.dart';
import 'package:glades/view/widget/texr_form_field.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'provider/model/global.model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProviderMainClass? providerMainClass;

  final _globalKey = GlobalKey<FormState>();

  bool loading = false;
  @override
  void initState() {
    providerMainClass = Provider.of<ProviderMainClass>(context, listen: false);
    providerMainClass!.inquire(context: context, inquire: 'banks');
    bank = 'Select Bank';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "GLADES",
          style: TextStyle(color:  AppColor.white),
        ),
        backgroundColor:  AppColor.primary,
      ),
      body: Form(
        key: _globalKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              EditTextForm(
                controller: bankController,
                readOnly: true,
                validator: Validators.validateString(),
                autoValidateMode: AutovalidateMode.onUserInteraction,
                onTapped: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BankScreen()),
                ),
                suffixWidget: IconButton(
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BankScreen()),
                        ),
                    icon: const Icon(Icons.arrow_drop_down)),
                suffixIconColor: AppColor.primary,
                label: 'Select Bank',
              ),
              SizedBox(height: 5.h),
              EditTextForm(
                controller: verifyNameController,
                validator: Validators.validateString(),
                autoValidateMode: AutovalidateMode.onUserInteraction,
                label: 'Accoount Name',
              ),
              SizedBox(
                height: 12.h,
              ),
              SizedBox(
                width: double.infinity,
                height: 8.h,
                child: ElevatedButton(
                    onPressed: () {
                      if (_globalKey.currentState!.validate()) {
                        providerMainClass!
                            .verify(context, verifyNameController.text);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        primary: AppColor.primary),
                    child:
                        Consumer<ProviderMainClass>(builder: (_, provider, __) {
                      return provider.isLoading
                          ? SpinKitWave(
                              color: AppColor.white,
                              size: 25.sp,
                            )
                          : Text(
                              'VERIFY ACCOUNT NAME',
                              style: TextStyle(
                                  color:  AppColor.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500),
                            );
                    })),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

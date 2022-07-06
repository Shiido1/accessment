import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:glades/view/provider/provider.dart';
import 'package:glades/view/widget/color.dart';
import 'package:glades/view/widget/texr_form_field.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'provider/model/global.model.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  ProviderMainClass? providerMainClass;
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController narrationController = TextEditingController();
  TextEditingController orderRefController = TextEditingController();

  @override
  void initState() {
    providerMainClass = Provider.of<ProviderMainClass>(context, listen: false);
    super.initState();
  }

  bool loading = false;
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
        title: Text(
          "GLADES",
          style: TextStyle(color: AppColor.white, fontSize: 18.sp),
        ),
        backgroundColor: AppColor.primary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'VERIFY ACCOUNT NAME',
              style: TextStyle(
                  color: AppColor.primary,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5.h,
            ),
            EditTextForm(
              controller: verifyNameController,
              readOnly: true,
            ),
            SizedBox(
              height: 7.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 5,
                  color: const Color.fromARGB(255, 226, 228, 247),
                  child: Container(
                      padding: EdgeInsets.fromLTRB(4.w, 3.w, 4.w, 2.w),
                      margin: EdgeInsets.only(
                          left: 3.w, right: 3.w, top: 3.w, bottom: 3.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        'Hello ${providerMainClass?.verifyResponse["data"]["account_name"]} you have successfully verified your account name, you can now make a single transfer',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.5.sp,
                            fontWeight: FontWeight.w600),
                      )),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Make A Single Payment Transaction',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.5.sp,
                      fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 4.h),
                EditTextForm(
                  controller: nameController,
                  label: 'Name of Recipient',
                ),
                EditTextForm(
                  controller: amountController,
                  label: 'Amount',
                ),
                EditTextForm(
                  controller: narrationController,
                  label: 'Narration',
                ),
                EditTextForm(
                  controller: orderRefController,
                  label:
                      'Order of Referrence should be in (TX00001) e.g, Format',
                ),
                SizedBox(
                  height: 7.h,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 8.h,
                  child: ElevatedButton(
                      onPressed: () {
                        providerMainClass?.singleTransfer(
                            context: context,
                            name: nameController.text.trim(),
                            amount: amountController.text.trim(),
                            narration: narrationController.text.trim(),
                            orderRef: orderRefController.text.trim());
                        setState(() {
                          orderRef = orderRefController.text.trim();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          primary: AppColor.primary),
                      child: Consumer<ProviderMainClass>(
                          builder: (_, provider, __) {
                        return provider.isSingleLoading
                            ? SpinKitWave(
                                color: Colors.white,
                                size: 25.sp,
                              )
                            : Text(
                                'MAKE SINGLE TRANSFER',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500),
                              );
                      })),
                ),
                Consumer<ProviderMainClass>(
                  builder: (_, provider, __) {
                    return Visibility(
                        visible: provider.isSingleShow == true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 8.h,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 50.0,
                              child: ElevatedButton(
                                  onPressed: () {
                                    provider.verifyTransfer(
                                        context: context, orderRef: orderRef);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      primary: AppColor.primary),
                                  child: provider.isVerifyLoading == true
                                      ? SpinKitWave(
                                          color: Colors.white,
                                          size: 25.sp,
                                        )
                                      : Text(
                                          'VERIFY SINGLE TRANSFER',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w500),
                                        )),
                            ),
                          ],
                        ));
                  },
                ),
                SizedBox(
                  height: 10.h,
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:glades/view/bank_screen.dart';
import 'package:glades/view/provider/provider.dart';
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

  bool loading = false;
  @override
  void initState() {
    providerMainClass = Provider.of<ProviderMainClass>(context, listen: false);
    providerMainClass!.inquire(context: context, inquire: 'banks');
    bank = 'Select Bank';
    super.initState();
  }

  verifyAccount(context) {
    if (bankController.text.isNotEmpty) {
      providerMainClass!.verify(context, verifyNameController.text);
    } else {
      providerMainClass!.implSnackBar(context, 'Please select bank type');
    }
    setState(() {
      loading = true;
    });
    print(bankController.text);
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
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 11, 8, 163),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 10.h,
              child: TextFormField(
                controller: bankController,
                readOnly: true,
                decoration: InputDecoration(
                  suffixIconColor: const Color.fromARGB(255, 11, 8, 163),
                  suffix: IconButton(
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BankScreen()),
                          ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        size: 22,
                        color: Color.fromARGB(255, 11, 8, 163),
                      )),
                  // label: const Text('Select bank'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.h),
            SizedBox(
              height: 10.h,
              child: TextFormField(
                controller: verifyNameController,
                decoration: InputDecoration(
                  suffixIconColor: const Color.fromARGB(255, 11, 8, 163),

                  // label: const Text('Select bank'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            SizedBox(
              width: double.infinity,
              height: 10.h,
              child: ElevatedButton(
                  onPressed: () => verifyAccount(context),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      primary: const Color.fromARGB(
                        255,
                        11,
                        8,
                        163,
                      )),
                  child: !loading
                      ? const SpinKitWave(
                          color: Colors.white,
                          size: 32.0,
                        )
                      : const Text(
                          'VERIFY ACCOUNT NAME',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        )),
            ),
            //   const SizedBox(
            //     height: 50,
            //   ),
            //   Visibility(
            //     visible: providerMainClass!.isShow == true,
            //     child: Column(
            //       children: [
            //         Card(
            //           elevation: 5,
            //           color: const Color.fromARGB(255, 226, 228, 247),
            //           child: Container(
            //               padding: const EdgeInsets.fromLTRB(16.0, 12.0, 0, 8),
            //               margin: const EdgeInsets.only(
            //                   left: 16.0, right: 8.0, top: 20, bottom: 20),
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(4.0),
            //               ),
            //               child: Text('ME i see u')
            //               //  Text(
            //               //   'Hello ${providerMainClass?.verifyResponse["data"]["accountname"]} you have successfully verified you account name, you can now make a single transfer',
            //               //   style: const TextStyle(
            //               //       color: Colors.black,
            //               //       fontSize: 15,
            //               //       fontWeight: FontWeight.w400),
            //               // )
            //               ),
            //         ),
            //
            //       ],
            //     ),
            //   )
          ],
        ),
      ),
    ));
  }
}

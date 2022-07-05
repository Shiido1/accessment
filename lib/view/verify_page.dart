import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:glades/view/provider/provider.dart';
import 'package:provider/provider.dart';

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
            const SizedBox(
              height: 30,
            ),
            const Text(
              'VERIFY ACCOUNT NAME',
              style: TextStyle(
                  color: Color.fromARGB(255, 11, 8, 163),
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 57,
              child: TextFormField(
                readOnly: true,
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
            const SizedBox(
              height: 50,
            ),
            Visibility(
              visible: providerMainClass?.isShow == true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 5,
                    color: const Color.fromARGB(255, 226, 228, 247),
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(16.0, 12.0, 0, 8),
                        margin: const EdgeInsets.only(
                            left: 16.0, right: 8.0, top: 20, bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          'Hello ${providerMainClass?.verifyResponse["data"]["account_name"]} you have successfully verified you account name, you can now make a single transfer',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Make A Single Payment Transaction',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 57,
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        suffixIconColor: const Color.fromARGB(255, 11, 8, 163),
                        label: const Text('Name of Recipient'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 57,
                    child: TextFormField(
                      controller: amountController,
                      decoration: InputDecoration(
                        suffixIconColor: const Color.fromARGB(255, 11, 8, 163),
                        label: const Text('Amount'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 57,
                    child: TextFormField(
                      controller: narrationController,
                      decoration: InputDecoration(
                        suffixIconColor: const Color.fromARGB(255, 11, 8, 163),
                        label: const Text('Narration'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 57,
                    child: TextFormField(
                      controller: orderRefController,
                      decoration: InputDecoration(
                        suffixIconColor: const Color.fromARGB(255, 11, 8, 163),
                        label: const Text(
                            'Order of Referrence should be in (TX00001) e.g, Format'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: ElevatedButton(
                        onPressed: () {
                          providerMainClass?.singleTransfer(
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
                                'MAKE SINGLE TRANSFER',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}

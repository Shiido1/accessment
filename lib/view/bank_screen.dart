import 'package:flutter/material.dart';
import 'package:glades/view/provider/model/global.model.dart';
import 'package:glades/view/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../core/validator.dart';

class BankScreen extends StatefulWidget {
  const BankScreen({Key? key}) : super(key: key);

  @override
  State<BankScreen> createState() => _BankScreenState();
}

class _BankScreenState extends State<BankScreen> {
  final _editController = TextEditingController();
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Select Your Bank",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 11, 8, 163),
        ),
        body: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            children: [
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                height: 10.h,
                child: TextFormField(
                  controller: _editController,
                  validator: Validators.validateString(),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (v) {
                    setState(() => _query = v);
                  },
                  decoration: InputDecoration(
                    suffixIconColor: const Color.fromARGB(255, 11, 8, 163),
                    label: const Text('Search bank'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Consumer<ProviderMainClass>(
                  builder: (_, provider, __) {
                    if (provider.listValue.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                        itemCount: provider.listKey.length,
                        itemBuilder: (context, index) {
                          return _query.isEmpty ||
                                  provider.listValue[index]
                                      .toString()
                                      .toLowerCase()
                                      .contains(_query.toLowerCase())
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, right: 12.0, top: 4),
                                  child: Card(
                                    elevation: 5,
                                    color: const Color.fromARGB(
                                        255, 226, 228, 247),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          16.0, 12.0, 0, 8),
                                      margin: EdgeInsets.only(
                                          left: 4.w,
                                          right: 4.w,
                                          top: 5.w,
                                          bottom: 5.w),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            bankController.text =
                                                provider.listValue[index];
                                            bankKey = provider.listKey[index];
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          provider.listValue[index],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.5.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container();
                        });
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

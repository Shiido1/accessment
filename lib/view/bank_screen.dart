import 'package:flutter/material.dart';
import 'package:glades/view/provider/model/global.model.dart';
import 'package:glades/view/provider/provider.dart';
import 'package:provider/provider.dart';

class BankScreen extends StatefulWidget {
  const BankScreen({Key? key}) : super(key: key);

  @override
  State<BankScreen> createState() => _BankScreenState();
}

class _BankScreenState extends State<BankScreen> {
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
        body: Consumer<ProviderMainClass>(
          builder: (_, provider, __) {
            if (provider.listValue.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                itemCount: provider.listKey.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 12.0, right: 12.0, top: 4),
                    child: Card(
                      elevation: 5,
                      color: const Color.fromARGB(255, 226, 228, 247),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(16.0, 12.0, 0, 8),
                        margin: const EdgeInsets.only(
                            left: 16.0, right: 8.0, top: 20, bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            // print(provider.listKey[index]);
                            setState(() {
                              bankController.text = provider.listValue[index];
                              bankKey = provider.listKey[index];
                            });
                            // provider.verify(verifyNameController.text);
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            provider.listValue[index],
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          },
        ));
  }
}

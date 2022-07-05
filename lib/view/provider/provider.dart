import 'package:flutter/material.dart';
import 'package:glades/core/network/api_error.dart';
import 'package:glades/view/provider/model/global.model.dart';
import 'package:glades/view/provider/repo.dart';
import 'package:glades/view/verify_page.dart';

class ProviderMainClass with ChangeNotifier {
  final Repository repository;
  dynamic valueList;
  final List _listKey = [];
  List get listKey => _listKey;
  final List _listValue = [];
  List get listValue => _listValue;
  bool _isShow = false;
  // bool _isLoading = false;

  // bool get isLoading => _isLoading;
  bool get isShow => _isShow;

  var verifyResponse;
  var singleTransferResponse;

  ProviderMainClass(this.repository);

  implSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: (Colors.black12),
      action: SnackBarAction(
        label: 'dismiss',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> inquire({context, String? inquire}) async {
    Map inquireMap = {"inquire": inquire};
    try {
      valueList = await repository.inquireBank(inquireMap);

      valueList.forEach((k, v) {
        _listKey.add(k);
        _listValue.add(v);
      });
      implSnackBar(context, 'Welcome please select bank');
      notifyListeners();
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> verify(BuildContext context, String inquireName) async {
    Map inquireMap = {
      "inquire": inquireName,
      "accountnumber": "0040000009",
      "bankcode": bankKey
    };
    try {
      // _isLoading = true;
      notifyListeners();
      verifyResponse = await repository.verify(inquireMap);
      if (verifyResponse["status"] == "success") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const VerifyPage()),
        );
        _isShow = true;
        // _isLoading = false;
      } else {
        print('print response here $verifyResponse["message"]');
        // _isLoading = false;
        implSnackBar(context, verifyResponse["message"]);
        notifyListeners();
      }
      notifyListeners();
      logger.d(verifyResponse);
    } catch (e) {
      throw (e.toString());
    }
    notifyListeners();
  }

  Future<void> singleTransfer(
      {context,
      String? name,
      String? amount,
      String? narration,
      String? orderRef}) async {
    Map inquireMap = {
      "action": "transfer",
      "amount": "$amount",
      "bankcode": "$bankKey",
      "accountnumber": "0040000009",
      "sender_name": "$name",
      "narration": "$narration",
      "orderRef": "$orderRef"
    };
    try {
      // _isLoading = true;
      notifyListeners();
      singleTransferResponse = await repository.singleTransfer(inquireMap);
      if (singleTransferResponse["status"] == 200) {
        implSnackBar(context, singleTransferResponse["message"]);
        _isShow = true;
        // _isLoading = false;
      } else {
        implSnackBar(context, singleTransferResponse["message"]);
        notifyListeners();
      }
      // _isLoading = false;
      notifyListeners();
    } catch (e) {
      throw (e.toString());
    }
    notifyListeners();
  }
}

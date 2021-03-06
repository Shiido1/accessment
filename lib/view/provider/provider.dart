import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:glades/view/home_page.dart';
import 'package:glades/view/provider/model/global.model.dart';
import 'package:glades/view/provider/repo.dart';
import 'package:glades/view/verify_page.dart';

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

class ProviderMainClass with ChangeNotifier {
  final Repository repository;
  dynamic valueList;
  final List _listKey = [];
  List get listKey => _listKey;
  final List _listValue = [];
  List get listValue => _listValue;
  bool _isShow = false;
  bool _isVerifyShow = false;
  bool _isSingleShow = false;
  bool _isLoading = false;
  bool _isVerifyLoading = false;
  bool _isSingleLoading = false;

  bool get isLoading => _isLoading;
  bool get isVerifyLoading => _isVerifyLoading;
  bool get isSingleLoading => _isSingleLoading;
  bool get isShow => _isShow;
  bool get isSingleShow => _isSingleShow;
  bool get isVerifyShow => _isVerifyShow;

  var verifyResponse;
  var singleTransferResponse;
  var verifyTransferResponse;

  ProviderMainClass(this.repository);

  Future<void> inquire({context, String? inquire}) async {
    Map inquireMap = {"inquire": inquire};
    try {
      valueList = await repository.inquireBank(inquireMap);

      valueList.forEach((k, v) {
        _listKey.add(k);
        _listValue.add(v);
      });
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
      _isLoading = true;
      notifyListeners();
      verifyResponse = await repository.verify(inquireMap);
      if (verifyResponse["status"] == "success") {
        _isShow = true;
        notifyListeners();
        _isLoading = false;
        notifyListeners();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const VerifyPage()),
        );
        notifyListeners();
      } else {
        _isLoading = false;
        implSnackBar(context, 'Please select bank and try again later');
      }
    } catch (e) {
      implSnackBar(context, e.toString());
      _isLoading = false;
      notifyListeners();
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
      _isSingleLoading = true;
      notifyListeners();
      singleTransferResponse = await repository.singleTransfer(inquireMap);
      if (singleTransferResponse["status"] == 200) {
        _isSingleShow = true;
        notifyListeners();
        _isSingleLoading = false;
        notifyListeners();
        implSnackBar(context, singleTransferResponse["message"]);
        notifyListeners();
      } else {
        implSnackBar(context, singleTransferResponse["message"]);
        notifyListeners();
      }
      _isSingleLoading = false;
      notifyListeners();
    } catch (e) {
      _isSingleLoading = false;
      implSnackBar(context, e.toString());
      notifyListeners();
      throw (e.toString());
    }
    notifyListeners();
  }

  Future<void> verifyTransfer({context, String? orderRef}) async {
    Map inquireMap = {"action": "verify", "txnRef": "$orderRef"};
    try {
      _isVerifyLoading = true;
      notifyListeners();
      verifyTransferResponse = await repository.singleTransfer(inquireMap);
      if (verifyTransferResponse["status"] == 200) {
        _isVerifyShow = true;
        notifyListeners();
        _isVerifyLoading = false;
        notifyListeners();
        implSnackBar(context, verifyTransferResponse["message"]);
        notifyListeners();
      } else {
        implSnackBar(context, verifyTransferResponse["message"]);
        notifyListeners();
      }
      _isVerifyLoading = false;
      notifyListeners();
    } catch (e) {
      implSnackBar(context, e.toString());
      notifyListeners();
      throw (e.toString());
    }
    notifyListeners();
  }
}

class LoginProvider with ChangeNotifier {
  final LoginRepo loginRepo;
  bool isLogin = false;

  LoginProvider(this.loginRepo);

  Future<Response?> login({context, String? email, String? password}) async {
    Map login = {"email": email, "password": password};
    Response res;
    try {
      isLogin = true;
      notifyListeners();
      res = await loginRepo.login(login);
      if (res.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        isLogin = false;
        implSnackBar(context, 'Welcome please select bank');
        notifyListeners();
      }
    } catch (e) {
      isLogin = false;
      implSnackBar(context, e.toString());
      notifyListeners();
      rethrow;
    }
    notifyListeners();
    return res;
  }
}

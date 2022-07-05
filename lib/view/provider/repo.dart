import 'package:dio/dio.dart';
import 'package:glades/core/network/network_service.dart';

import '../../core/network/url_config.dart';

class Repository {
  final NetworkService _networkService;

  Repository({required NetworkService networkService})
      : _networkService = networkService;

  inquireBank(Map inquireEntity) async {
    try {
      print('object');
      Response response = await _networkService
          .call(UrlConfig.inquire, RequestMethod.put, data: inquireEntity);
      print("i fill $response");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  verify(Map inquireEntity) async {
    try {
      print('object');
      Response response = await _networkService
          .call(UrlConfig.inquire, RequestMethod.put, data: inquireEntity);
      print("i fill very $response");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  singleTransfer(Map inquireEntity) async {
    try {
      print('object');
      Response response = await _networkService
          .call(UrlConfig.disburse, RequestMethod.put, data: inquireEntity);
      print("i fill not $response");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}

class LoginRepo {
  final NetworkLoginService _networkLoginService;

  LoginRepo({ required NetworkLoginService networkLoginService}):_networkLoginService = networkLoginService;

  Future<Response>login(Map inquireEntity) async {
    try {
      print('object');
      Response response = await _networkLoginService
          .call(UrlConfig.login, RequestLoginMethod.post, data: inquireEntity);
      print("i fill not $response");
      return response;
    } catch (e) {
      rethrow;
    }
  }
  
}

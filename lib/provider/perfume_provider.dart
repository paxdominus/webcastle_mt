import 'package:flutter/material.dart';
import 'package:webcastle_mt/api/api_service.dart';
import 'package:webcastle_mt/model/perfume_model.dart';

class PerfumeProvider extends ChangeNotifier {
  PerfumeProvider._privateConstructor();
  static final PerfumeProvider _instance =
      PerfumeProvider._privateConstructor();

  factory PerfumeProvider() => _instance;

  PerfumeModel? perfumeModel;

  void getPerfumeModel() async {
    final loginRes = await ApiService().post(
      endpoint: '/anonymous-login',
      params: {"device_token": "test_token", "device_type": "1"},
    );

    ApiService().token = loginRes["data"]["access_token"];
    final res = await ApiService().get(endpoint: '/home');
    perfumeModel = PerfumeModel.fromJson(res);
    notifyListeners();
  }
}

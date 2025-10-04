import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fit_finder/models/personal_model.dart';
import 'package:flutter/material.dart';

class PersonalRepository extends ChangeNotifier {
  Dio _dio;

  PersonalRepository({required Dio dio}) : _dio = dio;

  Dio get dio => _dio;

  set dio(Dio nDio) {
    _dio = nDio;
    notifyListeners();
  }

  Future<List<PersonalModel>> getPersonal() async {
    try {
      final result = await _dio.get('/personal');
      return (result.data as List)
          .map<PersonalModel>((personal) => PersonalModel.fromMap(personal))
          .toList();
    } on DioException catch (e, s) {
      log('Erro ao carregar personals: $e', stackTrace: s);
      throw Exception(
        'Não foi possível carregar os personals. Tente novamente mais tarde.',
      );
    } catch (e, s) {
      log('Erro inesperado: $e', stackTrace: s);
      throw Exception(
        'Não foi possível carregar os personals. Tente novamente mais tarde.',
      );
    }
  }
}

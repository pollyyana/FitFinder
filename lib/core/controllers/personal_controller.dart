import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fit_finder/core/repositories/personal_repository.dart';
import 'package:flutter/material.dart';

import '../../models/personal_model.dart';

class PersonalController extends ChangeNotifier {
  final PersonalRepository repository;

  PersonalController({required this.repository});

  List<PersonalModel> personals = [];
  bool isLoading = false;
  String errorMessage = '';

  Future<void> getPersonal() async {
    try {
      isLoading = true;
      errorMessage = '';
      notifyListeners();

      personals = await repository.getPersonal();
    } catch (e, s) {
      log('Erro ao buscar personals: $e', stackTrace: s);
      errorMessage =
          'Não foi possível carregar os personals. Tente novamente mais tarde.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addPersonal(PersonalModel personal) async {
    try {
      isLoading = true;
      notifyListeners();

      // Remove o ID do payload para deixar o servidor gerar automaticamente
      final personalData = personal.toMap();
      personalData.remove('id');

      final response = await repository.dio.post(
        '/personal',
        data: jsonEncode(personalData), // <- aqui converte para JSON
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      personals.add(PersonalModel.fromMap(response.data));
    } catch (e, s) {
      log('Erro ao adicionar personal: $e', stackTrace: s);

      if (e is DioException && e.response != null) {
        errorMessage =
            'Erro ao adicionar personal: ${e.response?.statusCode} - ${e.response?.data}';
      } else {
        errorMessage =
            'Não foi possível adicionar o personal. Tente novamente mais tarde.';
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updatePersonal(PersonalModel personal) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await repository.dio.put(
        '/personal/${personal.id}',
        data: personal.toMap(),
      );

      final index = personals.indexWhere((p) => p.id == personal.id);
      if (index != -1) {
        personals[index] = PersonalModel.fromMap(response.data);
      }
    } catch (e, s) {
      log('Erro ao atualizar personal: $e', stackTrace: s);
      errorMessage =
          'Não foi possível atualizar o personal. Tente novamente mais tarde.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deletePersonal(String id) async {
    try {
      isLoading = true;
      notifyListeners();

      await repository.dio.delete('/personal/$id');
      personals.removeWhere((p) => p.id == id);
    } catch (e, s) {
      log('Erro ao deletar personal: $e', stackTrace: s);
      errorMessage =
          'Não foi possível deletar o personal. Tente novamente mais tarde.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

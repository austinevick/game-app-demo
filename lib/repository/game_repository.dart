import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_app/model/add_booking_model.dart';
import 'package:game_app/model/direct_and_permutation_game_model.dart';
import 'package:game_app/model/game_detail_model.dart';
import 'package:game_app/model/game_type_response_model.dart';
import 'package:game_app/model/players_model.dart';
import 'package:game_app/network/dio_client.dart';
import 'package:game_app/network/http_client.dart';
import 'package:game_app/storage/storage_provider.dart';

import '../model/login_model.dart';
import '../network/api.dart';

final gameRepository = Provider((ref) => GameRepository());

class GameRepository {
  Future<LoginResponseModel> login(LoginModel model) async {
    final response =
        await HttpClient.postRequest("${baseUrl}vendor/login", model.toJson());
    final json = jsonDecode(response.body);
    return LoginResponseModel.fromJson(json);
  }

  Future<GameListResponseModel> getGameList() async {
    final token = await StorageProvider.getUserToken();
    final response = await HttpClient.postRequest(
        "${baseUrl}customer/game_list", [],
        token: token);
    final json = jsonDecode(response.body);
    return GameListResponseModel.fromJson(json);
  }

  Future<PlayersResponseModel> getPlayersList() async {
    final token = await StorageProvider.getUserToken();
    final response = await HttpClient.postRequest(
        "${baseUrl}vendor/player_list", [],
        token: token);
    final json = jsonDecode(response.body);
    return PlayersResponseModel.fromJson(json);
  }

  Future<GamedetailResponseModel> getGameDetails(GamedetailModel model) async {
    final response = await HttpClient.postRequest(
        "${baseUrl}vendor/game_detail", jsonEncode(model.toMap()),
        headers: HttpClient.customHeader);
    final json = jsonDecode(response.body);
    print(json);
    return GamedetailResponseModel.fromJson(json);
  }

  Future<DirectAndPermutationGameResponseModel>
      getDirectAndPermutationGameTypes() async {
    final response =
        await HttpClient.postRequest("${baseUrl}vendor_pos/pos_game_types", []);
    final json = jsonDecode(response.body);
    return DirectAndPermutationGameResponseModel.fromJson(json);
  }

  Future<DirectAndPermutationGameResponseModel>
      getDirectAndPermutationGames() async {
    final response =
        await HttpClient.getRequest("${baseUrl}vendor_pos/pos_game_types");
    final json = jsonDecode(response.body);
    return DirectAndPermutationGameResponseModel.fromJson(json);
  }

  Future<AddBookingResponseModel> bookingGame(String model) async {
    final response =
        await DioClient.postRequest("${baseUrl}vendor/add_booking", model);
    final responseModel = addBookingResponseModelFromJson(response.toString());

    return responseModel;
  }
}

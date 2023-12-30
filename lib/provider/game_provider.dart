import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_app/model/add_booking_model.dart';
import 'package:game_app/model/game_detail_model.dart';
import 'package:game_app/model/game_type_response_model.dart';
import 'package:game_app/screen/tickets/pick_tickets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../common/utils.dart';
import '../model/direct_and_permutation_game_model.dart';
import '../model/login_model.dart';
import '../model/players_model.dart';
import '../network/http_handler.dart';
import '../repository/game_repository.dart';
import '../storage/storage_provider.dart';
import 'game_bloc_provider.dart';

final directAndPermutationGameProvider = FutureProvider(
    (ref) => ref.watch(gameProvider).getDirectAndPermutationGames());

final playersListProvider =
    FutureProvider((ref) => ref.watch(gameProvider).getPlayersList());

final gameTypeProvider =
    FutureProvider((ref) => ref.watch(gameProvider).getGameList());

final gameProvider = ChangeNotifierProvider((ref) => GameProvider(ref));

class GameProvider extends ChangeNotifier {
  final Ref ref;
  GameProvider(this.ref);

  List<PlayersResponseData> searchedPlayersList = [];

  final amountPerTickerCtrl = TextEditingController();
  final searchPlayersCtrl = TextEditingController();
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  void updateUI() {
    notifyListeners();
  }

  void onPlayersListSearch() async {
    final playersList = await getPlayersList();
    notifyListeners();
    searchedPlayersList = playersList
        .where((element) =>
            element.accountNumber!
                .contains(searchPlayersCtrl.text.toLowerCase()) ||
            element.username!
                .toLowerCase()
                .contains(searchPlayersCtrl.text.toLowerCase()))
        .toList();
    notifyListeners();
  }

  List<Map<String, dynamic>> ticketData = [];

  Future<void> addAllTicketData(List<GamedetailResponseData>? gameList) async {
    for (int i = 0; i < (gameList?.length ?? 0); i++) {
      String amount;
      amount = gameList?[i].amount != ''
          ? (gameList?[i].amount ?? '')
          : (gameList?[i].minAmount ?? '');

      ticketData.add(
        {
          'game_id': gameList?[i].id,
          'amount_per_ticket': amount,
          'no_of_tickets': gameList?[i].selectedNoOfTicket
        },
      );
    }
  }

////////====================API Call=======================////////

  Future<LoginResponseModel> login() async {
    final model = LoginModel(
        username: usernameCtrl.text.trim(), password: passwordCtrl.text.trim());
    final response = await runcallWithDialog<LoginResponseModel>(
        ref.read(gameRepository).login(model));
    print(response.status);
    if (response.status == 200) {
      StorageProvider.saveUserToken(response.data!.token!);
      StorageProvider.saveUserId(response.data!.id.toString());
    } else {
      customSnackBar(response.message);
      pop();
    }
    return response;
  }

  Future<void> getGameDetailsById() async {
    final gameIds =
        ref.read(gameBlocProvider).selectedGames.map((e) => e).toList();
    final model = GamedetailModel(gameId: gameIds);
    await getGameDetails(model)
        .then((gameDetails) => showMaterialModalBottomSheet(
              enableDrag: false,
              context: navigatorkey.currentContext!,
              builder: (ctx) => PickTickets(gameDetails: gameDetails),
            ));
  }

  Future<List<GameListResponseData>> getGameList() async {
    final response = await ref.read(gameRepository).getGameList();
    return response.data;
  }

  Future<List<PlayersResponseData>> getPlayersList() async {
    final response = await ref.read(gameRepository).getPlayersList();
    return response.data;
  }

  Future<List<GamedetailResponseData>> getGameDetails(
      GamedetailModel model) async {
    final response = await runcallWithDialog<GamedetailResponseModel>(
        ref.read(gameRepository).getGameDetails(model));
    pop();
    return response.data;
  }

  Future<List<DirectAndPermutationGameResponseData>>
      getDirectAndPermutationGames() async {
    final response =
        await ref.read(gameRepository).getDirectAndPermutationGames();
    return response.data;
  }

  Future<AddBookingResponseModel> bookingGameApi(
      List<Map<String, dynamic>> data) async {
    final requestModel = AddBookingRequestModel(data: data);
    String request = addBookingRequestModelToJson(requestModel);
    print(request);
    final response = await ref.read(gameRepository).bookingGame(request);
    return response;
  }
}

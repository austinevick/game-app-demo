import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameBlocProvider = ChangeNotifierProvider((ref) => GameBlocProvider());

class GameBlocProvider extends ChangeNotifier {
  List<int> selectedGames = [];

  void addAndRemoveGames(int list) {
    if (selectedGames.contains(list)) {
      selectedGames.remove(list);
    } else {
      selectedGames.add(list);
    }
    notifyListeners();
  }

  void clearSelectedGames() {
    selectedGames = [];
    notifyListeners();
  }
}

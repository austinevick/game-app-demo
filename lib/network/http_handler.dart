import 'dart:async';
import 'dart:io';

import 'package:game_app/common/utils.dart';

import 'api.dart';

Future<T> runcallWithDialog<T>(Future<dynamic> data) async {
  try {
    loadingDialog();
    return await data;
  } on TimeoutException {
    customSnackBar(timeout);
    pop();
    rethrow;
  } on SocketException catch (_) {
    customSnackBar(noConnection);
    pop();
    rethrow;
  } on HandshakeException catch (_) {
    customSnackBar(somethingwentwrong);
    pop();
    rethrow;
  } catch (e) {
    customSnackBar(somethingwentwrong);
    pop();
    rethrow;
  }
}

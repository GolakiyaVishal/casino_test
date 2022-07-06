import 'package:casino_test/src/data/character_model.dart';
import 'package:casino_test/src/data/my_client.dart';
import 'package:casino_test/src/utils/internet_connection.dart';
import 'package:flutter/material.dart';

enum ApiState { init, loading, completed, error, loadMore, noInternet }

class HomeProvider extends ChangeNotifier {
  ApiState apiState = ApiState.init;

  CharacterResp? characterResp;
  List<Character> characterList = [];
  MyClient myClient = MyClient();

  void getNextCharacters() {
    getCharacters(nextUrl: characterResp?.info?.next);
  }

  void getCharacters({String? nextUrl}) {
    if(apiState == ApiState.loading || apiState == ApiState.loadMore){
      return;
    }

    if(nextUrl == null) {
      apiState = ApiState.loading;
    } else {
      apiState = ApiState.loadMore;
      notifyListeners();
    }

    myClient.getAllCharacters(nextUrl: nextUrl).then((value) {
      if (value != null) {
        characterResp = value;
        if (value.characterList?.isNotEmpty ?? true) {
          apiState = ApiState.completed;
          characterList.addAll(value.characterList!);
        }
      } else {
        apiState = ApiState.error;
      }

      notifyListeners();
    });
  }

  void checkForInternetConnection(BuildContext context) {
    InternetConnection.check(context).then((value){
      if(value){
        if (apiState == ApiState.init) {
          getCharacters();
        }
      } else {
        apiState = ApiState.noInternet;
        notifyListeners();
      }
    });
  }
}

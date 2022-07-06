import 'dart:convert';
import 'dart:developer';

import 'package:casino_test/src/utils/internet_connection.dart';
import 'package:http/http.dart' as http;
import 'package:casino_test/src/data/character_model.dart';

class MyClient {
  final String _firstUrl = 'https://rickandmortyapi.com/api/character/?page=1';

  final Map<String, CharacterResp> _cache = {};

  Future<CharacterResp?> getAllCharacters({String? nextUrl}) async {

    final url = nextUrl??_firstUrl;

    if(_cache.containsKey(url)){
      return _cache[url];
    }

    http.Client client = http.Client();

    final response = await client.get(Uri.parse(url));

    client.close();

    if(200 == response.statusCode ) {
      // log('getAllCharacters :: ${response.body}');
      log('getAllCharacters :: $url');
      final resp =  CharacterResp.fromJson(jsonDecode(response.body));
      _cache[url] = resp;
      return resp;

    } else {
      log('getAllCharacters :: error');
      return null;
    }
  }
}
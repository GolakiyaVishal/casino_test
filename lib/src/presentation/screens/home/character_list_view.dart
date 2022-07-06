import 'package:casino_test/src/data/character_model.dart';
import 'package:casino_test/src/presentation/screens/info/info_screen.dart';
import 'package:casino_test/src/presentation/widgets/character_tile.dart';
import 'package:flutter/material.dart';

class CharacterListView extends StatelessWidget {
  final List<Character> characters;

  const CharacterListView({Key? key, required this.characters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          final Character character = characters[index];
          return CharacterTile(character: character, onTap: (){
            Navigator.pushNamed(context, InfoScreen.route, arguments: character);
          },);
        },
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: characters.length);
  }
}

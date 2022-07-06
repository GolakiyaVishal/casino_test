import 'package:casino_test/src/data/character_model.dart';
import 'package:flutter/material.dart';

class CharacterTile extends StatelessWidget {
  const CharacterTile({Key? key, required this.character, required this.onTap}) : super(key: key);

  final Character character;
  final Function onTap;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            Text('${character.id}',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 20)),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    character.image ?? 'https://via.placeholder.com/150'),
                backgroundColor: Colors.transparent,
              ),
            ),

            Expanded(child: Text(character.name ?? 'Character Name')),
          ],
        ),
      ),
    );
  }
}

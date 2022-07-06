import 'package:casino_test/src/data/character_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  static const String route = '/infoScreen';

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late Character character;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    character = ModalRoute.of(context)!.settings.arguments as Character;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Detail')),
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        character.image ?? 'https://via.placeholder.com/150'),
                  ),
                ),
                Expanded(
                    child: Text(
                  character.name ?? 'Name',
                  style: Theme.of(context).textTheme.titleLarge,
                )),
              ],
            ),
            //
            if (character.status?.isNotEmpty ?? false)
              labelTile('Status', character.status!),
            //
            if (character.type?.isNotEmpty ?? false)
              labelTile('Type', character.type!),
            //
            if (character.origin != null)
              labelTile('Type', character.origin!.name!),
            //
            if (character.gender?.isNotEmpty ?? false)
              labelTile('Gender', character.gender ?? 'NA'),
            //
            if (character.location != null)
              labelTile('Type', character.location!.name ?? 'NA'),
            //
            if (character.episode?.isNotEmpty ?? false)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Episodes:  ',
                        style: Theme.of(context).textTheme.labelLarge),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: character.episode?.length ?? 0,
                        itemBuilder: (context, index) {
                          final url = character.episode![index];
                          return InkWell(
                              onTap: () async {
                                if (await canLaunchUrl(Uri.parse(url))) {
                                  launchUrl(Uri.parse(url));
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'episode: ${url.split('episode/')[1]}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          decoration: TextDecoration.underline),
                                ),
                              ));
                        }),
                  ],
                ),
              ),
          ],
        ));
  }

  Widget labelTile(String label, String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label:  ', style: Theme.of(context).textTheme.labelLarge),
          Expanded(child: Text(data))
        ],
      ),
    );
  }
}

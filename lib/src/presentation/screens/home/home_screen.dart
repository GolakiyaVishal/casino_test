import 'package:casino_test/src/presentation/screens/home/character_list_view.dart';
import 'package:casino_test/src/presentation/screens/home/home_provider.dart';
import 'package:casino_test/src/utils/internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;
  static const String route = '/homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<HomeProvider>().
    checkForInternetConnection(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    if (context.watch<HomeProvider>().apiState == ApiState.loading ||
        context.watch<HomeProvider>().apiState == ApiState.init) {
      return const Center(child: Text('Loading data'));
    }

    if (context.watch<HomeProvider>().apiState == ApiState.error) {
      return const Center(child: Text('Error loading data'));
    }

    if (context.watch<HomeProvider>().apiState == ApiState.noInternet) {
      return const Center(child:
      Text('No Internet connection,\nPlease check and restart app',
        textAlign: TextAlign.center,));
    }

    if (context.watch<HomeProvider>().apiState == ApiState.completed ||
        context.watch<HomeProvider>().apiState == ApiState.loadMore) {
      return Column(
        children: [

          // character list view
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if(scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent) {
                  context.read<HomeProvider>().getNextCharacters();
                  return true;
                } else {
                  return false;
                }
              },
              child: CharacterListView(
                  characters: context.watch<HomeProvider>().characterList),
            ),
          ),

          // load more indicator
          if (context.watch<HomeProvider>().apiState == ApiState.loadMore)
            const Padding(
                padding: EdgeInsets.all(20),
                child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2))),
        ],
      );
    }

    return const SizedBox();
  }
}

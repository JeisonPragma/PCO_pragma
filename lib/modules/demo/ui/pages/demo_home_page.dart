import 'package:flutter/material.dart';

import '../../../../app_config.dart';
import '../../../../blocs/bloc_user_notifications.dart';
import '../../../../ui/widgets/forms/custom_autocomplete_input_widget.dart';
import '../../../../ui/widgets/responsive/my_app_scaffold_widget.dart';
import '../../../cat/blocs/cat_bloc.dart';
import '../../../cat/blocs/cat_state.dart';
import '../../../cat/ui/widgets/cat_list_widget.dart';
import '../../../cat/ui/widgets/url_list_widget.dart';
import '../../blocs/bloc_demo.dart';

class DemoHomePage extends StatefulWidget {
  const DemoHomePage({
    required this.blocDemo,
    super.key,
    this.isTesting = false,
  });
  final BlocDemo blocDemo;
  final bool isTesting;

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  late CatBloc catBloc;
  List<String> nameCatsList = [''];

  String urlToClean = '';

  @override
  void initState() {
    catBloc = blocCore.getBlocModule<CatBloc>(CatBloc.name);

    //WidgetsBinding.instance.addPostFrameCallback((_) async => _loadCats());
    super.initState();
  }

  Future<void> _loadCats() async {
    try {
      await catBloc.getCats();
    } catch (e) {
      blocCore
          .getBlocModule<UserNotificationsBloc>(UserNotificationsBloc.name)
          .showSnackBar(
            context,
            SnackBar(
              content: Text(e.toString()),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Widget content = SizedBox(
      height: size.height,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.1,
                  width: size.width * 0.8,
                  child: CustomAutoCompleteInputWidget(
                    onEditingValueFunction: (value) {
                      urlToClean = value;
                    },
                    icondata: Icons.pets,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.cut),
                  color: Colors.blue,
                  onPressed: () => catBloc.postCleanUrl(urlToClean: urlToClean),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).dialogBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: StreamBuilder<CatsState>(
                stream: catBloc.stateStream,
                builder:
                    (BuildContext context, AsyncSnapshot<CatsState> snapshot) {
                  if (snapshot.data?.isLoading ?? true) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData && snapshot.error != null) {
                    return const Text('Sorry, no pudimos convertir esta URL');
                  }
                  nameCatsList = snapshot.data!.catsNames;
                  return UrlListWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
    if (widget.isTesting) {
      return Scaffold(
        body: content,
      );
    }
    return MyAppScaffold(
      child: content,
    );
  }
}

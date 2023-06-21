import 'package:flutter/material.dart';

import '../../../../app_config.dart';
import '../../../../blocs/bloc_user_notifications.dart';
import '../../../../models/cat_model.dart';
import '../../blocs/cat_bloc.dart';
import '../../blocs/cat_state.dart';

class DetailCatPage extends StatefulWidget {
  const DetailCatPage({required this.catModel, super.key});
  final CatModel catModel;
  static const name = 'DetailCatPage';

  @override
  State<DetailCatPage> createState() => _DetailCatPageState();
}

class _DetailCatPageState extends State<DetailCatPage> {
  late CatBloc catBloc;

  @override
  void initState() {
    catBloc = blocCore.getBlocModule<CatBloc>(CatBloc.name);

    WidgetsBinding.instance.addPostFrameCallback((_) async => _loadImage());
    super.initState();
  }

  Future<void> _loadImage() async {
    try {
      await catBloc.searchCatImage(id: widget.catModel.referenceImage ?? '');
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
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.catModel.name ?? 'Raza Unknown'),
        ),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: StreamBuilder<CatsState>(
              stream: catBloc.stateStream,
              builder:
                  (BuildContext context, AsyncSnapshot<CatsState> snapshot) {
                if (snapshot.data?.isLoading ?? true) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData && snapshot.error != null) {
                  return const Offstage();
                }
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      if (snapshot.data?.urlImage != '')
                        Image.network(snapshot.data?.urlImage ?? ''),
                      if (snapshot.data!.urlImage == '')
                        Icon(
                          Icons.pets,
                          color: Colors.deepOrange,
                          size: size.width * 0.5,
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            Text(widget.catModel.name ?? ''),
                            Text(widget.catModel.altNames ?? ''),
                            Text(widget.catModel.cfaUrl ?? ''),
                            Text(widget.catModel.description ?? ''),
                            Text(widget.catModel.id ?? ''),
                            const SizedBox(
                              height: 40,
                            ),
                            Text(widget.catModel.name ?? ''),
                            Text(widget.catModel.altNames ?? ''),
                            Text(widget.catModel.cfaUrl ?? ''),
                            Text(widget.catModel.description ?? ''),
                            Text(widget.catModel.id ?? ''),
                            const SizedBox(
                              height: 40,
                            ),
                            Text(widget.catModel.name ?? ''),
                            Text(widget.catModel.altNames ?? ''),
                            Text(widget.catModel.cfaUrl ?? ''),
                            Text(widget.catModel.description ?? ''),
                            Text(widget.catModel.id ?? ''),
                            const SizedBox(
                              height: 40,
                            ),
                            Text(widget.catModel.name ?? ''),
                            Text(widget.catModel.altNames ?? ''),
                            Text(widget.catModel.cfaUrl ?? ''),
                            Text(widget.catModel.description ?? ''),
                            Text(widget.catModel.id ?? ''),
                            const SizedBox(
                              height: 40,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ));
  }
}

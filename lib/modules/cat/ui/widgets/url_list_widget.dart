import 'package:flutter/material.dart';

import '../../../../app_config.dart';
import '../../blocs/cat_bloc.dart';

class UrlListWidget extends StatelessWidget {
  UrlListWidget({super.key});

  CatBloc catBloc = blocCore.getBlocModule<CatBloc>(CatBloc.name);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.6,
      width: size.width * 0.8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
        child: ListView.builder(itemBuilder: (context, index){
          return Text(catBloc.urlCleaneds[index]);
        },
          itemCount: catBloc.urlCleaneds.length,),
      ),
    );
  }
}

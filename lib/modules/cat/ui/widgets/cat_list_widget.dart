import 'package:flutter/material.dart';
import '../../../../app_config.dart';
import '../../../../models/cat_model.dart';
import '../../../../ui/widgets/forms/custom_autocomplete_input_widget.dart';
import '../../blocs/cat_bloc.dart';
import 'cat_item_list_widget.dart';

class CatListWidget extends StatefulWidget {
  const CatListWidget(
      {required this.catModelList, required this.nameCatsList, super.key});

  final List<CatModel> catModelList;
  final List<String> nameCatsList;

  @override
  State<CatListWidget> createState() => _CatListWidgetState();
}

class _CatListWidgetState extends State<CatListWidget> {
  CatBloc catBloc = blocCore.getBlocModule<CatBloc>(CatBloc.name);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return widget.catModelList.isEmpty
        ? const Text('No hay lista para mostrar')
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomAutoCompleteInputWidget(
                  onEditingValueFunction: (value) {
                    catBloc.filterCats(nameSearch: value);
                  },
                  icondata: Icons.pets,
                  suggestList: widget.nameCatsList,
                ),
              ),
              SizedBox(
                height: size.height * 0.7,
                width: size.width,
                child: ListView.builder(
                  itemCount: widget.catModelList.length,
                  itemBuilder: (BuildContext context, int item) {
                    final CatModel cat = widget.catModelList[item];
                    return CatItemListWidget(catModel: cat);
                  },
                ),
              ),
            ],
          );
  }
}

import 'package:flutter/material.dart';
import '../../../../entities/entity_bloc.dart';
import '../../../../models/cat_model.dart';
import '../pages/detail_cat_page.dart';

class CatItemListWidget extends StatelessWidget {
  CatItemListWidget({required this.catModel, super.key});

  final CatModel catModel;
  final BlocCore<dynamic> blocCore = BlocCore<dynamic>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => DetailCatPage(
                    catModel: catModel,
                  )),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(1),
        width: size.width * 0.9,
        height: size.width * 0.9,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          width: size.width * 0.9,
          height: size.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(catModel.name ?? ''),
                  Text('Más...'),
                ],
              ),
              Icon(
                Icons.pets,
                size: size.width * 0.6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(catModel.countryCode ?? ''),
                  Text('Imágenes'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

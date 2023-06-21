import 'dart:async';
import '../../../entities/entity_bloc.dart';
import '../../../models/cat_image_model.dart';
import '../../../models/cat_model.dart';
import '../../../services/cat_service.dart';
import 'cat_state.dart';

class CatBloc extends BlocModule {
  CatBloc({required CatService catService}) : _catService = catService;
  static const name = 'catsBloc';

  final CatService _catService;
  List<CatModel> allCats = [];
  List<String> urlCleaneds = [];

  final BlocGeneral<CatsState> _catsBloc = BlocGeneral<CatsState>(
    const CatsState.empty(),
  );

  @override
  FutureOr<void> dispose() {
    _catsBloc.dispose();
  }

  CatsState get breeds => _catsBloc.value;

  Stream<CatsState> get stateStream => _catsBloc.stream;

  Future<void> postCleanUrl({required String urlToClean}) async {
    _catsBloc.value = _catsBloc.value.copyWith(isLoading: true);
    try {
      final String urlCleaned = await _catService.postCleanUrl(url: urlToClean);
      urlCleaneds.add(urlCleaned);
      _catsBloc.value = _catsBloc.value.copyWith(cleanUrl: urlCleaned);
    } on Exception catch (e) {
      _catsBloc.value = _catsBloc.value.copyWith(
        hasError: e.toString(),
      );
      rethrow;
    } finally {
      _catsBloc.value = _catsBloc.value.copyWith(isLoading: false);
    }
  }

  Future<void> getCats() async {
    _catsBloc.value = _catsBloc.value.copyWith(isLoading: true);
    try {
      allCats = await _catService.getCatInfo();
      final List<String> nameCatsList = [];
      for (CatModel cat in allCats) {
        if (cat.name != null) {
          nameCatsList.add(cat.name ?? '');
        }
      }
      _catsBloc.value = _catsBloc.value.copyWith(
        allCats: allCats,
        catsNames: nameCatsList,
      );
    } on Exception catch (e) {
      _catsBloc.value = _catsBloc.value.copyWith(
        hasError: e.toString(),
      );
      rethrow;
    } finally {
      _catsBloc.value = _catsBloc.value.copyWith(isLoading: false);
    }
  }

  Future<void> searchCatImage({required String id}) async {
    _catsBloc.value = _catsBloc.value.copyWith(isLoading: true);
    try {
      final CatImageModel catImageModel = await _catService.getCatImage(id);
      _catsBloc.value = _catsBloc.value.copyWith(urlImage: catImageModel.url);
    } on Exception catch (e) {
      _catsBloc.value = _catsBloc.value.copyWith(
        hasError: e.toString(),
      );
      rethrow;
    } finally {
      _catsBloc.value = _catsBloc.value.copyWith(isLoading: false);
    }
  }

  Future<void> filterCats({required String nameSearch}) async {
    final List<CatModel> catList;
    catList = allCats
        .where(
          (CatModel element) =>
              element.name!.toLowerCase().contains(nameSearch.toLowerCase()),
        )
        .toList();
    _catsBloc.value = _catsBloc.value.copyWith(
      allCats: catList,
    );
  }

}

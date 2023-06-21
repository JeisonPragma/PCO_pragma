import '../../../models/cat_model.dart';

class CatsState {
  const CatsState({
    required this.allCats,
    required this.cats,
    required this.isLoading,
    required this.catsNames,
    required this.cleanUrl,
    required this.hasError,
    required this.urlImage,
  });

  const CatsState.empty({
    this.allCats = const [],
    this.cats = const [],
    this.catsNames = const [],
    this.isLoading = false,
    this.cleanUrl = '',
    this.hasError = '',
    this.urlImage = '',
  });
  final List<CatModel> allCats;
  final List<CatModel> cats;
  final List<String> catsNames;
  final bool isLoading;
  final String cleanUrl;
  final String hasError;
  final String urlImage;

  CatsState copyWith({
    List<CatModel>? allCats,
    List<CatModel>? cats,
    List<String>? catsNames,
    bool? isLoading,
    String? cleanUrl,
    String? hasError,
    String? urlImage,
  }) {
    return CatsState(
      allCats: allCats ?? this.allCats,
      cats: cats ?? this.cats,
      catsNames: catsNames ?? this.catsNames,
      isLoading: isLoading ?? this.isLoading,
      cleanUrl: cleanUrl ?? this.cleanUrl,
      hasError: hasError ?? this.hasError,
      urlImage: urlImage ?? this.urlImage,
    );
  }
}

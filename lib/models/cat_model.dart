class CatModel {
  CatModel({
    required this.temperament,
    required this.origin,
    required this.countryCodes,
    required this.countryCode,
    required this.description,
    required this.lifeSpan,
    required this.indoor,
    required this.weight,
    required this.id,
    required this.name,
    required this.referenceImage,
    this.cfaUrl,
    this.vetstreetUrl,
    this.vcahospitalsUrl,
    this.lap,
    this.altNames,
  });

  factory CatModel.fromJson(Map<String, dynamic> json) => CatModel(
        weight: Weight.fromJson(json['weight'] as Map<String, dynamic>),
        id: json['id'] as String?,
    referenceImage: json['reference_image_id'] as String?,
        name: json['name'] as String?,
        cfaUrl: json['cfa_url'] as String?,
        vetstreetUrl: json['vetstreet_url'] as String?,
        vcahospitalsUrl: json['vcahospitals_url'] as String?,
        temperament: json['temperament'] as String?,
        origin: json['origin'] as String?,
        countryCodes: json['country_codes'] as String?,
        countryCode: json['country_code'] as String?,
        description: json['description'] as String?,
        lifeSpan: json['life_span'] as String?,
        indoor: json['indoor'] as int?,
        lap: json['lap'] as int?,
        altNames: json['alt_names'] as String?,
      );

  final Weight weight;
  final String? id;
  final String? referenceImage;
  final String? name;
  final String? cfaUrl;
  final String? vetstreetUrl;
  final String? vcahospitalsUrl;
  final String? temperament;
  final String? origin;
  final String? countryCodes;
  final String? countryCode;
  final String? description;
  final String? lifeSpan;
  final int? indoor;
  final int? lap;
  final String? altNames;

  CatModel copyWith({
    Weight? weight,
    String? id,
    String? referenceImage,
    String? name,
    String? cfaUrl,
    String? vetstreetUrl,
    String? vcahospitalsUrl,
    String? temperament,
    String? origin,
    String? countryCodes,
    String? countryCode,
    String? description,
    String? lifeSpan,
    int? indoor,
    int? lap,
    String? altNames,
    int? adaptability,
    int? affectionLevel,
    int? childFriendly,
    int? dogFriendly,
    int? energyLevel,
    int? grooming,
    int? healthIssues,
    int? intelligence,
    int? sheddingLevel,
    int? socialNeeds,
    int? strangerFriendly,
    int? vocalisation,
    int? experimental,
    int? hairless,
    int? natural,
    int? rare,
    int? rex,
    int? suppressedTail,
    int? shortLegs,
    String? wikipediaUrl,
    int? hypoallergenic,
    String? referenceImageId,
    int? catFriendly,
    int? bidability,
  }) =>
      CatModel(
        weight: weight ?? this.weight,
        id: id ?? this.id,
        referenceImage: referenceImage ?? this.referenceImage,
        name: name ?? this.name,
        cfaUrl: cfaUrl ?? this.cfaUrl,
        vetstreetUrl: vetstreetUrl ?? this.vetstreetUrl,
        vcahospitalsUrl: vcahospitalsUrl ?? this.vcahospitalsUrl,
        temperament: temperament ?? this.temperament,
        origin: origin ?? this.origin,
        countryCodes: countryCodes ?? this.countryCodes,
        countryCode: countryCode ?? this.countryCode,
        description: description ?? this.description,
        lifeSpan: lifeSpan ?? this.lifeSpan,
        indoor: indoor ?? this.indoor,
        lap: lap ?? this.lap,
        altNames: altNames ?? this.altNames,
      );

  Map<String, dynamic> toJson() => {
        'weight': weight.toJson(),
        'id': id,
        'name': name,
        'cfa_url': cfaUrl,
        'vetstreet_url': vetstreetUrl,
        'vcahospitals_url': vcahospitalsUrl,
        'temperament': temperament,
        'origin': origin,
        'country_codes': countryCodes,
        'country_code': countryCode,
        'description': description,
        'life_span': lifeSpan,
        'indoor': indoor,
        'lap': lap,
        'alt_names': altNames,
      };
}

class Weight {
  Weight({
    required this.imperial,
    required this.metric,
  });

  factory Weight.fromJson(Map<String, dynamic> json) => Weight(
        imperial: json['imperial'] as String?,
        metric: json['metric'] as String?,
      );
  final String? imperial;
  final String? metric;

  Weight copyWith({
    String? imperial,
    String? metric,
  }) =>
      Weight(
        imperial: imperial ?? this.imperial,
        metric: metric ?? this.metric,
      );

  Map<String, dynamic> toJson() => {
        'imperial': imperial,
        'metric': metric,
      };
}

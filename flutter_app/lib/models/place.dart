class Place {
  final String name;
  final String businessStatus;
  final dynamic openingHours;
  final String placeId;
  final dynamic plusCode;
  final dynamic photos;
  final List types;
  final dynamic rating;
  final dynamic userRatingsTotal;
  final dynamic vicinity;

  Place({
    required this.name,
    required this.placeId,
    required this.businessStatus,
    required this.vicinity,
    required this.openingHours,
    required this.plusCode,
    required this.photos,
    required this.rating,
    required this.types,
    required this.userRatingsTotal,
  });
}

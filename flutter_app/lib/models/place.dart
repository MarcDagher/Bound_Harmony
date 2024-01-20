class Place {
  final String name;
  final String businessStatus;
  final String openingHours;
  final String placeId;
  final List plusCode;
  final List photos;
  final List types;
  final String rating;
  final String userRatingsTotal;
  final String vicinity;

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

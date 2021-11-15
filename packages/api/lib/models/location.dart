enum LocationType { city, region, state, province, country, continent }

class Location {
  final String title;
  final double woeid;
  final LocationType locationType;
  final String lattLong;
  final double? distance;

  Location(this.title, this.locationType, this.woeid, this.lattLong,
      {this.distance});

  factory Location.fronJSON(Map<String, dynamic> json) {
    return Location(
      json['title'],
      json['location_type'],
      json['woeid'],
      json['latt_long'],
    );
  }
}

import 'dart:convert';

class ConsolidatedWeather {
  int id;
  String weatherStateName;
  String weatherStateAbbr;
  String windDirectionCompass;
  String created;
  String applicableDate;
  double minTemp;
  double maxTemp;
  double theTemp;
  double windSpeed;
  double windDirection;
  double airPressure;
  int humidity;
  double visibility;
  int predictability;

  ConsolidatedWeather(
      this.id,
      this.weatherStateName,
      this.weatherStateAbbr,
      this.windDirectionCompass,
      this.created,
      this.applicableDate,
      this.minTemp,
      this.maxTemp,
      this.theTemp,
      this.windSpeed,
      this.windDirection,
      this.airPressure,
      this.humidity,
      this.visibility,
      this.predictability);

  factory ConsolidatedWeather.fronJSON(Map<String, dynamic> json) {
    return ConsolidatedWeather(
        json['id'],
        json['weather_state_name'],
        json['weather_state_abbr'],
        json['wind_direction_compass'],
        json['created'],
        json['applicable_date'],
        json['min_temp'],
        json['max_temp'],
        json['the_temp'],
        json['wind_speed'],
        json['wind_direction'],
        json['air_pressure'],
        json['humidity'],
        json['visibility'],
        json['predictability']);
  }

  factory ConsolidatedWeather.fronJSONString(String data) {
    Map<String, dynamic> parsedData = jsonDecode(data);
    return ConsolidatedWeather(
        parsedData['id'],
        parsedData['weather_state_name'],
        parsedData['weather_state_abbr'],
        parsedData['wind_direction_compass'],
        parsedData['created'],
        parsedData['applicable_date'],
        parsedData['min_temp'],
        parsedData['max_temp'],
        parsedData['the_temp'],
        parsedData['wind_speed'],
        parsedData['wind_direction'],
        parsedData['air_pressure'],
        parsedData['humidity'],
        parsedData['visibility'],
        parsedData['predictability']);
  }
}


class Source {
  String title;
  String slug;
  String url;
  int crawlRate;

  Source(this.title, this.slug, this.url, this.crawlRate);

  factory Source.fronJSON(Map<String, dynamic> json) {
    return Source(json['title'], json['slug'], json['url'], json['crawlRate']);
  }
}

class Weather {
  String time;
  String sunRise;
  String sunSet;
  String timezoneName;
  ConsolidatedWeather currentWeather;
  List<ConsolidatedWeather> consolidatedWeather;
  Location parent;
  List<Source>? sources;
  String title;
  String locationType;
  int woeid;
  String lattLong;
  String timezone;

  Weather(
    this.time,
    this.sunRise,
    this.sunSet,
    this.timezoneName,
    this.currentWeather,
    this.consolidatedWeather,
    this.parent,
    this.title,
    this.locationType,
    this.woeid,
    this.lattLong,
    this.timezone, {
    this.sources,
  });

  factory Weather.fronJSONString(String data) {
    Map<String, dynamic> parsedData = jsonDecode(data);
    List<Map<String, dynamic>> cw = parsedData['consolidated_weather'];
    return Weather(
      parsedData['time'],
      parsedData['sun_rise'],
      parsedData['sun_set'],
      parsedData['timezone_name'],
      ConsolidatedWeather.fronJSON(cw.first),
      cw
          .skip(1)
          .map((Map<String, dynamic> c) => ConsolidatedWeather.fronJSON(c))
          .toList(),
      Location.fronJSON(parsedData['parent']),
      parsedData['title'],
      parsedData['location_type'],
      parsedData['woeid'],
      parsedData['latt_long'],
      parsedData['timezone'],
    );
  }
}

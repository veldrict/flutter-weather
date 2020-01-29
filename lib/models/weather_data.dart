// To parse this JSON data, do
//
//     final weatherData = weatherDataFromJson(jsonString);

import 'dart:convert';

class WeatherData {
    Coord coord;
    List<Weather> weather;
    Main main;
    int dt;
    Sys sys;
    String name;
    int cod;
    String lastUpdate;

    WeatherData({
        this.coord,
        this.weather,
        this.main,
        this.dt,
        this.sys,
        this.name,
        this.cod,
        this.lastUpdate,
    });

    factory WeatherData.fromRawJson(String str) => WeatherData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
        coord: json["coord"] == null ? null : Coord.fromJson(json["coord"]),
        weather: json["weather"] == null ? null : List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        main: json["main"] == null ? null : Main.fromJson(json["main"]),
        dt: json["dt"] == null ? null : json["dt"],
        sys: json["sys"] == null ? null : Sys.fromJson(json["sys"]),
        name: json["name"] == null ? null : json["name"],
        cod: json["cod"] == null ? null : json["cod"],
        lastUpdate: json["lastUpdate"] == null ? null : json["lastUpdate"],
    );

    Map<String, dynamic> toJson() => {
        "coord": coord == null ? null : coord.toJson(),
        "weather": weather == null ? null : List<dynamic>.from(weather.map((x) => x.toJson())),
        "main": main == null ? null : main.toJson(),
        "dt": dt == null ? null : dt,
        "sys": sys == null ? null : sys.toJson(),
        "name": name == null ? null : name,
        "cod": cod == null ? null : cod,
        "lastUpdate": lastUpdate == null ? null : lastUpdate,
    };
}

class Coord {
    double lon;
    double lat;

    Coord({
        this.lon,
        this.lat,
    });

    factory Coord.fromRawJson(String str) => Coord.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json["lon"] == null ? null : json["lon"].toDouble(),
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lon": lon == null ? null : lon,
        "lat": lat == null ? null : lat,
    };
}

class Main {
    double temp;
    double feelsLike;
    double tempMin;
    double tempMax;
    int pressure;
    int humidity;
    int seaLevel;
    int grndLevel;

    Main({
        this.temp,
        this.feelsLike,
        this.tempMin,
        this.tempMax,
        this.pressure,
        this.humidity,
        this.seaLevel,
        this.grndLevel,
    });

    factory Main.fromRawJson(String str) => Main.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"] == null ? null : json["temp"].toDouble(),
        feelsLike: json["feels_like"] == null ? null : json["feels_like"].toDouble(),
        tempMin: json["temp_min"] == null ? null : json["temp_min"].toDouble(),
        tempMax: json["temp_max"] == null ? null : json["temp_max"].toDouble(),
        pressure: json["pressure"] == null ? null : json["pressure"],
        humidity: json["humidity"] == null ? null : json["humidity"],
        seaLevel: json["sea_level"] == null ? null : json["sea_level"],
        grndLevel: json["grnd_level"] == null ? null : json["grnd_level"],
    );

    Map<String, dynamic> toJson() => {
        "temp": temp == null ? null : temp,
        "feels_like": feelsLike == null ? null : feelsLike,
        "temp_min": tempMin == null ? null : tempMin,
        "temp_max": tempMax == null ? null : tempMax,
        "pressure": pressure == null ? null : pressure,
        "humidity": humidity == null ? null : humidity,
        "sea_level": seaLevel == null ? null : seaLevel,
        "grnd_level": grndLevel == null ? null : grndLevel,
    };
}

class Sys {
    String country;
    int sunrise;
    int sunset;

    Sys({
        this.country,
        this.sunrise,
        this.sunset,
    });

    factory Sys.fromRawJson(String str) => Sys.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        country: json["country"] == null ? null : json["country"],
        sunrise: json["sunrise"] == null ? null : json["sunrise"],
        sunset: json["sunset"] == null ? null : json["sunset"],
    );

    Map<String, dynamic> toJson() => {
        "country": country == null ? null : country,
        "sunrise": sunrise == null ? null : sunrise,
        "sunset": sunset == null ? null : sunset,
    };
}

class Weather {
    int id;
    String main;
    String description;
    String icon;

    Weather({
        this.id,
        this.main,
        this.description,
        this.icon,
    });

    factory Weather.fromRawJson(String str) => Weather.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"] == null ? null : json["id"],
        main: json["main"] == null ? null : json["main"],
        description: json["description"] == null ? null : json["description"],
        icon: json["icon"] == null ? null : json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "main": main == null ? null : main,
        "description": description == null ? null : description,
        "icon": icon == null ? null : icon,
    };
}

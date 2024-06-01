
class AboutCar{
  final String carModel;
  final String logo;
  final int establishedYear;
  final int averagePrice;
  final String description;
  final List<dynamic> carPics;

  AboutCar({
    required this.carModel,
    required this.logo,
    required this.establishedYear,
    required this.averagePrice,
    required this.description,
    required this.carPics,
  });

  factory AboutCar.fromJson(Map<String, dynamic> json){
    return AboutCar(
      carModel: json['car_model'] as String ?? '',
      logo: json['logo'] as String ?? '',
      establishedYear: json['established_year'] as int ?? 0,
      averagePrice: json['average_price'] as int ?? 0,
      description: json['description'] as String ?? '',
      carPics:json['car_pics'] as List<dynamic>,
    );
  }
}
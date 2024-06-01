
class CarModel{
  final int id;
  final String carModel;
  final int price;
  final String logo;
  final int year;

  CarModel({
    required this.id,
    required this.carModel,
    required this.price,
    required this.logo,
    required this.year,
  });

  factory CarModel.fromJson(Map<String, dynamic> json){
    return CarModel(
      id: json['id'] as int ?? 0,
      carModel: json['car_model'] as String ?? '',
      price: json['average_price'] as int ?? 0,
      logo: json['logo'] as String ?? '',
      year: json['established_year'] as int ?? 0,
    );
  }
}
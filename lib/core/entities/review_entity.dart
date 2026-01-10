class ReviewEntity {
  final String name;
  final String image;
  final num ratting;
  final String date;
  final String reviewDescription;

  ReviewEntity({
    required this.name,
    required this.image,
    required this.ratting,
    required this.date,
    required this.reviewDescription,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'image': image,
    'ratting': ratting,
    'date': date,
    'reviewDescription': reviewDescription,
  };

  factory ReviewEntity.fromJson(Map<String, dynamic> json) => ReviewEntity(
    name: json['name'],
    image: json['image'],
    ratting: json['ratting'],
    date: json['date'],
    reviewDescription: json['reviewDescription'],
  );
}

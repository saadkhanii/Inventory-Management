class Shoe {
  final String name;
  final String price;
  final String imagePath;
  final String discription;

  Shoe({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.discription,
  });

  // Convert Firestore data to Shoe object
  factory Shoe.fromMap(Map<String, dynamic> data) {
    return Shoe(
      name: data['name'] ?? '',
      price: data['price'] ?? '0',
      imagePath: data['imagePath'] ?? 'images/sho_1.png',
      discription: data['discription'] ?? '',
    );
  }

  // Convert Shoe object to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'imagePath': imagePath,
      'discription': discription,
    };
  }
}

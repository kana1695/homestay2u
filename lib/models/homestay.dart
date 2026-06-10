class Homestay {
  int? id;
  String? name;
  String? state;
  String? district;
  String? description;
  String? price;
  String? imageUrl;

  Homestay({
    this.id,
    this.name,
    this.state,
    this.district,
    this.description,
    this.price,
    this.imageUrl,
  });

  Homestay.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name']?.toString() ?? 'No name';
    state = json['state']?.toString() ?? 'No state';
    district = json['district']?.toString() ?? 'No district';
    description = json['description']?.toString() ?? 'No description';

    price = json['price']?.toString() ??
        json['rate']?.toString() ??
        json['rental']?.toString() ??
        'N/A';

    imageUrl = json['image_url']?.toString() ??
        json['image']?.toString() ??
        json['photo']?.toString() ??
        json['thumbnail']?.toString();
  }
}
class Homestay {
  int? id;
  String? name;
  String? state;
  String? district;
  String? town;
  String? address;
  String? description;
  List<String> activities = [];
  List<String> amenities = [];
  String? price;
  String? contactName;
  String? contactPhone;
  String? website;
  String? latitude;
  String? longitude;
  String? source;
  String? createdAt;
  String? imageUrl;

  Homestay.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name']?.toString() ?? 'No name';
    state = json['state']?.toString() ?? 'No state';
    district = json['district']?.toString() ?? 'No district';
    town = json['town']?.toString() ?? 'No town';
    address = json['address']?.toString() ?? 'No address';
    description = json['description']?.toString() ?? 'No description';

    if (json['activities'] != null) {
      activities = List<String>.from(json['activities']);
    }

    if (json['amenities'] != null) {
      amenities = List<String>.from(json['amenities']);
    }

    price = json['price_min']?.toString() ??
        json['price']?.toString() ??
        json['rate']?.toString() ??
        'N/A';

    contactName = json['contact_name']?.toString() ?? 'N/A';
    contactPhone = json['contact_phone']?.toString() ?? 'N/A';
    website = json['website']?.toString() ?? 'N/A';
    latitude = json['latitude']?.toString() ?? 'N/A';
    longitude = json['longitude']?.toString() ?? 'N/A';
    source = json['source']?.toString() ?? 'N/A';
    createdAt = json['created_at']?.toString() ?? 'N/A';
    imageUrl = json['image_url']?.toString();
  }
}
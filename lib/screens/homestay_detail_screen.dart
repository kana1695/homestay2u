import 'package:flutter/material.dart';
import 'package:homestay2u/models/homestay.dart';

class HomestayDetailScreen extends StatelessWidget {
  final Homestay homestay;

  const HomestayDetailScreen({super.key, required this.homestay});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homestay Details'),
        backgroundColor: const Color.fromARGB(255, 143, 201, 255),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (homestay.imageUrl != null &&
                    homestay.imageUrl!.isNotEmpty)
                  Image.network(
                    homestay.imageUrl!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 80),
                  )
                else
                  const Icon(Icons.home, size: 100, color: Color.fromARGB(255, 143, 201, 255)),

                const SizedBox(height: 15),

                Text(
                  homestay.name ?? '',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),
                Text('State: ${homestay.state}'),
                Text('District: ${homestay.district}'),
                Text('Price: ${homestay.price}'),

                const SizedBox(height: 15),
                const Text(
                  'Description:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(homestay.description ?? ''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
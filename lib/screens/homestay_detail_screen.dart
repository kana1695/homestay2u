import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homestay2u/models/homestay.dart';

class HomestayDetailScreen extends StatelessWidget {
  final Homestay homestay;

  const HomestayDetailScreen({super.key, required this.homestay});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          homestay.name ?? 'Homestay Details',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF6BB6FF),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            if (homestay.imageUrl != null && homestay.imageUrl!.isNotEmpty)
              Image.network(
                homestay.imageUrl!,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              )
            else
              Container(
                width: double.infinity,
                height: 220,
                color: Colors.grey.shade300,
                child: const Icon(Icons.home, size: 80),
              ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    homestay.name ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Price
                  Text(
                    'Starting from RM ${homestay.price}',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Location
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Color.fromARGB(255, 40, 122, 180),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          '${homestay.district}, ${homestay.state}',
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Text(homestay.address ?? '', style: GoogleFonts.poppins()),

                  const SizedBox(height: 20),

                  Text(
                    'Description',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    homestay.description ?? '',
                    style: GoogleFonts.poppins(),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Activities',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    homestay.activities.join(', '),
                    style: GoogleFonts.poppins(),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Amenities',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    homestay.amenities.join(', '),
                    style: GoogleFonts.poppins(),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Contact Information',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(Icons.person, size: 18, color: Colors.blue),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          homestay.contactName ?? 'N/A',
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(Icons.phone, size: 18, color: Colors.green),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          homestay.contactPhone ?? 'N/A',
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(
                        Icons.language,
                        size: 18,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          homestay.website ?? 'N/A',
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

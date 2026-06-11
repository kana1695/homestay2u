import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/homestay_list_screen.dart';

void main() {
  runApp(const MainApp());
}

// Main app class
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primaryColor: Color.fromARGB(255, 13, 48, 77),
      ),
    );
  }
}

//Splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomestayListScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 166, 210, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.home_rounded, size: 100, color: Color(0xFF0D304D)),

            const SizedBox(height: 20),

            Text(
              'Homestay2U Malaysia',
              style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0D304D),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Find Your Perfect Stay',
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

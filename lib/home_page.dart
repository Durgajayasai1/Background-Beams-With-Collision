import 'package:beams_collision/components/background_beams_with_collision.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: AppBar(
            title: Text(
              "_insane.dev",
              style: GoogleFonts.sora(
                  color: Colors.black, fontWeight: FontWeight.w900),
            ),
          )),
      body: Container(
        color: Colors.grey[300],
        height: double.infinity,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              Positioned.fill(
                child: BackgroundBeamsWithCollision(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("What's Cooler than Beams?",
                          style: GoogleFonts.sora(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w900)),
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [Colors.grey, Colors.black],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ).createShader(bounds),
                        child: Text("Exploading Beams.",
                            style: GoogleFonts.sora(
                                color: Colors.white,
                                fontSize: 34,
                                fontWeight: FontWeight.w900)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

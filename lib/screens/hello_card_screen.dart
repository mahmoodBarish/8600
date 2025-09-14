import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart'; // Import go_router

class HelloCardScreen extends StatefulWidget {
  const HelloCardScreen({Key? key}) : super(key: key);

  @override
  State<HelloCardScreen> createState() => _HelloCardScreenState();
}

class _HelloCardScreenState extends State<HelloCardScreen> {
  // Assuming the blue dot (id 167:35) is for the second page (index 1)
  // based on its relative position in the Figma JSON's dot group.
  int _currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive dimensions based on original Figma screen size 375x812
    final double figmaScreenWidth = 375;
    final double figmaScreenHeight = 812;

    // Card dimensions and position
    final double cardWidth = 326 / figmaScreenWidth * screenWidth;
    final double cardHeight = 614 / figmaScreenHeight * screenHeight;
    final double cardTopOffset = 81 / figmaScreenHeight * screenHeight;
    final double cardHorizontalPadding = (figmaScreenWidth - 326) / 2 / figmaScreenWidth * screenWidth;

    // Image header height
    final double imageHeaderHeight = 338 / figmaScreenHeight * screenHeight;

    // Spacing calculations based on Figma absolute bounding box values
    // Image bottom = 81 (card top) + 338 (image height) = 419
    // Headline "Hello" top = 465
    final double spaceImageToHeadline = (465 - (81 + 338)) / figmaScreenHeight * screenHeight;

    // Headline "Hello" render height = 20.72 (from absoluteRenderBounds height)
    // Headline "Hello" bottom approx = 465 + 20.72 = 485.72
    // Description "Lorem ipsum..." top = 513
    final double spaceHeadlineToDescription = (513 - (465 + 20.72)) / figmaScreenHeight * screenHeight;
    final double descriptionHorizontalPadding = (66 / figmaScreenWidth) * screenWidth;

    // Dots position: y=725, height=20. Bottom of dots is 725+20=745.
    final double dotsBottomOffset = (figmaScreenHeight - 745) / figmaScreenHeight * screenHeight;

    // Home indicator: y=798, height=5. Bottom of indicator is 798+5=803.
    final double homeIndicatorBottomOffset = (figmaScreenHeight - 803) / figmaScreenHeight * screenHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Bubbles
          // Bubble 01 (blue) - absoluteRenderBounds: x=0, y=0, width=255.435, height=319.326
          Positioned(
            left: 0,
            top: 0,
            width: screenWidth * (255.435 / figmaScreenWidth),
            height: screenHeight * (319.326 / figmaScreenHeight),
            child: CustomPaint(
              painter: Bubble01Painter(),
            ),
          ),
          // Bubble 02 (light blue/white) - absoluteRenderBounds: x=0, y=282.695, width=325.835, height=389.995
          Positioned(
            left: 0,
            top: screenHeight * (282.695 / figmaScreenHeight),
            width: screenWidth * (325.835 / figmaScreenWidth),
            height: screenHeight * (389.995 / figmaScreenHeight),
            child: CustomPaint(
              painter: Bubble02Painter(),
            ),
          ),

          // Status Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 44 / figmaScreenHeight * screenHeight, // Standard status bar height
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.symmetric(horizontal: 20 / figmaScreenWidth * screenWidth, vertical: 8),
              child: SafeArea(
                bottom: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '9:41',
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w600, // SemiBold
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(Icons.signal_cellular_alt, size: 18, color: Colors.black),
                        SizedBox(width: 5),
                        Icon(Icons.wifi, size: 18, color: Colors.black),
                        SizedBox(width: 5),
                        Icon(Icons.battery_full, size: 18, color: Colors.black),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Main Card Content
          Positioned(
            top: cardTopOffset,
            left: cardHorizontalPadding,
            width: cardWidth,
            height: cardHeight,
            child: GestureDetector(
              // The entire card is made tappable for navigation
              onTap: () {
                // Navigates to the '/home' route using go_router.
                context.go('/home');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromRGBO(0, 0, 0, 0.16),
                      offset: const Offset(0, 10),
                      blurRadius: 37,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Image Header
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                      child: Image.asset(
                        'assets/images/167_42.png', // Local asset path
                        width: double.infinity,
                        height: imageHeaderHeight,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: spaceImageToHeadline), // Responsive space calculation
                    // Headline Text
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20 / figmaScreenWidth * screenWidth), // General horizontal padding for text
                      child: Text(
                        'Hello',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.raleway(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          letterSpacing: -0.28,
                          color: const Color(0xFF202020),
                        ),
                      ),
                    ),
                    SizedBox(height: spaceHeadlineToDescription), // Responsive space calculation
                    // Description Text
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: descriptionHorizontalPadding),
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non consectetur turpis. Morbi eu eleifend lacus.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w300, // Light
                          fontSize: 19,
                          height: 27 / 19, // Line height calculation (lineHeightPx / fontSize)
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Dots (Page Indicator)
          Positioned(
            bottom: dotsBottomOffset,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                // Figma dots are 20x20 and their centers are 40px apart.
                // This means a 20px margin between the right edge of one dot and the left edge of the next.
                // To achieve this with `margin: horizontal`, each side gets 10px, so a total of 20px between dots.
                final double dotMarginHorizontal = 10 / figmaScreenWidth * screenWidth;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentPageIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: dotMarginHorizontal),
                    width: 20 / figmaScreenWidth * screenWidth,
                    height: 20 / figmaScreenHeight * screenHeight,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPageIndex == index
                          ? const Color(0xFF004BFF) // Active dot color (from 167:35)
                          : const Color(0xFFC7D6FC), // Inactive dot color (from 167:32)
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromRGBO(0, 0, 0, 0.16),
                          offset: const Offset(0, 0),
                          blurRadius: 30,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),

          // Bottom Home Indicator Bar
          Positioned(
            bottom: homeIndicatorBottomOffset,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 134 / figmaScreenWidth * screenWidth,
                height: 5 / figmaScreenHeight * screenHeight,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(34),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// CustomPainter for Bubble 01 (Blue bubble)
class Bubble01Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF004BEF) // Figma fill color: r=0, g=0.294, b=0.996, a=1
      ..style = PaintingStyle.fill;

    // Approximated as an oval covering its render bounds.
    final path = Path();
    path.addOval(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// CustomPainter for Bubble 02 (Light blue/white bubble)
class Bubble02Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF2F5FF) // Figma fill color: r=0.949, g=0.960, b=0.996, a=1
      ..style = PaintingStyle.fill;

    // Approximated as an oval covering its render bounds.
    final path = Path();
    path.addOval(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
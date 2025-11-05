import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart";

// तुमच्या डिझाइनसाठी निवडलेले रंग
const Color deepMatteBlack = Color(0xFF121212);
const Color offWhite = Color(0xFFF5F5DC);
const Color subtleSalmonPink = Color(0xFFFA8072);

void main() {
  runApp(const DigitalLibraryApp());
}

// ॲपचे मुख्य Widget, जिथे थीम आणि इतर मुलभूत गोष्टी सेट केल्या आहेत.
class DigitalLibraryApp extends StatelessWidget {
  const DigitalLibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "डिजिटल लायब्ररी",
      debugShowCheckedModeBanner: false,
      theme: _buildZenTheme(),
      home: const ArtworkGallery(),
    );
  }

  // 'जापनीज झेन' आणि 'डार्क ॲकेडेमिया' यावर आधारित कस्टम थीम.
  ThemeData _buildZenTheme() {
    return ThemeData(
      scaffoldBackgroundColor: deepMatteBlack,
      colorScheme: const ColorScheme.dark(
        primary: subtleSalmonPink,
        secondary: subtleSalmonPink,
        background: deepMatteBlack,
        surface: deepMatteBlack,
        onPrimary: offWhite,
        onSecondary: offWhite,
        onBackground: offWhite,
        onSurface: offWhite,
      ),
      textTheme: TextTheme(
        // शीर्षकांसाठी (Headers) 'Lora' हा सेरिफ फॉन्ट
        displayLarge: GoogleFonts.lora(
            fontSize: 48, fontWeight: FontWeight.bold, color: offWhite),
        headlineMedium: GoogleFonts.lora(
            fontSize: 24, fontWeight: FontWeight.w700, color: offWhite),
        // मुख्य मजकूरासाठी (Body Text) 'Lato' हा सॅन्स-सेरिफ फॉन्ट
        bodyMedium: GoogleFonts.lato(
            fontSize: 14, fontWeight: FontWeight.normal, color: offWhite),
        labelSmall: GoogleFonts.lato(
            fontSize: 12, fontWeight: FontWeight.bold, color: deepMatteBlack),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.lora(
            fontSize: 22, fontWeight: FontWeight.bold, color: offWhite),
      ),
    );
  }
}

// कलाकृती गॅलरीचे मुख्य पान.
class ArtworkGallery extends StatelessWidget {
  const ArtworkGallery({super.key});

  // सध्या नमुना डेटा वापरला आहे. तुम्ही तुमच्या कलाकृती इथे टाकू शकता.
  static final List<Map<String, String>> _artworks = [
    {"image": "https://picsum.photos/seed/picsum1/400/600", "title": "अमूर्त विचार"},
    {"image": "https://picsum.photos/seed/picsum2/400/400", "title": "शहरी स्वप्न"},
    {"image": "https://picsum.photos/seed/picsum3/400/700", "title": "निसर्गाचे संगीत"},
    {"image": "https://picsum.photos/seed/picsum4/400/500", "title": "रंगांची उधळण"},
    {"image": "https://picsum.photos/seed/picsum5/400/800", "title": "शांत समुद्र"},
    {"image": "https://picsum.photos/seed/picsum6/400/600", "title": "डिजिटल कॅनव्हास"},
    {"image": "https://picsum.photos/seed/picsum7/400/550", "title": "आठवणीतील क्षण"},
    {"image": "https://picsum.photos/seed/picsum8/400/450", "title": "भविष्याचा वेध"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("कला दालन"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // 'पिनटरेस्ट-स्टाईल' लेआउटसाठी Staggered Grid View चा वापर.
        child: MasonryGridView.count(
          crossAxisCount: 3, // ग्रिडमधील कॉलम्सची संख्या
          mainAxisSpacing: 16, // उभ्या घटकांमधील अंतर
          crossAxisSpacing: 16, // आडव्या घटकांमधील अंतर
          itemCount: _artworks.length,
          itemBuilder: (context, index) {
            return ArtworkCard(
              imageUrl: _artworks[index]["image"]!,
              title: _artworks[index]["title"]!,
            );
          },
        ),
      ),
    );
  }
}

// प्रत्येक कलाकृती दर्शवणारे एक कार्ड.
class ArtworkCard extends StatefulWidget {
  final String imageUrl;
  final String title;

  const ArtworkCard({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  State<ArtworkCard> createState() => _ArtworkCardState();
}

class _ArtworkCardState extends State<ArtworkCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // माउस ओव्हर इफेक्टसाठी MouseRegion चा वापर.
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // कलाकृतीची इमेज
            Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
            ),
            // होव्हर केल्यावर दिसणारा सूक्ष्म इफेक्ट
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: _isHovered ? subtleSalmonPink : Colors.transparent,
                  width: 3,
                ),
              ),
            ),
            // होव्हर केल्यावर दिसणारे शीर्षक
            if (_isHovered)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                color: deepMatteBlack.withOpacity(0.7),
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: offWhite,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

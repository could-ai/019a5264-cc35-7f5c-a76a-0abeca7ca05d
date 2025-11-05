import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// main() फंक्शन ॲप सुरू करते.
void main() {
  runApp(const PortfolioApp());
}

// Artwork मॉडेल क्लास, प्रत्येक कलाकृतीची माहिती जसे की शीर्षक, इमेज URL आणि टॅग्स संग्रहित करतो.
class Artwork {
  final String title;
  final String imageUrl;
  final List<String> tags;

  const Artwork({
    required this.title,
    required this.imageUrl,
    required this.tags,
  });
}

// तुमच्या पोर्टफोलिओसाठी नमुना डेटा. 
// येथे तुमच्या कलाकृतींची माहिती जोडली जाईल.
final List<Artwork> artworks = [
  const Artwork(title: " शांतता", imageUrl: "https://picsum.photos/seed/picsum1/400/600", tags: ["abstact", "zen"]),
  const Artwork(title: "अस्तित्व", imageUrl: "https://picsum.photos/seed/picsum2/400/500", tags: ["dark", "minimal"]),
  const Artwork(title: "स्वप्न", imageUrl: "https://picsum.photos/seed/picsum3/400/700", tags: ["vintage", "art"]),
  const Artwork(title: "प्रतिबिंब", imageUrl: "https://picsum.photos/seed/picsum4/400/550", tags: ["reflection", "water"]),
  const Artwork(title: "पहाट", imageUrl: "https://picsum.photos/seed/picsum5/400/650", tags: ["nature", "dawn"]),
  const Artwork(title: "अथांग", imageUrl: "https://picsum.photos/seed/picsum6/400/450", tags: ["ocean", "vast"]),
  const Artwork(title: "स्मृती", imageUrl: "https://picsum.photos/seed/picsum7/400/750", tags: ["memory", "sepia"]),
  const Artwork(title: "एकटेपणा", imageUrl: "https://picsum.photos/seed/picsum8/400/600", tags: ["solitude", "academia"]),
];

// हे ॲपचे मुख्य Widget आहे, जे MaterialApp ला कॉन्फिगर करते.
class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    // तुमच्या मागणीनुसार 'जापनीज झेन गार्डन्स' आणि 'डार्क ॲकेडेमिया' थीम तयार केली आहे.
    final theme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF121212), // डीप मॅट-ब्लॅक बॅकग्राउंड
      cardColor: const Color(0xFF1E1E1E),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFFF5F5DC), // ऑफ-व्हाईट टेक्स्ट
        secondary: Color(0xFFE9967A), // सूक्ष्म सॅल्मन-पिंक
        surface: Color(0xFF1E1E1E),
      ),
      textTheme: GoogleFonts.latoTextTheme(
        ThemeData.dark().textTheme,
      ).copyWith(
        // शीर्षकांसाठी 'Lora' (सेरिफ) फॉन्ट
        displayLarge: GoogleFonts.lora(fontWeight: FontWeight.bold, color: const Color(0xFFF5F5DC)),
        displayMedium: GoogleFonts.lora(fontWeight: FontWeight.bold, color: const Color(0xFFF5F5DC)),
        displaySmall: GoogleFonts.lora(fontWeight: FontWeight.bold, color: const Color(0xFFF5F5DC)),
        headlineMedium: GoogleFonts.lora(fontWeight: FontWeight.bold, color: const Color(0xFFF5F5DC)),
        // मुख्य मजकूरासाठी 'Lato' (सॅन्स-सेरिफ) फॉन्ट
        bodyLarge: GoogleFonts.lato(color: const Color(0xFFF5F5DC).withOpacity(0.87)),
        bodyMedium: GoogleFonts.lato(color: const Color(0xFFF5F5DC).withOpacity(0.87)),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        titleTextStyle: GoogleFonts.lora(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: const Color(0xFFF5F5DC),
        ),
      ),
    );

    return MaterialApp(
      title: 'डिजिटल लायब्ररी',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const PortfolioHomePage(),
    );
  }
}

// हे होम पेज आहे, जेथे तुमच्या सर्व कलाकृती 'पिनटरेस्ट-स्टाईल' ग्रिडमध्ये दिसतील.
class PortfolioHomePage extends StatelessWidget {
  const PortfolioHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('कलाकृती'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // 'पिनटरेस्ट-स्टाईल' लेआउटसाठी StaggeredGridView वापरले आहे.
        child: MasonryGridView.builder(
          itemCount: artworks.length,
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          itemBuilder: (context, index) {
            return ArtworkCard(artwork: artworks[index]);
          },
        ),
      ),
    );
  }
}

// प्रत्येक कलाकृतीसाठी एक स्वतंत्र कार्ड Widget.
class ArtworkCard extends StatefulWidget {
  final Artwork artwork;

  const ArtworkCard({super.key, required this.artwork});

  @override
  State<ArtworkCard> createState() => _ArtworkCardState();
}

class _ArtworkCardState extends State<ArtworkCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          // होव्हर केल्यावर सॅल्मन-पिंक बॉर्डर दिसेल.
          side: BorderSide(
            color: _isHovered ? Theme.of(context).colorScheme.secondary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            // कलाकृतीची इमेज
            Image.network(
              widget.artwork.imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                        : null,
                    strokeWidth: 2,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                );
              },
            ),
            // इमेजवर ग्रेडियंट ओव्हरले, ज्यामुळे मजकूर स्पष्ट दिसेल.
            Positioned.fill(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _isHovered ? 1.0 : 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // कलाकृतीचे शीर्षक
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _isHovered ? 1.0 : 0.0,
                child: Text(
                  widget.artwork.title,
                  style: GoogleFonts.lora(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

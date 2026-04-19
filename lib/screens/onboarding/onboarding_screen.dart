import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../data/services/storage_service.dart';

// Wave Pattern Painter
class WavePatternPainter extends CustomPainter {
  final Color color;
  final double opacity;

  WavePatternPainter({this.color = const Color(0xFF00C853), this.opacity = 0.1});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(opacity)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw multiple wave lines
    for (int i = 0; i < 15; i++) {
      final path = Path();
      final yOffset = i * (size.height / 12);
      
      path.moveTo(0, yOffset);
      
      for (double x = 0; x <= size.width; x += 10) {
        final y = yOffset + 
            30 * (i % 2 == 0 ? 1 : -1) * 
            (x / size.width) * 
            (1 - (x / size.width)) * 
            4 * 
            (0.5 - (x / size.width)).abs();
        path.lineTo(x, y);
      }
      
      canvas.drawPath(path, paint);
    }

    // Draw vertical curves
    for (int i = 0; i < 8; i++) {
      final path = Path();
      final xOffset = i * (size.width / 7);
      
      path.moveTo(xOffset, 0);
      
      for (double y = 0; y <= size.height; y += 10) {
        final x = xOffset + 
            40 * (i % 2 == 0 ? 1 : -1) * 
            (y / size.height) * 
            (1 - (y / size.height)) * 
            4 * 
            (0.5 - (y / size.height)).abs();
        path.lineTo(x, y);
      }
      
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final StorageService _storage = StorageService();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Manage Your Sales',
      description: 'Track all your sales in real-time, issue receipts, and accept multiple payment methods',
      image: 'assets/images/fun-3d-illustration-american-referee.jpg',
    ),
    OnboardingPage(
      title: 'Control Stock',
      description: 'Keep records of your products, get low stock alerts, and manage product prices',
      image: 'assets/images/fun-3d-illustration-american-referee.jpg',
    ),
    OnboardingPage(
      title: 'Increase Profits',
      description: 'Analyze your business performance, track expenses, and increase your profits',
      image: 'assets/images/fun-3d-illustration-american-referee.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _storage.init();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _onSkip() {
    _completeOnboarding();
  }

  Future<void> _completeOnboarding() async {
    await _storage.setOnboardingComplete(true);
    if (mounted) {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Wave pattern background
          Positioned.fill(
            child: CustomPaint(
              painter: WavePatternPainter(
                color: const Color(0xFF00C853),
                opacity: 0.08,
              ),
            ),
          ),
          
          // Main content
          SafeArea(
            child: Column(
              children: [
                // Skip Button
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextButton(
                      onPressed: _onSkip,
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
            
            // Page Content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
            ),
            
            // Bottom Section
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  // Page Indicators - Simple dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? const Color(0xFF00C853)
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Next/Get Started Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _onNextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00C853),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  ),
);
  }

  Widget _buildPage(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 3D Image
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(page.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 40),
          
          // Title
          Text(
            page.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          
          // Description
          Text(
            page.description,
            style: TextStyle(
              color: Colors.grey.shade600,
              height: 1.5,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final String image;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.image,
  });
}

import 'dart:async';
import 'package:flutter/material.dart';

class CustomProductCarousel extends StatefulWidget {
  final List<Map<String, dynamic>> products;
  final double imageHeight;
  final int initialIndex;
  final PageController? pageController;
  final ValueChanged<int>? onPageChanged;

  const CustomProductCarousel({
    super.key,
    required this.products,
    required this.imageHeight,
    this.initialIndex = 0,
    this.pageController,
    this.onPageChanged,
  });

  @override
  State<CustomProductCarousel> createState() => _CustomProductCarouselState();
}

class _CustomProductCarouselState extends State<CustomProductCarousel> {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialIndex;
    _pageController =
        widget.pageController ?? PageController(initialPage: _currentPage);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_pageController.hasClients) {
        setState(() {
          if (!mounted) return;
          _currentPage++;
          if (_currentPage >= widget.products.length) {
            _currentPage = 0;
          }
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOutCubic,
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    if (widget.pageController == null) {
      _pageController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: widget.imageHeight,
      child: Center(
        child: SizedBox(
          width: screenWidth * 0.8,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.products.length,
            onPageChanged: (index) {
              if (mounted) {
                setState(() {
                  _currentPage = index;
                });
                widget.onPageChanged?.call(index);
              }
            },
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(screenWidth * 0.05),
                child: Image.asset(
                  widget.products[index]['image'],
                  height: widget.imageHeight,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: widget.imageHeight,
                      color: Colors.grey[300],
                      child: const Center(child: Text('Image Not Found')),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

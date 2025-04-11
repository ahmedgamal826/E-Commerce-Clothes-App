import 'dart:async';
import 'package:e_commerce_app/constants/app_colors.dart';
import 'package:e_commerce_app/screens/product_overview/widgets/product_bottom_sheet.dart';
import 'package:flutter/material.dart';

class ProductOverviewScreen extends StatefulWidget {
  final List<Map<String, dynamic>> products;
  final int initialIndex;

  const ProductOverviewScreen({
    Key? key,
    required this.products,
    required this.initialIndex,
  }) : super(key: key);

  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialIndex;
    _pageController = PageController(initialPage: _currentPage);
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
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final imageHeight = screenHeight * 0.4;
    final paddingHorizontal = screenWidth * 0.04;
    final paddingVertical = screenHeight * 0.01;
    final fontSizeTitle = screenWidth * 0.06;
    final fontSizeSubtitle = screenWidth * 0.04;
    final fontSizeDescription = screenWidth * 0.045;
    final starSize = screenWidth * 0.1;
    final buttonPaddingHorizontal = screenWidth * 0.1;
    final buttonPaddingVertical = screenHeight * 0.02;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Text(''),
        title: const Text(
          'Product Overview',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        titleTextStyle: TextStyle(
          fontSize: screenWidth * 0.062,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal,
          vertical: paddingVertical,
        ),
        child: SizedBox(
          height: screenHeight -
              kToolbarHeight -
              MediaQuery.of(context).padding.top -
              (2 * paddingVertical),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: imageHeight,
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
                        }
                      },
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.05),
                          child: Image.asset(
                            widget.products[index]['image'],
                            height: imageHeight,
                            width: double.infinity,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: imageHeight,
                                color: Colors.grey[300],
                                child: const Center(
                                    child: Text('Image Not Found')),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.products.length, (index) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
                    child: CircleAvatar(
                      radius: screenWidth * 0.015,
                      backgroundColor: index == _currentPage
                          ? AppColors.primaryColor
                          : Colors.grey[300],
                    ),
                  );
                }),
              ),
              SizedBox(height: screenHeight * 0.02),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.products[_currentPage]['name']
                                      .split(' ')[0],
                                  style: TextStyle(
                                    fontSize: fontSizeTitle,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.products[_currentPage]['name']
                                              .split(' ')
                                              .length >
                                          1
                                      ? widget.products[_currentPage]['name']
                                          .split(' ')
                                          .sublist(1)
                                          .join(' ')
                                      : '',
                                  style: TextStyle(
                                    fontSize: fontSizeSubtitle,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '\$${widget.products[_currentPage]['price'].toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: fontSizeTitle,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < widget.products[_currentPage]['rating']
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.yellow[700],
                              size: starSize,
                            );
                          }),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          widget.products[_currentPage]['description'] ??
                              'No description available for this product.',
                          style: TextStyle(
                            fontSize: fontSizeDescription,
                            color: Colors.grey[600],
                          ),
                          softWrap: true,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(screenWidth * 0.035),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[200],
                            ),
                            child: Icon(
                              Icons.shopping_cart,
                              color: AppColors.primaryColor,
                              size: screenWidth * 0.06,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.7,
                            height: screenHeight * 0.07,
                            child: ElevatedButton(
                              onPressed: () {
                                ProductBottomSheet.show(
                                  context,
                                  widget.products[_currentPage]['price'],
                                  widget.products[_currentPage]['name'],
                                  widget.products[_currentPage]['image'],
                                  () {
                                    print(
                                        "Checkout pressed from Bottom Sheet!");
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                padding: EdgeInsets.symmetric(
                                  horizontal: buttonPaddingHorizontal,
                                  vertical: buttonPaddingVertical,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(screenWidth * 0.05),
                                ),
                              ),
                              child: Text(
                                'Buy Now',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.05,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
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
        ),
      ),
    );
  }
}

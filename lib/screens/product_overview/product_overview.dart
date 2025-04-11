import 'package:e_commerce_app/constants/app_colors.dart';
import 'package:e_commerce_app/screens/product_overview/widgets/buy_now_button.dart';
import 'package:e_commerce_app/screens/product_overview/widgets/custom_dot_indicator.dart';
import 'package:e_commerce_app/screens/product_overview/widgets/custom_product_carousel.dart';
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
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialIndex;
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
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
        leading: const SizedBox
            .shrink(), // Replaced Text('') with SizedBox.shrink() for clarity
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
              CustomProductCarousel(
                products: widget.products,
                imageHeight: imageHeight,
                initialIndex: widget.initialIndex,
                pageController: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
              SizedBox(height: screenHeight * 0.04),
              CustomDotIndicator(
                widget: widget,
                screenWidth: screenWidth,
                currentPage: _currentPage,
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
                          BuyNowButton(
                            screenWidth: screenWidth,
                            screenHeight: screenHeight,
                            widget: widget,
                            currentPage: _currentPage,
                            buttonPaddingHorizontal: buttonPaddingHorizontal,
                            buttonPaddingVertical: buttonPaddingVertical,
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

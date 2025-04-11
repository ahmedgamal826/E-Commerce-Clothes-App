import 'dart:async';
import 'package:e_commerce_app/screens/cart_screen/cart_screen.dart';
import 'package:e_commerce_app/screens/favourites_screen/favourites_screen.dart';
import 'package:e_commerce_app/screens/home_screen/widgets/bottom_nav_bar.dart';
import 'package:e_commerce_app/screens/home_screen/widgets/build_tap_button.dart';
import 'package:e_commerce_app/screens/home_screen/widgets/custom_floating_action_button.dart';
import 'package:e_commerce_app/screens/home_screen/widgets/home_search_text_field.dart';
import 'package:e_commerce_app/screens/home_screen/widgets/newest_products_list.dart';
import 'package:e_commerce_app/screens/home_screen/widgets/notifications_icon_widget.dart';
import 'package:e_commerce_app/screens/home_screen/widgets/product_card.dart';
import 'package:e_commerce_app/screens/home_screen/widgets/products_list.dart';
import 'package:e_commerce_app/screens/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    CartScreen(),
    FavoritesPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
      floatingActionButton: const CustomFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Start auto-scrolling after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_scrollController.hasClients) {
        // Calculate the width of each card (150 + 16 padding)
        const double cardWidth = 150 + 16;
        _currentIndex++;

        if (_currentIndex >= products.length) {
          // If at the end, scroll back to the start
          _currentIndex = 0;
          _scrollController.jumpTo(0);
        } else {
          // Scroll to the next card
          _scrollController.animateTo(
            _currentIndex * cardWidth,
            duration: const Duration(milliseconds: 800), // Smoother duration
            curve: Curves.easeInOutCubic, // Smoother curve
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Row(
                  children: [
                    HomeSearchTextField(),
                    SizedBox(width: 10),
                    NotificationsIconWidget(),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    'assets/images/home_logo.png',
                    height: 80,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TabButton(
                      title: 'All',
                      onPressed: () {},
                    ),
                    TabButton(
                      title: 'Category',
                      onPressed: () {},
                    ),
                    TabButton(
                      title: 'Top',
                      onPressed: () {},
                    ),
                    TabButton(
                      title: 'Recommend',
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 260,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        products: products,
                        name: products[index]['name'],
                        rating: products[index]['rating'],
                        price: products[index]['price'],
                        imagePath: products[index]['image'],
                        index: index,
                        isGridView: false,
                        isFavorite: products[index]['isFavorite'],
                        onFavoriteTapped: () {
                          setState(() {
                            products[index]['isFavorite'] =
                                !products[index]['isFavorite'];
                          });
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Newest Products',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: newestProducts.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      products: newestProducts,
                      name: newestProducts[index]['name'],
                      rating: newestProducts[index]['rating'],
                      price: newestProducts[index]['price'],
                      imagePath: newestProducts[index]['image'],
                      index: index,
                      isGridView: true,
                      isFavorite: newestProducts[index]['isFavorite'],
                      onFavoriteTapped: () {
                        setState(() {
                          newestProducts[index]['isFavorite'] =
                              !newestProducts[index]['isFavorite'];
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

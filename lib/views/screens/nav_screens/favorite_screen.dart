import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/provider/favorite_provider.dart';
import 'package:grocery_app/views/screens/main_screen.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});

  @override
  ConsumerState<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final wishListProvider = ref.watch(favoriteProvider.notifier);
    final wishItemData = ref.watch(favoriteProvider);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.2),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: 118,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/icons/cartb.png',
                ), // AssetImage
                fit: BoxFit.cover,
              ), // DecorationImage
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 322,
                  top: 52,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/icons/not.png',
                        width: 25,
                        height: 25,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 20,
                          height: 20,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade800,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              wishItemData.length.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ), // TextStyle
                            ), // Text
                          ),
                        ),
                      ), // Image.asset
                    ],
                  ), // Stack
                ),
                Positioned(
                  left: 61,
                  top: 56,
                  child: Text(
                    'My Favorite List',
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ) // Positioned
              ],
            ) // Stack// BoxDecoration
            ),
      ),
      body: wishItemData.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your wishlist is empty.\nYou can add product to your cart from the button below.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      letterSpacing: 1.7,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MainScreen();
                            },
                          ),
                        );
                      },
                      child: Text('Shop Now')),
                ],
              ),
            )
          : ListView.builder(
              itemCount: wishItemData.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final wishData = wishItemData.values.toList()[index];

                return Padding(
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Container(
                      width: 335,
                      height: 96,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: SizedBox(
                        width: double.infinity,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 336,
                                height: 97,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Color(
                                      0xFFEFF0F2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 13,
                              top: 9,
                              child: Container(
                                width: 78,
                                height: 78,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFBBC5FF),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 275,
                              top: 16,
                              child: Text(
                                '\$${wishData.productPrice.toStringAsFixed(2)}',
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(
                                    0xFFF0B0C1F,
                                  ),
                                ),
                              ), // Phần còn thiếu nội dung của child
                            ),
                            Positioned(
                              left: 101,
                              top: 14,
                              child: SizedBox(
                                width: 162,
                                child: Text(
                                  wishData.productName,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 23,
                              top: 14,
                              child: Image.network(
                                wishData.image[0],
                                width: 56,
                                height: 67,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              left: 284,
                              top: 47,
                              child: IconButton(
                                onPressed: () {
                                  wishListProvider
                                      .removeFavoriteItem(wishData.productId);
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ), // Phần còn thiếu nội dung của child
                ); // Padding
              },
            ), // ListView.builder
// Scaffold
    );
  }
}

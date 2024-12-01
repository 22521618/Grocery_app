import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/controllers/product_review_controller.dart';
import 'package:grocery_app/models/order.dart';

class OrderDetailScreen extends StatefulWidget {
  final Order order;
  const OrderDetailScreen({super.key, required this.order});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  double rating = 0.0;

  final TextEditingController _reviewController = TextEditingController();

  final ProductReviewController productReviewController =
      ProductReviewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.order.productName,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: 335,
            height: widget.order.delivered == true ? 190 : 150,
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
                      height: 170,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color(
                            0xFFEFF0F2,
                          ), // Color
                        ),
                        borderRadius: BorderRadius.circular(
                          9,
                        ), // Color
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            left: 13,
                            top: 9,
                            child: Container(
                              width: 78,
                              height: 78,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: const Color(0xFFBCC5FF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                    left: 10,
                                    top: 5,
                                    child: Image.network(
                                      widget.order.image,
                                      width: 58,
                                      height: 67,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 101,
                    top: 14,
                    child: SizedBox(
                      width: 216,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      widget.order.productName,
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.order.category,
                                      style: GoogleFonts.montserrat(
                                        color: const Color(0xFFF7F808C),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "\$${widget.order.productPrice.toStringAsFixed(2)}",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF0B0C1E),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 13,
                    top: 113,
                    child: Container(
                      width: 100,
                      height: 25,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: widget.order.delivered == true
                            ? const Color(0xFF3C55EF)
                            : widget.order.processing == true
                                ? Colors.purple
                                : Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            left: 9,
                            top: 2,
                            child: Text(
                              widget.order.delivered == true
                                  ? "Delivered"
                                  : widget.order.processing == true
                                      ? "Processing"
                                      : "Cancelled",
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 115,
                    left: 298,
                    child: InkWell(
                      onTap: () {
                        // Thực hiện hành động khi người dùng nhấn vào đây
                      },
                      child: Image.asset(
                        'assets/icons/delete.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ), // Container // Positioned
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              width: 336,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xFFEFF0F2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivery Address',
                          style: GoogleFonts.montserrat(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.7,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ), // SizedBox

                        Text(
                          "${widget.order.state} ${widget.order.city} ${widget.order.locality}",
                          style: GoogleFonts.lato(
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ), // Text

                        Text(
                          "To ${widget.order.fullName}",
                          style: GoogleFonts.roboto(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Order Id: ${widget.order.id}",
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                          ),
                        ) // Text// Text
                      ],
                    ),
                  ),
                  widget.order.delivered == true
                      ? TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Leave a review'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextFormField(
                                          controller: _reviewController,
                                          decoration: InputDecoration(
                                            labelText: 'Your Review',
                                          ),
                                        ),
                                        RatingBar(
                                          filledIcon: Icons.star,
                                          emptyIcon: Icons.star_border,
                                          onRatingChanged: (value) {
                                            rating = value;
                                          },
                                          initialRating: 3,
                                          maxRating: 5,
                                        )
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          final review = _reviewController.text;
                                          productReviewController.uploadReview(
                                            buyerId: widget.order.buyerId,
                                            email: widget.order.email,
                                            fullName: widget.order.fullName,
                                            productId: widget.order.id,
                                            rating: rating,
                                            review: review,
                                            context: context,
                                          );
                                        },
                                        child: const Text(
                                          'Submit',
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Text(
                            'Leave a Review',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
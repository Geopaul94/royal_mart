import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:royalmart/presentation/screens/cart_screen.dart';
import 'package:royalmart/presentation/screens/wishlist_screen.dart';
import 'package:royalmart/presentation/widgets/custom_text.dart';
import 'package:royalmart/utilities/constants/constants.dart';
import 'package:badges/badges.dart' as badges;

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final int wishlistCount;
//   final int cartCount;

//   const CustomAppBar({
//     super.key,
//     required this.wishlistCount,
//     required this.cartCount,
//   });

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       leading: IconButton(
//         icon: const Icon(
//           CupertinoIcons.search,
//           color: Colors.grey,
//         ),
//         onPressed: () {},
//       ),
//       backgroundColor: Colors.black,
//       elevation: 1,
//       actions: [
//         Padding(
//           padding: const EdgeInsets.only(right: 8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//                CustomText(
//                 text: "Royal Mart",
//                 color: white,
//                 fontSize: 24,
//                 fontWeight: FontWeight.w600,
//               ),
//               w20,
//               badges.Badge(
//                 badgeContent: Text(
//                   cartCount.toString(),
//                   style: const TextStyle(color: Colors.white),
//                 ),
//                 badgeStyle: const badges.BadgeStyle(badgeColor: Colors.blue),
//                 child: IconButton(
//                   icon: const Icon(
//                     CupertinoIcons.shopping_cart,
//                     color: Colors.green,
//                     size: 30,
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       CupertinoPageRoute(builder: (context) =>  CartScreen()),
//                     );
//                   },
//                 ),
//               ),
//               w10,
//               badges.Badge(
//                 badgeContent: Text(
//                   wishlistCount.toString(),
//                   style: const TextStyle(color: Colors.white),
//                 ),
//                 badgeStyle: const badges.BadgeStyle(badgeColor: Colors.red),
//                 child: IconButton(
//                   icon: const Icon(
//                     CupertinoIcons.heart, // Changed to heart (favorite icon)
//                     color: Colors.red,
//                     size: 30,
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       CupertinoPageRoute(builder: (context) =>  WishlistScreen()),
//                     );
//                   },
//                 ),
//               ),
//               w10,
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
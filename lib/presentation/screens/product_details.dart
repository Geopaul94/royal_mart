import 'package:flutter/material.dart';
import 'package:royalmart/data/model/product_model.dart';
import 'package:royalmart/presentation/widgets/custom_text.dart';
import 'package:royalmart/presentation/widgets/custome_appbar.dart';

// class ProductDetails extends StatelessWidget {
//   final ProductModel product;
//   const ProductDetails({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//   //    appBar: CustomAppBar(),
//       backgroundColor: Colors.black,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CustomText(
//               text: product.title,
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//             SizedBox(height: 16),
//             Center(
//               child: Image.network(
//                 product.image,
//                 height: 200,
//                 fit: BoxFit.cover,
//                 loadingBuilder: (BuildContext context, Widget child,
//                     ImageChunkEvent? loadingProgress) {
//                   if (loadingProgress == null) return child;
//                   return Center(
//                     child: CircularProgressIndicator(
//                       value: loadingProgress.expectedTotalBytes != null
//                           ? loadingProgress.cumulativeBytesLoaded /
//                               (loadingProgress.expectedTotalBytes ?? 1)
//                           : null,
//                     ),
//                   );
//                 },
//                 errorBuilder: (BuildContext context, Object error,
//                     StackTrace? stackTrace) {
//                   return Center(child: Icon(Icons.error, color: Colors.red));
//                 },
//               ),
//             ),
//             SizedBox(height: 16),
//             CustomText(
//               text: product.description,
//               color: Colors.white70,
//               fontSize: 16,
//             ),
//             SizedBox(height: 16),
//             CustomText(
//               text: "\${product.price}",
//               color: Colors.white,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//             SizedBox(height: 8),
//             buildStarRating(product.rating.rate),
//             SizedBox(height: 8),
//             CustomText(
//               text: "${product.rating.count} reviews",
//               color: Colors.white70,
//               fontSize: 14,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget buildStarRating(double rating) {
//   int fullStars = rating.floor();
//   bool hasHalfStar = rating - fullStars >= 0.5;
//   List<Widget> stars = [];

//   for (int i = 0; i < 5; i++) {
//     if (i < fullStars) {
//       stars.add(Icon(Icons.star, color: Colors.yellow));
//     } else if (i == fullStars && hasHalfStar) {
//       stars.add(Icon(Icons.star_half, color: Colors.yellow));
//     } else {
//       stars.add(Icon(Icons.star_border, color: Colors.yellow));
//     }
//   }

//   return Row(
//     children: stars,
//   );
// }

import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel product;

  const ProductDetails({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title.toString())),
      body: Column(
        children: [
          Image.network(product.image.toString()),
          Text(product.title.toString()),
          Text('\$${product.price}'),
          Text(product.description.toString()),
          Text('Category: ${product.category}'),
          Text(
              'Rating: ${product.rating.rate} (${product.rating.count} reviews)'),
        ],
      ),
    );
  }
}

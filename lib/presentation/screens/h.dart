// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:royalmart/data/model/product_model.dart';
// import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_bloc.dart';
// import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_event.dart';
// import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_state.dart';
// import 'package:royalmart/presentation/widgets/custom_text.dart';
// import 'package:royalmart/presentation/screens/product_details.dart';
// import 'package:royalmart/presentation/widgets/CustomBottomNav.dart';
// import 'package:royalmart/presentation/widgets/custome_appbar.dart';
// import 'package:royalmart/presentation/widgets/custome_wishlist.dart';
// import 'package:royalmart/presentation/widgets/shimmer_loading.dart';
// import 'package:royalmart/utilities/constants/constants.dart';
// import 'package:royalmart/utilities/functions/product_name.dart';

// class samplescreen extends StatefulWidget {
//   const samplescreen({super.key});

//   @override
//   State<samplescreen> createState() => _samplescreenState();
// }

// class _samplescreenState extends State<samplescreen> {
//   int selectedIndex = 0;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     context.read<FetchProductsBloc>().add(FetchProductsInitialEvent());
//   }

//   void onSelected(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: CustomAppBar(),
//         backgroundColor: black,
//         body: Stack(
//           children: [
//             allproductstext(),
//             allProductsDetails(),
//             Positioned(
//               bottom: 30.h,
//               left: 70.w,
//               right: 70.w,
//               child: Container(
//                 height: 55.h,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: const Color.fromARGB(62, 158, 158, 158),
//                     width: 1.0,
//                   ),
//                   color: Colors.white,
//                   borderRadius: BorderRadius.all(Radius.circular(35)),
//                 ),
//                 child: Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       CustomBottomNav(
//                         icon: Icons.home,
//                         isSelected: selectedIndex == 0,
//                         onTap: () => onSelected(0),
//                       ),
//                       CustomBottomNav(
//                         icon: Icons.favorite,
//                         isSelected: selectedIndex == 1,
//                         onTap: () => onSelected(1),
//                       ),
//                       CustomBottomNav(
//                         icon: Icons.shopping_cart,
//                         isSelected: selectedIndex == 2,
//                         onTap: () => onSelected(2),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }
// }

// Positioned allproductstext() {
//   return Positioned(
//       top: 25.h,
//       left: 0,
//       right: 0,
//       child: Column(
//         children: [
//           Container(
//               height: 55.h,
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadiusDirectional.only(
//                   topEnd: Radius.circular(40),
//                   topStart: Radius.circular(40),
//                 ),
//               ),
//               child: Center(
//                 child: CustomText(
//                   text: 'All products',
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w700,
//                 ),
//               )),
//         ],
//       ));
// }

// Positioned allProductsDetails() {
//   return Positioned(
//     top: 81.h,
//     left: 0,
//     right: 0,
//     bottom: 10,
//     child: BlocBuilder<FetchProductsBloc, FetchProductsState>(
//       builder: (context, state) {
//         if (state is FetchProductsLoading) {
//           return Center(child: ShimmerLoading());
//         } else if (state is FetchProductsSuccess) {
//           return Container(
//             padding: EdgeInsets.all(8),
//             color: white,
//             child: MasonryGridView.count(
//               crossAxisCount: 2,
//               mainAxisSpacing: 0,
//               crossAxisSpacing: 0,
//               itemCount: state.products.length,
//               shrinkWrap: true,
//               itemBuilder: (context, index) {
//                 if (index < state.products.length) {
//                   final product = state.products[index];

//                   return GestureDetector(
//                       onTap: () async {
//                         Navigator.push(
//                           context,
//                           CupertinoPageRoute(
//                             builder: (context) =>
//                                 ProductDetails(product: product),
//                           ),
//                         );
//                       },
//                       child: customeimageContainer(index, product));
//                 }
//                 return Container();
//               },
//             ),
//           );
//         } else {
//           return Center(child: Text('Failed to load products'));
//         }
//       },
//     ),
//   );
// }

// Container customeimageContainer(int index, ProductModel product) {
//   return Container(
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.all(Radius.circular(20)),
//       color: Colors.white,
//     ),
//     height: index % 2 == 0 ? 340 : 380,
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Image.network(
//                   product.image,
//                   height: index % 2 == 0 ? 230 : 280,
//                   width: double.infinity,
//                   fit: BoxFit.fill,
//                 ),
//               ),
//               Positioned(
//                 top: 8,
//                 left: 8,
//                 child: CustomLikeButton(),
//               ),
//             ],
//           ),
//           h10,
//           CustomText(
//             text: truncateProductTitle(product.title),
//             color: const Color.fromARGB(182, 0, 0, 0),
//           ),
//           CustomText(text: product.price.toString()),
//           CustomText(
//             text: product.category,
//             color: const Color.fromARGB(182, 0, 0, 0),
//             fontSize: 14.sp,
//           ),
//         ],
//       ),
//     ),
//   );
// }






 //  ----------------------------------------------------------------------------------


//  class samplescreen extends StatefulWidget {
//   const samplescreen({super.key});

//   @override
//   State<samplescreen> createState() => _samplescreenState();
// }

// class _samplescreenState extends State<samplescreen> {
//   int selectedIndex = 0;
// late Future<List<Product>> futureProducts;

//   @override
//   void initState() {
//     super.initState();
//     futureProducts = ApiService().fetchProducts();
//   }

//   void onSelected(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//   }













//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: CustomAppBar(),
//         backgroundColor: black,
//         body: Stack(
//           children: [
//             allproductstext(),
//             allProductsDetails(),
//             Positioned(
//               bottom: 30.h,
//               left: 70.w,
//               right: 70.w,
//               child: Container(
//                 height: 55.h,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: const Color.fromARGB(62, 158, 158, 158),
//                     width: 1.0,
//                   ),
//                   color: Colors.white,
//                   borderRadius: BorderRadius.all(Radius.circular(35)),
//                 ),
//                 child: Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       CustomBottomNav(
//                         icon: Icons.home,
//                         isSelected: selectedIndex == 0,
//                         onTap: () => onSelected(0),
//                       ),
//                       CustomBottomNav(
//                         icon: Icons.favorite,
//                         isSelected: selectedIndex == 1,
//                         onTap: () => onSelected(1),
//                       ),
//                       CustomBottomNav(
//                         icon: Icons.shopping_cart,
//                         isSelected: selectedIndex == 2,
//                         onTap: () => onSelected(2),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }
// }

// Positioned allproductstext() {
//   return Positioned(
//       top: 25.h,
//       left: 0,
//       right: 0,
//       child: Column(
//         children: [
//           Container(
//               height: 55.h,
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadiusDirectional.only(
//                   topEnd: Radius.circular(40),
//                   topStart: Radius.circular(40),
//                 ),
//               ),
//               child: Center(
//                 child: CustomText(
//                   text: 'All products',
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w700,
//                 ),
//               )),
//         ],
//       ));
// }

// Positioned allProductsDetails() {
//   return Positioned(
//     top: 81.h,
//     left: 0,
//     right: 0,
//     bottom: 10,
//     child: BlocBuilder<FetchProductsBloc, FetchProductsState>(
//       builder: (context, state) {
//         if (state is FetchProductsLoading) {
//           return Center(child: ShimmerLoading());
//         } else if (state is FetchProductsSuccess) {
//           return Container(
//             padding: EdgeInsets.all(8),
//             color: white,
//             child: MasonryGridView.count(
//               crossAxisCount: 2,
//               mainAxisSpacing: 0,
//               crossAxisSpacing: 0,
//               itemCount: state.products.length,
//               shrinkWrap: true,
//               itemBuilder: (context, index) {
//                 if (index < state.products.length) {
//                   final product = state.products[index];

//                   return GestureDetector(
//                       onTap: () async {
//                         Navigator.push(
//                           context,
//                           CupertinoPageRoute(
//                             builder: (context) =>
//                                 ProductDetails(product: product),
//                           ),
//                         );
//                       },
//                       child: customeimageContainer(index, product));
//                 }
//                 return Container();
//               },
//             ),
//           );
//         } else {
//           return Center(child: Text('Failed to load products'));
//         }
//       },
//     ),
//   );
// }

// Container customeimageContainer(int index, ProductModel product) {
//   return Container(
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.all(Radius.circular(20)),
//       color: Colors.white,
//     ),
//     height: index % 2 == 0 ? 340 : 380,
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Image.network(
//                   product.image,
//                   height: index % 2 == 0 ? 230 : 280,
//                   width: double.infinity,
//                   fit: BoxFit.fill,
//                 ),
//               ),
//               Positioned(
//                 top: 8,
//                 left: 8,
//                 child: CustomLikeButton(),
//               ),
//             ],
//           ),
//           h10,
//           CustomText(
//             text: truncateProductTitle(product.title),
//             color: const Color.fromARGB(182, 0, 0, 0),
//           ),
//           CustomText(text: product.price.toString()),
//           CustomText(
//             text: product.category,
//             color: const Color.fromARGB(182, 0, 0, 0),
//             fontSize: 14.sp,
//           ),
//         ],
//       ),
//     ),
//   );
// }







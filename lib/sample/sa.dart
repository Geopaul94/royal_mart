import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    ),
  );
}



// ScaffoldMessenger.of(context).showSnackBar(
//   SnackBar(
//     content: Text(state.errorMessage),
//     backgroundColor: Colors.red,
//     duration: Duration(seconds: 3),
//     action: SnackBarAction(
//       label: 'Retry',
//       textColor: Colors.white,
//       onPressed: () {
//         context.read<FetchProductsBloc>().add(FetchProductsInitialEvent());
//       },
//     ),
//   ),
// );




// if (state is FetchProductsError) {
//   showCustomSnackBar(context, state.errorMessage);
// }



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'fetch_products_bloc.dart';

// class ProductsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => FetchProductsBloc(apiService: ApiService()),
//       child: Scaffold(
//         appBar: AppBar(title: Text('Products')),
//         body: BlocConsumer<FetchProductsBloc, FetchProductsState>(
//           listener: (context, state) {
//             if (state is FetchProductsError) {
//               // Show a SnackBar with the error message
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(state.errorMessage),
//                   backgroundColor: Colors.red,
//                   duration: Duration(seconds: 3),
//                 ),
//               );
//             }
//           },
//           builder: (context, state) {
//             if (state is FetchProductsInitial || state is FetchProductsLoading) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is FetchProductsSuccess) {
//               return ListView.builder(
//                 itemCount: state.products.length,
//                 itemBuilder: (context, index) {
//                   final product = state.products[index];
//                   return ListTile(
//                     title: Text(product.title),
//                     subtitle: Text('\$${product.price}'),
//                     leading: Image.network(product.image),
//                   );
//                 },
//               );
//             } else {
//               return Center(child: Text('Unknown state'));
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royalmart/data/model/product.dart';
import 'package:royalmart/data/repository/fetch_products.dart';
import 'package:royalmart/data/repository/photo_fetching.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_bloc.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_event.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_state.dart';
import 'package:royalmart/presentation/bloc/photos/photos_bloc.dart';
import 'package:royalmart/presentation/screens/h.dart';

import 'package:royalmart/presentation/screens/splash_screen.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   final PexelsApiService pexelsApiService = PexelsApiService();

//   final ApiService apiService = ApiService();
//   MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(392, 802),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (context, child) {
//         return MultiBlocProvider(
//             providers: [
//               BlocProvider(
//                 create: (context) => ImageBloc(pexelsApiService),
//               ),
//               BlocProvider(
//                 create: (context) => FetchProductsBloc(apiService: apiService),
//               ),
//             ],
//             child: MaterialApp(
//                 debugShowCheckedModeBanner: false,
//                 title: 'Royal Mart',
//                 theme: ThemeData(),
//                 home: samplescreen()));
//       },
//     );
//   }
// }













import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_bloc.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartWishlistBloc(),
      child: MaterialApp(
        title: 'Fake Store App',
        home: ProductListScreen(),
      ),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ApiService().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartWishlistBloc, CartWishlistState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Products'),
            actions: [
              badges.Badge(
                badgeContent: Text(
                  state.wishlist.length.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                badgeStyle: badges.BadgeStyle(badgeColor: Colors.red),
                child: IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WishlistScreen()),
                    );
                  },
                ),
              ),
              badges.Badge(
                badgeContent: Text(
                  state.cart.length.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                badgeStyle: badges.BadgeStyle(badgeColor: Colors.blue),
                child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
          body: FutureBuilder<List<Product>>(
            future: futureProducts,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final product = snapshot.data![index];
                    final isInWishlist =
                        state.wishlist.any((item) => item.id == product.id);
                    final isInCart =
                        state.cart.any((item) => item.id == product.id);

                    return ListTile(
                      leading: Image.network(product.image, width: 50),
                      title: Text(product.title),
                      subtitle: Text('\$${product.price}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              isInWishlist
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isInWishlist ? Colors.red : null,
                            ),
                            onPressed: () {
                              if (isInWishlist) {
                                context
                                    .read<CartWishlistBloc>()
                                    .add(RemoveFromWishlist(product));
                              } else {
                                context
                                    .read<CartWishlistBloc>()
                                    .add(AddToWishlist(product));
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              isInCart
                                  ? Icons.remove_shopping_cart
                                  : Icons.add_shopping_cart,
                            ),
                            onPressed: () {
                              if (isInCart) {
                                context
                                    .read<CartWishlistBloc>()
                                    .add(RemoveFromCart(product));
                              } else {
                                context
                                    .read<CartWishlistBloc>()
                                    .add(AddToCart(product));
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
    );
  }
}

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartWishlistBloc, CartWishlistState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('Wishlist')),
          body: ListView.builder(
            itemCount: state.wishlist.length,
            itemBuilder: (context, index) {
              final product = state.wishlist[index];
              return ListTile(
                leading: Image.network(product.image, width: 50),
                title: Text(product.title),
                subtitle: Text('\$${product.price}'),
              );
            },
          ),
        );
      },
    );
  }
}

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartWishlistBloc, CartWishlistState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('Cart')),
          body: ListView.builder(
            itemCount: state.cart.length,
            itemBuilder: (context, index) {
              final product = state.cart[index];
              return ListTile(
                leading: Image.network(product.image, width: 50),
                title: Text(product.title),
                subtitle: Text('\$${product.price}'),
              );
            },
          ),
        );
      },
    );
  }
}










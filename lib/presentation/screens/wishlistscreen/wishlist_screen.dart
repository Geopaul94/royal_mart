import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:royalmart/data/model/product_model.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_bloc.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_event.dart';
import 'package:royalmart/presentation/screens/wishlistscreen/custome_wishlist_container.dart';
import 'package:royalmart/presentation/widgets/cusotme_product_rating.dart';
import 'package:royalmart/presentation/widgets/custom_text.dart';
import 'package:royalmart/utilities/constants/constants.dart';
import 'package:royalmart/utilities/functions/product_name.dart';
import 'package:royalmart/utilities/functions/sanckBar.dart';

import '../../bloc/fetchproduct/fetchproducts_state.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartWishlistBloc, CartWishlistState>(
      builder: (context, state) {
        if (state is CartWishlistLoading) {
          return Scaffold(
            appBar: AppBar(title: Text('Wishlist')),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is CartWishlistSuccess) {
          // Check if the wishlist is empty
          if (state.wishlist.isEmpty) {
            return Scaffold(
              backgroundColor: black,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: IconButton(
                  icon: Icon(
                    CupertinoIcons.back,
                    color: Colors.grey,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                title: const Text(
                  "My Wishlist",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.black,
              ),
              body: Center(
                child: Text(
                  'Your wishlist is empty',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            );
          }

          return Scaffold(
            backgroundColor: black,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(
                  CupertinoIcons.back,
                  color: Colors.grey,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                "My Wishlist",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black,
            ),
            body: GridView.builder(
              padding: EdgeInsets.all(2.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                childAspectRatio: 0.7, // Adjust the aspect ratio as needed
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: state.wishlist.length,
              itemBuilder: (context, index) {
                final product = state.wishlist[index];
                return CustomWishlistContainer(product: product);
              },
            ),
          );
        } else if (state is CartWishlistError) {
          return Scaffold(
            appBar: AppBar(title: Text('Wishlist')),
            body: Center(child: Text(state.error)),
          );
        }
        return Scaffold(
          appBar: AppBar(title: Text('Wishlist')),
          body: Center(child: Text('Unexpected state')),
        );
      },
    );
  }
}


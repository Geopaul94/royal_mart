



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:royalmart/data/model/product_model.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_bloc.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_event.dart';
import 'package:royalmart/presentation/bloc/fetchproduct/fetchproducts_state.dart';

import 'package:royalmart/presentation/screens/cartscreen/cart_screen.dart';

import 'package:royalmart/presentation/screens/productdetails/product_details.dart';

import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:royalmart/presentation/screens/wishlistscreen/wishlist_screen.dart';
import 'package:royalmart/presentation/widgets/CustomBottomNav.dart';
import 'package:royalmart/presentation/widgets/custom_addcart.dart';
import 'package:royalmart/presentation/widgets/custome_appbar.dart';
import 'package:royalmart/presentation/widgets/custome_likedt.dart';
import 'package:royalmart/presentation/widgets/custon_product_container.dart';
import 'package:royalmart/presentation/widgets/shimmer_loading.dart';





  Positioned allproductstext() {
    return Positioned(
      top: 25.h,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Container(
            height: 55.h,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(40),
                topStart: Radius.circular(40),
              ),
            ),
            child: Center(
              child: Text(
                'All products',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

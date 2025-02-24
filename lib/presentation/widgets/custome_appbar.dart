import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:royalmart/presentation/widgets/custom_text.dart';

import 'package:royalmart/presentation/widgets/custome_elevatedbutton.dart';

import 'package:royalmart/utilities/constants/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustomAppBar({super.key}) : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.search,
          color: Colors.grey,
        ),
        onPressed: () {},
      ),
      backgroundColor: Colors.black,
      elevation: 1,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomText(
                text: "Royal Mart",
                color: white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              w20,
              IconButton(
                icon: Icon(
                  CupertinoIcons.shopping_cart,
                  color: Colors.green,
                  size: 30,
                ),
                onPressed: () {},
              ),
              w10,
              IconButton(
                icon: Icon(
                  CupertinoIcons.suit_heart_fill,
                  color: Colors.red,
                  size: 30,
                ),
                onPressed: () {},
              ),
              w10,
            ],
          ),
        ),
      ],
    );
  }
}

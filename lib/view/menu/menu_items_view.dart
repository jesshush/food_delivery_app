import 'package:flutter/material.dart';
import 'package:food_delivery/common/color_extension.dart';
import 'package:food_delivery/common_widget/round_textfield.dart';
import 'package:food_delivery/common_widget/menu_item_row.dart';
import '../more/my_order_view.dart';
import 'item_details_view.dart';

class MenuItemsView extends StatefulWidget {
  final Map<String, dynamic> mObj;

  const MenuItemsView({Key? key, required this.mObj}) : super(key: key);

  @override
  State<MenuItemsView> createState() => _MenuItemsViewState();
}

class _MenuItemsViewState extends State<MenuItemsView> {
  TextEditingController txtSearch = TextEditingController();
  List<Map<String, dynamic>> menuItemsArr = [
    {
      "image": "assets/img/detail_top.png",
      "name": "Tandoori Pizza",
      "rate": "4.9",
      "rating": "124",
      "type": "Pizza Hut",
      "food_type": "Food"
    },
    {
      "image": "assets/img/dess_2.png",
      "name": "Dark Chocolate Cake",
      "rate": "4.9",
      "rating": "124",
      "type": "Cakes by Tella",
      "food_type": "Desserts"
    },
    {
      "image": "assets/img/dess_3.png",
      "name": "Street Shake",
      "rate": "4.9",
      "rating": "124",
      "type": "Café Racer",
      "food_type": "Desserts"
    },
    {
      "image": "assets/img/dess_4.png",
      "name": "Fudgy Chewy Brownies",
      "rate": "4.9",
      "rating": "124",
      "type": "Minute by tuk tuk",
      "food_type": "Desserts"
    },
  ];

  List<Map<String, dynamic>> filteredMenuItemsArr = [];

  @override
  void initState() {
    super.initState();
    filteredMenuItemsArr = List.from(menuItemsArr);
  }

  void filterMenuItems(String query) {
    setState(() {
      filteredMenuItemsArr = menuItemsArr
          .where((item) =>
          item["name"].toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 46,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        widget.mObj["name"].toString(),
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyOrderView(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RoundTextfield(
                  hintText: "Search Food",
                  controller: txtSearch,
                  left: const Icon(Icons.search),
                  onChanged: filterMenuItems,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: filteredMenuItemsArr.length,
                itemBuilder: ((context, index) {
                  var mObj = filteredMenuItemsArr[index];
                  return MenuItemRow(
                    mObj: mObj,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemDetailsView(),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

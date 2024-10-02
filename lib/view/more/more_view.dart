import 'package:flutter/material.dart';
import 'package:food_delivery/view/more/payment_details_view.dart';
import '../../common/color_extension.dart';
import 'my_order_view.dart';
import 'recipe_selection_page.dart';

class MoreView extends StatefulWidget {
  const MoreView({Key? key}) : super(key: key);

  @override
  State<MoreView> createState() => _MoreViewState();
}

class _MoreViewState extends State<MoreView> {
  double _currentRating = 0;

  void _showThankYouAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Thank You for Rating Us!"),
          content: const Text("We appreciate your feedback."),
          actions: <Widget>[
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> moreArr = [
      {
        "index": "1",
        "name": "Payment Details",
        "image": "assets/img/more_payment.png",
        "base": 0
      },
      {
        "index": "2",
        "name": "My Orders",
        "image": "assets/img/more_my_order.png",
        "base": 0
      },
      {
        "index": "3",
        "name": "Recipe",
        "image": "assets/img/recipe_icon.png",
        "base": 0
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 46,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "More",
                      style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyOrderView()));
                      },
                      icon: Image.asset(
                        "assets/img/shopping_cart.png",
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: moreArr.length,
                itemBuilder: (context, index) {
                  var mObj = moreArr[index];
                  var countBase = mObj["base"];
                  return InkWell(
                    onTap: () {
                      switch (mObj["index"].toString()) {
                        case "1":
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const PaymentDetailsView()));
                          break;
                        case "2":
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyOrderView()));
                          break;
                        case "3":
                        // Navigate to Recipe Selection Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeSelectionPage(
                                recipes: [
                                  "Watermelon Lemonade",
                                  "Pink Lemonade",
                                  "Steamed Farro"
                                ],
                              ),
                            ),
                          );
                          break;
                        default:
                          break;
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                            decoration: BoxDecoration(
                                color: TColor.textfield,
                                borderRadius: BorderRadius.circular(5)),
                            margin: const EdgeInsets.only(right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: TColor.placeholder,
                                      borderRadius:
                                      BorderRadius.circular(25)),
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    mObj["image"].toString(),
                                    width: 25,
                                    height: 25,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Text(
                                    mObj["name"].toString(),
                                    style: TextStyle(
                                        color: TColor.primaryText,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                if (countBase > 0)
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                        BorderRadius.circular(12.5)),
                                    alignment: Alignment.center,
                                    child: Text(
                                      countBase.toString(),
                                      style: TextStyle(
                                          color: TColor.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: TColor.textfield,
                                borderRadius: BorderRadius.circular(15)),
                            child: Image.asset(
                              "assets/img/btn_next.png",
                              width: 10,
                              height: 10,
                              color: TColor.primaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(
                "Customer Rating: $_currentRating",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Slider(
                value: _currentRating,
                min: 0,
                max: 5,
                divisions: 5,
                onChanged: (double value) {
                  setState(() {
                    _currentRating = value;
                  });
                },
                onChangeEnd: (double value) {
                  _showThankYouAlert();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                      (index) => Icon(
                    index < _currentRating.floor()
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
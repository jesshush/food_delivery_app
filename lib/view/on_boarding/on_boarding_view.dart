import 'package:flutter/material.dart';
import 'package:food_delivery/common/color_extension.dart';
import 'package:food_delivery/common_widget/round_button.dart';
import 'package:food_delivery/view/main_tabview/main_tabview.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _scaleAnimation;
  int selectPage = 0;
  PageController controller = PageController();
  double currentPageValue = 0.0;

  List<Map<String, dynamic>> pageArr = [
    {
      "title": "Find Food You Love",
      "subtitle":
      "Discover the best foods from over 1,000\nrestaurants and fast delivery to your\ndoorstep",
      "image": "assets/img/on_boarding_1.png",
      "animationType": AnimationType.scaleAndFade,
    },
    {
      "title": "Fast Delivery",
      "subtitle": "Fast food delivery to your home, office\n wherever you are",
      "image": "assets/img/on_boarding_2.png",
      "animationType": AnimationType.scooter,
    },
    {
      "title": "Live Tracking",
      "subtitle":
      "Real time tracking of your food on the app\nonce you placed the order",
      "image": "assets/img/on_boarding_3.png",
      "animationType": AnimationType.scaleAndFade,
    },
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, -0.08),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.repeat(reverse: true);

    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page ?? 0.0;
        selectPage = currentPageValue.round();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: controller,
            itemCount: pageArr.length,
            itemBuilder: ((context, index) {
              var pageData = pageArr[index];
              Widget pageContent = _buildPageContent(pageData, media);

              return pageContent;
            }),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: media.height * 0.6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: pageArr.map((e) {
                  var index = pageArr.indexOf(e);

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 6,
                    width: 6,
                    decoration: BoxDecoration(
                        color: index == selectPage
                            ? TColor.primary
                            : TColor.placeholder,
                        borderRadius: BorderRadius.circular(4)),
                  );
                }).toList(),
              ),
              SizedBox(
                height: media.height * 0.28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: RoundButton(
                  title: "Next",
                  onPressed: () {
                    if (selectPage >= 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainTabView(),
                        ),
                      );
                    } else {
                      setState(() {
                        selectPage = selectPage + 1;
                        controller.animateToPage(selectPage,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      });
                    }
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPageContent(Map<String, dynamic> pageData, Size media) {
    Widget pageContent = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (pageData["animationType"] == AnimationType.scaleAndFade)
          ScaleTransition(
            scale: _scaleAnimation,
            child: FadeTransition(
              opacity: _controller,
              child: Container(
                width: media.width,
                height: media.width,
                alignment: Alignment.center,
                child: Image.asset(
                  pageData["image"].toString(),
                  width: media.width * 0.65,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        if (pageData["animationType"] == AnimationType.scooter)
          SlideTransition(
            position: _offsetAnimation,
            child: Container(
              width: media.width,
              height: media.width,
              alignment: Alignment.center,
              child: Image.asset(
                pageData["image"].toString(),
                width: media.width * 0.65,
                fit: BoxFit.contain,
              ),
            ),
          ),
        if (pageData["animationType"] != AnimationType.scaleAndFade &&
            pageData["animationType"] != AnimationType.scooter)
          Container(
            width: media.width,
            height: media.width,
            alignment: Alignment.center,
            child: Image.asset(
              pageData["image"].toString(),
              width: media.width * 0.65,
              fit: BoxFit.contain,
            ),
          ),
        SizedBox(
          height: media.width * 0.2,
        ),
        Text(
          pageData["title"].toString(),
          style: TextStyle(
              color: TColor.primaryText,
              fontSize: 28,
              fontWeight: FontWeight.w800),
        ),
        SizedBox(
          height: media.width * 0.05,
        ),
        Text(
          pageData["subtitle"].toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
              color: TColor.secondaryText,
              fontSize: 13,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: media.width * 0.20,
        ),
      ],
    );

    return pageContent;
  }
}

enum AnimationType {
  scaleAndFade,
  scooter,
}

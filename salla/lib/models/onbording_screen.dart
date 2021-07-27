import 'package:flutter/material.dart';
import 'package:salla/models/shop_login_screen.dart';
import 'package:salla/shard/components/components.dart';
import 'package:salla/shard/sharedpr.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnbordingScreen extends StatefulWidget {
  @override
  _OnbordingScreenState createState() => _OnbordingScreenState();
}

class _OnbordingScreenState extends State<OnbordingScreen> {
  var boardController = PageController();
  bool isLast = false;

  void submit() {
    CashHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigatAndfinsh(context, Shoploginscreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: submit,
            child: Text(
              'SKIP',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.deepOrange,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == bording.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                    print('isLast');
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                  print('notLast');
                },
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(bording[index]),
                itemCount: bording.length,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5.0,
                      activeDotColor: Colors.deepOrange),
                  count: bording.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                  backgroundColor: Colors.deepOrange,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salla/models/shop_login_screen.dart';
import 'package:salla/shard/sharedpr.dart';

class BordingModel {
  final String image;
  final String title;
  final String body;

  BordingModel(
      {@required this.image, @required this.title, @required this.body});
}

List<BordingModel> bording = [
  BordingModel(
      image: 'assets/images/splash_1.png',
      title: 'Screen Title 1',
      body: 'On Board 1 '),
  BordingModel(
      image: 'assets/images/splash_2.png',
      title: 'Screen Title 2',
      body: 'On Board 2'),
  BordingModel(
      image: 'assets/images/splash_3.png',
      title: 'Screen Title 3',
      body: 'On Board 3'),
];

class Text_Form_Widget extends StatelessWidget {
  String lableText;
  String hintText;

  Widget prefixIcon;
  Function onTap;
  Function validator;
  TextInputType keyboardType;
  TextEditingController controller;
  TextStyle textStyle;
  Widget suffixIcon;
  bool obscureText;
  Widget suffix;

  Text_Form_Widget(
      {this.lableText,
      this.hintText,
      this.prefixIcon,
      this.onTap,
      this.validator,
      this.keyboardType,
      this.textStyle,
      this.controller,
      this.suffixIcon,
      this.obscureText,
      this.suffix});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        keyboardType: keyboardType,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          labelText: lableText,
          labelStyle: textStyle,
          hintText: hintText,
          suffix: suffix,
          suffixIcon: suffixIcon,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 45,
            vertical: 20,
          ),
          fillColor: Colors.black,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).cardColor),
            borderRadius: BorderRadius.circular(5),
            gapPadding: 10,
          ),
        ),
        onTap: onTap,
        obscureText: obscureText,
        controller: controller,
        validator: validator,
      ),
    );
  }
}

void navigatAndfinsh(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);
void navigation(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

Widget buildBoardingItem(BordingModel model) => Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage("${model.image}"),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          '${model.title}',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '${model.body}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );

void ShowToast({
  @required String text,
  @required ToastState state,
}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: ChooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastState { SUCCESS, ERROR, WARNING }

Color ChooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

void signout(context) {
  TextButton(
    onPressed: () {
      CashHelper.clearData(key: 'token').then((value) {
        navigatAndfinsh(context, Shoploginscreen());
      });
    },
    child: Text(
      'Sign out',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: Colors.blue,
      ),
    ),
  );
}

void printFullText(String text) {
  final Pattern = RegExp(".{1.800}");
  Pattern.allMatches(text).forEach((match) => print(match.group(8)));
}

String token = '';

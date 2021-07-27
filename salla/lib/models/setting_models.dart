import 'package:flutter/material.dart';
import 'package:salla/models/shop_login_screen.dart';
import 'package:salla/shard/components/components.dart';
import 'package:salla/shard/sharedpr.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
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
        ),
      ),
    );
  }
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

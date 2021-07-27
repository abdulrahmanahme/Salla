import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/Layout/home_layout.dart';
import 'package:salla/models/onbording_screen.dart';
import 'package:salla/shard/components/cubit/Cubit.dart';
import 'package:salla/shard/components/cubit/style/bloc_observer.dart';
import 'package:salla/shard/sharedpr.dart';
import 'shard/components/network/remote/Dio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  await CashHelper.init();
  // CashHelper.sharedPreferences;
  bool onBoarding = CashHelper.getData(key: 'onBoarding');
  String token = CashHelper.getData(key: 'token');
  Widget widget;
  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLayout();
  } else {
    widget = OnbordingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocConsumer(builder:, listener: ),

        BlocProvider(
          create: (BuildContext context) => SallaShopCubit()
            ..getHomeData()
            ..getCategoriesData(),
        ),

        BlocProvider(create: (BuildContext context) => SallaShopCubit()),
      ],
      child: MaterialApp(
        title: 'Salla',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
              color: Colors.white,
              elevation: 0,
              backwardsCompatibility: false,
              iconTheme: IconThemeData(color: Colors.black, size: 10)),
        ),
        home: startWidget,
      ),
    );
  }
}

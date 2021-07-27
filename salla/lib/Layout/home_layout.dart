import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/sreach_screan.dart';
import 'package:salla/shard/components/components.dart';
import 'package:salla/shard/components/cubit/Cubit.dart';
import 'package:salla/shard/components/cubit/status.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SallaShopCubit, SallaShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SallaShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Salla',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
              ),
            ),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    navigation(context, SearchScreen());
                  }),
            ],
          ),
          body: Center(
            child: cubit.bottomScreen[cubit.selectedIndex],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            // backgroundColor: Colors.green,
            elevation: 20,
            currentIndex: cubit.selectedIndex,
            onTap: (index) {
              cubit.currentIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                backgroundColor: Colors.grey[200],
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                backgroundColor: Colors.blue,
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                backgroundColor: Colors.grey[200],
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                backgroundColor: Colors.grey[200],
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}

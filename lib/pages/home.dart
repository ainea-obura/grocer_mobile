import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modules/category/category_cubit.dart';
import '../modules/logout/logout_cubit.dart';
import '../widgets/bottomNavBar.dart';
import '../widgets/categories_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _name;
  // String? _phone;
  // String? _email;
  //String? _token;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<CategoriesCubit>();
      cubit.getCategories();
    });

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        //_id = pref.getInt('id');
        _name = prefs.getString('name');
        //_token = prefs.getString('token');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.sort, color: Colors.black),
          onPressed: () {
            // Add your custom action here
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // Add your custom action here
            },
          ),
        ],
        title: const Text('Home', style: TextStyle(color: Colors.black)),
      ),


      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              //const SizedBox(height: 16,),
              CategoriesWidget(),
              //Text('Name: $_name'),
              //Text('Token: $_token'),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const BottomNavBar(),
    );

  }
}

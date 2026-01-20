import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_food_delivery/bottom_navigationbar/bottom_navigation.dart';
import 'package:hive_food_delivery/provider/cart_provider.dart';
import 'package:hive_food_delivery/provider/favourite_provider.dart';
import 'package:hive_food_delivery/provider/menu_provider.dart';
import 'package:hive_food_delivery/screens/Menu_screen.dart';

import 'package:hive_food_delivery/screens/home_screen.dart';
import 'package:hive_food_delivery/screens/login_screen.dart';
import 'package:hive_food_delivery/screens/on_boarding_screen.dart';
import 'package:hive_food_delivery/screens/register_screen.dart';
import 'package:hive_food_delivery/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await GetStorage.init();
  await Hive.initFlutter();
  await Hive.openBox('favourites');
  await Hive.deleteBoxFromDisk("favouritesBox");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    print("Pausing for 4 seconds");
    await Future.delayed(Duration(seconds: 2));
    FlutterNativeSplash.remove();
    print("un pausingg");
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavouriteProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNavigation(),
      ),
    );
  }
}

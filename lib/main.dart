import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_resto_menu/constants.dart';
import 'package:qr_resto_menu/page/menu_list.dart';
import 'package:qr_resto_menu/page/menu_list_image.dart';
import 'package:qr_resto_menu/product_add.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'menu_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => MenuState(Supabase.instance.client)),
        ChangeNotifierProvider(create: (context) => ProductAdd()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restomue',
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => const ChoiceMethod(),
            );
          case '/menu-list':
            final argument = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) => MenuList(argument: argument),
            );
          case '/menu-list-image':
            final argument = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) => MenuListImage(argument: argument),
            );
        }
        return null;
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
      };
}

class ChoiceMethod extends StatelessWidget {
  const ChoiceMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/menu-list-image',
                arguments: 'image'),
            child: const Text('Go To Menu with Image'),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () =>
                Navigator.pushNamed(context, '/menu-list', arguments: 'list'),
            child: const Text('Go To Menu with List'),
          ),
        ],
      ),
    );
  }
}

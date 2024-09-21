import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_resto_menu/constants.dart';
import 'package:qr_resto_menu/product_add.dart';
import 'package:qr_resto_menu/responsive/desktop_scaffold.dart';
import 'package:qr_resto_menu/responsive/mobile_scaffold.dart';
import 'package:qr_resto_menu/responsive/responsive_layour.dart';
import 'package:qr_resto_menu/responsive/tablet_scaffold.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'menu_state.dart';

final supabase = Supabase.instance.client;

Future<void> main() async {
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MenuState()),
        ChangeNotifierProvider(create: (context) => ProductAdd(0)),
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
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      home: const ResponsiveLayout(
        mobileScaffold: MobileScaffold(),
        tabletScaffold: TabletScaffold(),
        desktopScaffold: DesktopScaffold(),
      ),
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

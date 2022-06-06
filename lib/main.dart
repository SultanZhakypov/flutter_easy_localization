import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locale/translations/codegen_loader.g.dart';
import 'package:flutter_locale/translations/locale_keys.g.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(const InitLocaleWidget(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.title.tr()),
      ),
      body: Center(
        child: Column(
          children: [
            Text(LocaleKeys.hello.tr()),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () async {
              await context.setLocale(const Locale('en'));
            },
            child: const Text('English'),
          ),
          ElevatedButton(
            onPressed: () async {
              await context.setLocale(const Locale('ru'));
            },
            child: const Text('Русский'),
          ),
          ElevatedButton(
            onPressed: () async {
              await context.setLocale(const Locale('es'));
            },
            child: const Text('Spain'),
          ),
        ],
      ),
    );
  }
}

class InitLocaleWidget extends StatelessWidget {
  const InitLocaleWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [
        Locale('ru'),
        Locale('en'),
        Locale('es'),
      ],
      path: 'assets/translations',
      assetLoader: const CodegenLoader(),
      saveLocale: true,
      fallbackLocale: const Locale('en'),
      child: child,
    );
  }
}


import 'package:easy_localization/easy_localization.dart';
import 'package:elmoktaser_elshamel/blocs/auth_cubit/auth_cubit.dart';
import 'package:elmoktaser_elshamel/blocs/cart_cubit/cart_cubit.dart';
import 'package:elmoktaser_elshamel/blocs/chat_cubit/chat_cubit.dart';
import 'package:elmoktaser_elshamel/blocs/connectivity_bloc.dart/connectivity_bloc_cubit.dart';
import 'package:elmoktaser_elshamel/blocs/contest_cubit/contest_cubit.dart';
import 'package:elmoktaser_elshamel/blocs/courses_cubit/courses_cubit.dart';
import 'package:elmoktaser_elshamel/blocs/layout_cubit/layout_cubit.dart';
import 'package:elmoktaser_elshamel/blocs/notification_cubit/notification_cubit.dart';
import 'package:elmoktaser_elshamel/blocs/payment_cubit/payment_cubit.dart';
import 'package:elmoktaser_elshamel/blocs/profile_cubit/profile_cubit.dart';
import 'package:elmoktaser_elshamel/blocs/services/services_cubit.dart';
import 'package:elmoktaser_elshamel/blocs/tests_cubit/tests_cubit.dart';
import 'package:elmoktaser_elshamel/firebase_options.dart';
import 'package:elmoktaser_elshamel/routes/app_routes.dart';
import 'package:elmoktaser_elshamel/routes/route_generator.dart';
import 'package:elmoktaser_elshamel/shared/components/bloc_observer.dart';
import 'package:elmoktaser_elshamel/shared/network/local/cache_helper.dart';
import 'package:elmoktaser_elshamel/shared/network/remote/dio_helper.dart';
import 'package:elmoktaser_elshamel/shared/network/remote/notification_helper.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform
      );
 await FlutterDownloader.initialize(
    debug: true ,
    ignoreSsl: true 
  );

   
await NotificationHelper.init();
  
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await EasyLocalization.ensureInitialized();
  await CacheHelper.init();
  await DioHelper.init();

  BlocOverrides.runZoned(() {
    runApp(
      EasyLocalization(
          supportedLocales: const [Locale('ar'), Locale('en')],
          path: 'lang',
          startLocale: const Locale('ar'),
          fallbackLocale: const Locale('ar'),
          child: const MyApp()),
    );
  }, blocObserver: MyBlocObserver());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PaymentCubit()..getAllCoupons()),
        BlocProvider(create: (context) => ContestCubit()..getAllContest()),
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(
          create: (context) => NotificationCubit(),
        ),
           BlocProvider(
          create: (context) => ConnectivityCubit(),
        ),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => TestsCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => LayoutCubit()),
        BlocProvider(create: (context) => CoursesCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => ServicesCubit())
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return  MaterialApp(
              title: 'El-Moktaser El-Shamel',
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              theme: AppUi.themes.lightTheme,
              debugShowCheckedModeBanner: false,
              initialRoute: Routes.splash,
              onGenerateRoute: RouterGenarator.generateRoute,
            
        );
      }),
    );
  }
}

import 'package:elmoktaser_elshamel/layout/layout_screen.dart';
import 'package:elmoktaser_elshamel/modules/auth/login/login_screen.dart';
import 'package:elmoktaser_elshamel/modules/auth/register/register_screen.dart';
import 'package:elmoktaser_elshamel/modules/auth/verification/verification_screen.dart';
import 'package:elmoktaser_elshamel/modules/card_screen/card_screen.dart';
import 'package:elmoktaser_elshamel/modules/certificates_screens/certificate_view_screen.dart';
import 'package:elmoktaser_elshamel/modules/certificates_screens/certificates_screen.dart';
import 'package:elmoktaser_elshamel/modules/certificates_screens/pdf_review_screen.dart';
import 'package:elmoktaser_elshamel/modules/contest_screens/single_contest_screen.dart';
import 'package:elmoktaser_elshamel/modules/courses_screens/coures_screen.dart';
import 'package:elmoktaser_elshamel/modules/courses_screens/course_details_screens/course_details_screen.dart';
import 'package:elmoktaser_elshamel/modules/general_screens/about.dart';
import 'package:elmoktaser_elshamel/modules/contest_screens/competitions.dart';
import 'package:elmoktaser_elshamel/modules/general_screens/news/news_details_screen.dart';
import 'package:elmoktaser_elshamel/modules/general_screens/news/news_screen.dart';
import 'package:elmoktaser_elshamel/modules/general_screens/privacy_screen.dart';
import 'package:elmoktaser_elshamel/modules/general_screens/terms_and_conditions.dart';
import 'package:elmoktaser_elshamel/modules/general_test_screens/answers_view_screen.dart';
import 'package:elmoktaser_elshamel/modules/general_test_screens/multi_attempt_screen.dart';
import 'package:elmoktaser_elshamel/modules/general_test_screens/single_answer_view_screen.dart';
import 'package:elmoktaser_elshamel/modules/general_test_screens/test_trial_screen.dart';
import 'package:elmoktaser_elshamel/modules/layout_screens/chat_screens/chat_details_screen.dart';
import 'package:elmoktaser_elshamel/modules/layout_screens/chat_screens/chat_screen.dart';
import 'package:elmoktaser_elshamel/modules/layout_screens/home/home_screen.dart';
import 'package:elmoktaser_elshamel/modules/layout_screens/more_screen.dart';
import 'package:elmoktaser_elshamel/modules/layout_screens/personal_courses_screens/personal_courses_screen.dart';
import 'package:elmoktaser_elshamel/modules/layout_screens/profile_screens/account_statemanagement_screens/account_statement_screen.dart';
import 'package:elmoktaser_elshamel/modules/layout_screens/profile_screens/marketing_screen.dart';
import 'package:elmoktaser_elshamel/modules/layout_screens/profile_screens/password_editing_screen.dart';
import 'package:elmoktaser_elshamel/modules/layout_screens/profile_screens/profile_screen.dart';
import 'package:elmoktaser_elshamel/modules/layout_screens/profile_screens/profile_setting_screen.dart';
import 'package:elmoktaser_elshamel/modules/notification_screen/lost_internet_connection_screen.dart';
import 'package:elmoktaser_elshamel/modules/notification_screen/notifications_screen.dart';
import 'package:elmoktaser_elshamel/modules/payment_screen/payment_screen.dart';
import 'package:elmoktaser_elshamel/modules/personal_couse_details_screen/personal_coures_details_screen.dart';
import 'package:elmoktaser_elshamel/modules/tests_screens/main_tests_screen.dart';
import 'package:elmoktaser_elshamel/modules/tests_screens/single_test_info_screen.dart';
import 'package:elmoktaser_elshamel/modules/tests_screens/single_test_screen.dart';
import 'package:elmoktaser_elshamel/modules/welcome_screens/on_boarding_screen.dart';
import 'package:elmoktaser_elshamel/modules/welcome_screens/splash_screen.dart';
import 'package:elmoktaser_elshamel/routes/app_routes.dart';
import 'package:flutter/material.dart';

class RouterGenarator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case Routes.onBoarding:
        return MaterialPageRoute(
            builder: (context) => const OnBoardingScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case Routes.register:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case Routes.verification:
        return MaterialPageRoute(
            builder: (context) => const VerificationScreen());
      case Routes.termsAndConditions:
        return MaterialPageRoute(
            builder: (context) => const TermsAndConditions());
      case Routes.about:
        return MaterialPageRoute(builder: (context) => const AboutScreen());
      case Routes.more:
        return MaterialPageRoute(builder: (context) => const MoreScreen());
      case Routes.competitions:
        return MaterialPageRoute(builder: (context) => const ContestScreen());
      case Routes.layout:
        return MaterialPageRoute(builder: (context) => const LayoutScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case Routes.courses:
        return MaterialPageRoute(builder: (context) => const CoursesScreen());
      case Routes.courseDetails:
        return MaterialPageRoute(
            builder: (context) => CourseDetailsScreen(
                  coursesItem: settings.arguments,
                ));
      case Routes.news:
        return MaterialPageRoute(builder: (context) => const NewsScreen());
      case Routes.newsDetails:
        return MaterialPageRoute(
            builder: (context) => NewsDetailsScreen(
                  newsId: settings.arguments,
                ));
      case Routes.card:
        return MaterialPageRoute(builder: (context) => const CardScreen());
      case Routes.privacy:
        return MaterialPageRoute(builder: (context) => const PrivacyScreen());
      case Routes.personalCourses:
        return MaterialPageRoute(
            builder: (context) => const PersonalCoursesScreen());
      case Routes.personalCoursesDetails:
        return MaterialPageRoute(
            builder: (context) => PersonalCoursesDetailsScreen(
                  courseId: settings.arguments,
                ));
      case Routes.profile:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
      case Routes.testTrial:
        return MaterialPageRoute(
            builder: (context) => TestTrialScreen(
                  contentChild: settings.arguments,
                ));
      case Routes.certificate:
        return MaterialPageRoute(
            builder: (context) => const CertificateScreen());
      case Routes.certificateView:
        return MaterialPageRoute(
            builder: (context) => CertificateViewScreen(
                  certificateItem: settings.arguments,
                ));
      case Routes.passwordEditing:
        return MaterialPageRoute(
            builder: (context) => const PasswordEditingScreen());
      case Routes.profileSetting:
        return MaterialPageRoute(
            builder: (context) => const ProfileSettingScreen());
      case Routes.marketing:
        return MaterialPageRoute(builder: (context) => const MarketingScreen());
      case Routes.accountStatement:
        return MaterialPageRoute(
            builder: (context) => const AccountStatementScreen());
      case Routes.answersView:
        return MaterialPageRoute(
            builder: (context) => AnswersViewScreen(
                  sutdentExamResultModel: settings.arguments,
                ));
      case Routes.singleAnswerView:
        return MaterialPageRoute(
            builder: (context) => SingleAnswerViewScreen(
                  questionDetails: settings.arguments,
                ));
      case Routes.mainTests:
        return MaterialPageRoute(builder: (context) => const MainTestsScreen());
      case Routes.singleTestInfo:
        return MaterialPageRoute(
            builder: (context) => SingleTestInfoScreen(
                  childList: settings.arguments,
                ));
      case Routes.singleTest:
        return MaterialPageRoute(
            builder: (context) => SingleTestScreen(
                  contentChildId: settings.arguments,
                ));
      case Routes.chat:
        return MaterialPageRoute(builder: (context) => const ChatScreen());
      case Routes.chatDetails:
        return MaterialPageRoute(
            builder: (context) => const ChatDetailsScreen());
      case Routes.singleContest:
        return MaterialPageRoute(
            builder: (context) => SingleContestScreen(
                  contestId: settings.arguments,
                ));
      case Routes.multiAttemptScreen:
        return MaterialPageRoute(
            builder: (context) => MultiAttemptScreen(
                  attemptId: settings.arguments,
                ));
      case Routes.paymentScreen:
        return MaterialPageRoute(builder: (context) => const PaymentScreen());
      case Routes.pdfPreview:
        return MaterialPageRoute(builder: (context) => const PdfPreviewPage());
      case Routes.notificationScreen:
        return MaterialPageRoute(
            builder: (context) => const NotificationScreen());
      case Routes.lostInternetConnectionScreen:
        return MaterialPageRoute(
            builder: (context) => const LostInernetConnectionScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) => Scaffold(body: Container()));
  }
}

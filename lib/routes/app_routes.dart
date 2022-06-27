import 'package:elmoktaser_elshamel/layout/layout_screen.dart';
import 'package:elmoktaser_elshamel/modules/auth/login/login_screen.dart';
import 'package:elmoktaser_elshamel/modules/auth/register/register_screen.dart';
import 'package:elmoktaser_elshamel/modules/auth/verification/verification_screen.dart';
import 'package:elmoktaser_elshamel/modules/card_screen/card_screen.dart';
import 'package:elmoktaser_elshamel/modules/certificates_screens/certificates_screen.dart';
import 'package:elmoktaser_elshamel/modules/certificates_screens/pdf_review_screen.dart';
import 'package:elmoktaser_elshamel/modules/courses_screens/coures_screen.dart';
import 'package:elmoktaser_elshamel/modules/general_screens/about.dart';
import 'package:elmoktaser_elshamel/modules/contest_screens/competitions.dart';
import 'package:elmoktaser_elshamel/modules/general_screens/news/news_screen.dart';
import 'package:elmoktaser_elshamel/modules/general_screens/privacy_screen.dart';
import 'package:elmoktaser_elshamel/modules/general_screens/terms_and_conditions.dart';
import 'package:elmoktaser_elshamel/modules/general_test_screens/general_test_screen.dart';
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
import 'package:elmoktaser_elshamel/modules/tests_screens/main_tests_screen.dart';
import 'package:elmoktaser_elshamel/modules/welcome_screens/on_boarding_screen.dart';
import 'package:elmoktaser_elshamel/modules/welcome_screens/splash_screen.dart';

abstract class Routes {
 
  static final routes = {
    competitions: (context) => const ContestScreen(),
    layout: (context) => const LayoutScreen(),
    more: (context) => const MoreScreen(),
    splash: (context) => const SplashScreen(),
    about: (context) => const AboutScreen(),
    verification: (context) => const VerificationScreen(),
    onBoarding: (context) => const OnBoardingScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    termsAndConditions: (context) => const TermsAndConditions(),
    news: (context) => const NewsScreen(),
    home: (context) => const HomeScreen(),
    courses: (context) => const CoursesScreen(),
    card: (context) => const CardScreen(),
    privacy: (context) => const PrivacyScreen(),
    personalCourses: (context) => const PersonalCoursesScreen(),
    profile: (context) => const ProfileScreen(),
    generalTest: (context) => const GeneralTestScreen(),
    certificate: (context) => const CertificateScreen(),
    passwordEditing: (context) => const PasswordEditingScreen(),
    profileSetting: (context) => const ProfileSettingScreen(),
    marketing: (context) => const MarketingScreen(),
    accountStatement: (context) => const AccountStatementScreen(),
    mainTests: (context) => const MainTestsScreen(),
    chat: (context) => const ChatScreen(),
    paymentScreen:(context)=>const PaymentScreen(),
    chatDetails: (context) => const ChatDetailsScreen(),
    pdfPreview:(context)=>const PdfPreviewPage(),
    notificationScreen:(context)=>const NotificationScreen(),
        lostInternetConnectionScreen:(context)=>const LostInernetConnectionScreen()


  };
  static const lostInternetConnectionScreen='/lost_internet_connection';
  static const notificationScreen='/notification_screen';
  static const pdfPreview='/pdf_preview';
  static const paymentScreen='/payment_screen';
  static const multiAttemptScreen='/multi_attempt_screen';
static const singleContest='/single_contest';
  static const chat = '/chat';
  static const chatDetails = '/chat_details';
  static const singleTest = '/single_test';
  static const mainTests = '/main_test';
  static const singleTestInfo = '/single_test_info';
  static const singleAnswerView = '/single_answer_view';
  static const answersView = '/answers_view';
  static const accountStatement = '/account_statement';
  static const marketing = '/marketing';
  static const profileSetting = '/profile_setting';
  static const passwordEditing = '/password_editing';
  static const certificate = '/certificate';
  static const certificateView = '/certificate_view';
  static const testTrial = '/test_trial';
  static const generalTest = '/general_test';
  static const profile = '/profile';
  static const personalCoursesDetails = '/personal_courses_details_screen';
  static const privacy = '/privacy';
  static const personalCourses = '/personal_courses';
  static const card = '/card';
  static const courses = '/courses';
  static const courseDetails = '/CourseDetails';
  static const more = '/more';
  static const home = '/home';
  static const layout = '/layout';
  static const competitions = '/competitions';
  static const news = '/news';
  static const newsDetails = '/news_details';
  static const about = '/about';
  static const splash = '/';
  static const termsAndConditions = '/terms_and_conditions';
  static const onBoarding = '/onBoarding';
  static const login = '/login';
  static const register = '/register';
  static const verification = '/verification';
}

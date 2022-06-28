import 'package:elmoktaser_elshamel/routes/_exports.dart';

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

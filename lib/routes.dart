import 'package:churchappenings/pages/calender/calendar-page.dart';
import 'package:churchappenings/pages/church/add_new_church_page.dart';
import 'package:churchappenings/pages/community_outreach/community_outreach_page.dart';
import 'package:churchappenings/pages/departments/departments-page.dart';
import 'package:churchappenings/pages/more/info/about-churchappening-page.dart';
import 'package:churchappenings/pages/more/info/about-sda-page.dart';
import 'package:churchappenings/pages/more/info/privacy-policy.dart';
import 'package:churchappenings/pages/more/info/terms-of-service-page.dart';
import 'package:churchappenings/pages/bulletins/bulletins-page.dart';
import 'package:churchappenings/pages/bulletins/postings/postings-page.dart';
import 'package:churchappenings/pages/bulletins/single-bulletin/single-bulletin-page.dart';
import 'package:churchappenings/pages/home/home-page.dart';
import 'package:churchappenings/pages/initial/initial-page.dart';
import 'package:churchappenings/pages/login/login-page.dart';
import 'package:churchappenings/pages/more/more-page.dart';
import 'package:churchappenings/pages/photogallery/photogallery-page.dart';
import 'package:churchappenings/pages/polling/polls-page.dart';
import 'package:churchappenings/pages/register/register-page.dart';
import 'package:churchappenings/pages/search/favourites-church/favourites-church-page.dart';
import 'package:churchappenings/pages/search/search-page.dart';
import 'package:churchappenings/pages/splash/splash-page.dart';
import 'package:churchappenings/pages/tools/announcement/announcement-page.dart';
import 'package:churchappenings/pages/tools/birthday-board/birthday-board-page.dart';
import 'package:churchappenings/pages/tools/guestbook/guestbook-page.dart';
import 'package:churchappenings/pages/tools/invite/invite-page.dart';
import 'package:churchappenings/pages/tools/jobs/jobs-page.dart';
import 'package:churchappenings/pages/tools/member-transfer/member-transfer-page.dart';
import 'package:churchappenings/pages/tools/members/members-page.dart';
import 'package:churchappenings/pages/tools/my-events/my-events-page.dart';
import 'package:churchappenings/pages/tools/pastor-calendar/pastor-calendar-page.dart';
import 'package:churchappenings/pages/tools/pastor-search/pastor-search-page.dart';
import 'package:churchappenings/pages/tools/prayer/prayer-page.dart';
import 'package:churchappenings/pages/tools/prayerometer/prayerometer-page.dart';
import 'package:churchappenings/pages/tools/sermon-notes/sermon-notes-page.dart';
import 'package:churchappenings/pages/tools/stewardship/stewardship-page.dart';
import 'package:churchappenings/pages/tools/tools-page.dart';
import 'package:get/get.dart';

class Routes {
  //Auth
  static const String initial = '/initial';
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';

  static const String home = '/home';

  // Polling
  static const String polls = '/polls';

  // Tools
  static const String tools = '/tools';
  static const String stewardship = '/stewardship';
  static const String announcements = '/announcements';
  static const String department = '/department';
  static const String prayer = '/prayer';
  static const String prayerometer = '/prayerometer';
  static const String pastorSearch = '/pastorSearch';
  static const String pastorCalendar = '/pastorCalendar';
  static const String members = '/members';
  static const String sermonNotes = '/sermonNotes';
  static const String birthdayBoard = '/birthdayBoard';
  static const String photoGallery = '/photoGallery';
  static const String guestbook = '/guestbook';
  static const String jobs = '/jobs';
  static const String invite = '/invite';
  static const String transfer = '/transfer';

  // -- My Events
  static const String myevent = '/myevent';

  // Search
  static const String search = '/search';
  static const String favChurches = '/favChurches';

  // Bulleting
  static const String bulletins = '/bulletins';
  static const String singleBulletin = '/singleBulletin';
  static const String postingsBulletin = '/postingsBulletin';
  static const String calendar = '/calendar';

  static const String more = '/more';

  // Library
  static const String bibles = '/bibles';
  static const String songbook = '/songbook';

  static const String aboutChurchappening = '/aboutChurchappening';
  static const String aboutSDA = '/aboutSDA';
  static const String termsOfService = '/termsOfService';
  static const String memberTransfer = '/memberTransfer';
  static const String privacyPolicy = '/privacyPolicy';
  static const String communityOutreach = '/communityOutreach';

  //add new church
  static const String addNewChurch = '/addNewChurch';

  // Routes Defination
  static List<GetPage<dynamic>> pages = [
    GetPage(name: initial, page: () => InitialPage()),
    GetPage(name: splash, page: () => SplashPage()),
    GetPage(name: photoGallery, page: () => PhotoGalleryPage()),
    GetPage(name: prayerometer, page: () => PrayeroMeterPage()),
    GetPage(name: invite, page: () => InvitePage()),
    GetPage(name: transfer, page: () => MemberTransferPage()),
    GetPage(name: jobs, page: () => JobsPage()),
    GetPage(name: guestbook, page: () => GuestBookPage()),
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: register, page: () => RegisterPage()),
    GetPage(name: myevent, page: () => MyEventPage()),
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: calendar, page: () => CalendarPage()),
    GetPage(name: tools, page: () => ToolsPage()),
    GetPage(name: sermonNotes, page: () => SermonNotesPage()),
    GetPage(name: stewardship, page: () => StewardshipPage()),
    GetPage(name: birthdayBoard, page: () => BirthdayBoardPage()),
    GetPage(name: bulletins, page: () => BulletinsPage()),
    GetPage(name: singleBulletin, page: () => SingleBulletinPage()),
    GetPage(name: postingsBulletin, page: () => PostingsPage()),
    GetPage(name: more, page: () => MorePage()),
    GetPage(name: search, page: () => SearchPage()),
    GetPage(name: favChurches, page: () => FavouritesChurchPage()),
    GetPage(name: polls, page: () => PollsPage()),
    GetPage(name: announcements, page: () => AnnouncementPage()),
    GetPage(name: aboutChurchappening, page: () => AboutChurchappeningPage()),
    GetPage(name: aboutSDA, page: () => AboutSDAPage()),
    GetPage(name: termsOfService, page: () => TermsOfServicePage()),
    GetPage(name: privacyPolicy, page: () => PrivacyPolicyPage()),
    GetPage(name: department, page: () => DepartmentsPage()),
    GetPage(name: prayer, page: () => PrayerPage()),
    GetPage(name: pastorCalendar, page: () => PastorCalendarPage()),
    GetPage(name: pastorSearch, page: () => PastorSearchPage()),
    GetPage(name: members, page: () => MembersPage()),
    GetPage(name: communityOutreach, page: () => CommunityOutreachPage()),
    GetPage(name: memberTransfer, page: () => MemberTransferPage()),
    GetPage(name: addNewChurch, page: () => AddNewChurchPage())
  ];
}

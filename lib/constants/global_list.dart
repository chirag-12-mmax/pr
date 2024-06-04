import 'package:shah_investment/constants/images_route.dart';
import 'package:shah_investment/referral_module/referral_titles.dart';
import 'package:shah_investment/trades_module/trade_titles.dart';

class GlobalList {
  static List drawerList = [
    {
      "id": 1,
      "icon": PickImages.homeDrawerIcon,
      "title": TradeTitles.home,
    },
    {
      "id": 2,
      "icon": PickImages.referralIcon,
      "title": ReferralTitles.referralHistoryTitle,
    },
    {
      "id": 3,
      "icon": PickImages.paymentHistoryIcon,
      "title": TradeTitles.paymentHistory
    },
    {
      "id": 4,
      "icon": PickImages.feedIcon,
      "title": TradeTitles.feed,
    },
    {
      "id": 5,
      "icon": PickImages.notification,
      "title": TradeTitles.notification,
    },
    {
      "id": 6,
      "icon": PickImages.settingIcon,
      "title": TradeTitles.setting,
    },
    {
      "id": 7,
      "icon": PickImages.privacyPolicyIcon,
      "title": TradeTitles.privacyPolicy,
    },
    {
      "id": 8,
      "icon": PickImages.termsAndConditionsIcon,
      "title": TradeTitles.termsAndConditions,
    },
    // {
    //   "id": 9,
    //   "icon": PickImages.refundsReturnPolicyIcon,
    //   "title": TradeTitles.refundReturnPolicy,
    // },
    {
      "id": 10,
      "icon": PickImages.logoutIcon,
      "title": TradeTitles.logout,
    },
  ];

  static List<String> tabList = [
    "Popular",
    "Latest",
    "All",
  ];

  static Map<String, String> contentTypes = {
    'pdf': 'application/pdf',
    'doc': 'application/msword',
    'docx':
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'jpg': 'image/jpeg',
    'jpeg': 'image/jpeg',
    'png': 'image/png',
    'gif': 'image/gif',
    // 'heif': 'image/jpeg',
    // 'heic': 'image/jpeg'
    // Add more extensions and content types as needed
  };

  static List<dynamic> socialMediaIconList = [
    {"id": 1, "title": PickImages.whatAppIcon},
    {"id": 2, "title": PickImages.instagramIcon},
    {"id": 3, "title": PickImages.faceBookIcon},
    {"id": 4, "title": PickImages.telegramIcon},
    {"id": 5, "title": PickImages.horizontalThreeDotIcon},
  ];
}

// ignore_for_file: non_constant_identifier_names

class APIRoutes {
  static String BASEURL = 'http://api.application.shahsinvestment.com/';

  // image upload url
  static String imageUploadApiRoute = "upload/image";

  //===================Auth module
  static String sendOtpApiRoute = "user/mobileLogin";
  static String verifyOtpApiRoute = "user/verifyOTP";
  static String signUpApiRoute = "user/mobileSignup";
  static String softDeleteApiRoute = "user/softDelete";
  static String hardDeleteApiRoute = "user/hardDelete";

  //===================Update Profile
  static String profileUpdateApiRoute = "user/profileUpdate";
  static String getSingleProfileApiRoute = "user/getSingleUser";

  // ===================Trade module
  static String getTipDataApiRoute = "admin/getTips";
  static String getSingleTipDataApiRoute = "admin/getSingleTips/";
  static String getSubscriptionDataApiRoute = "user/getSubscription";
  static String getPreviousTipsDataApiRoute = "user/getPreviousTips";

  // ===================Feed module
  static String addFeedBackApiRoute = "user/addFeedback";
  static String getFeedBackApiRoute = "user/getFeedbackOfUser";
  static String addLinkOnFeedBackApiRoute = "user/addLike";
  static String removeLinkOnFeedBackApiRoute = "user/removeLike";

  // ===================Referral module
  static String referralHistoryApiRoute = "user/getReferralUser";
  static String addReportOnFeedBackApiRoute = "user/addReport";
  static String blockFeedBackApiRoute = "user/blockFeed";
  static String getRaferdayApiRoute = "user/getReferDay";

  //======================Payment History
  static String getPaymentHistoryApiRoute = "user/getPayment";

  //===================Notification
  static String notificationApiRoute = "user/getNotification";
  //=========================Refresh Token
  static String refreshTokenApiRoute = "user/refreshToken";

  // auto cut payment
  static String autoCutPaymentApiRoute = "user/autoCut";

  // Buy SubscriptionPlan
  static String buySubscriptionPlanApiRoute = "user/addSubscriptionPlan";

  // dynamic tab in home page
  static String getTabApiRoute = "admin/getTabs";

  // subscription Offer api
  static String getSubscriptionOfferApiRoute = "admin/getOffer"; 
}

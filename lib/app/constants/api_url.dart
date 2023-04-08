// TODO: thông tin API
// ignore_for_file: constant_identifier_names

class ApiUrl {
  static const uploadUrl = '';
  static const connectionTimeout = 15000;
  static const receiveTimeout = 15000;
  static const baseUrl = 'http://demo80.ninavietnam.com.vn/test_app_api/';
  static const baseApi = 'api/addons2.php?type=';

  static const refreshToken = '<url_refreshToken>';

  static const loginAuth = '<url_loginAuth>';
  static const registerAuth = '<url_registerAuth>';
  static const sendCodePassword = '<url_sendCodePassword>';
  static const forgotPassword = '<url_forgotPassword>';

  static const updateProfile = '<url_updateProfile>';
  static const uploadAvatar = '<url_uploadAvatar>';
  static const profileAuth = '<url_profileAuth>';
  static const profileUpdate = '<url_profileUpdate>';
  static const userProfile = '<url_userProfile>';

  static const getService = 'service';
  static const getServiceWithList = "$getService&id_list=";
  static const getServiceList = "service-list";
  static const getCriteria = "criteria";
  static const getSlideshow = "slide-show";
  static const getSearch = "search";
  static const getHotKeyword = "hot-keyword";
  static const getServiceDetail = "service-detail";

  static const upload_news_l = "${baseUrl}upload/news/";
  static const upload_product_l = "$baseUrl/upload/product/";
  static const upload_photo_l = "$baseUrl/upload/photo/";
}

class Apipath {
  static const String BASH_IMG =
      "https://alphawizztest.tk/Mobile_Intregration/Admin/uploads/";
  //
  static const String BASH_URL =
      "https://alphawizztest.tk/Mobile_Intregration/api/";
  static const String login_url = BASH_URL + 'Authentication/login';
  static const String registration_url =
      BASH_URL + 'Authentication/registration';
  static const String otp_verify_url = BASH_URL + 'Authentication/checkUserOtp';
  static const String get_scan_Info_url = BASH_URL + 'Products/Product_details';
  static const String customer_from_url =
      BASH_URL + 'Authentication/customer_datail';
  static const String scan_history_info =
      BASH_URL + 'Products/product_information';
  static const String get_profile_url =
      BASH_URL + 'Authentication/get_profilmechanic';
  static const String update_profile_url =
      BASH_URL + 'Authentication/update_profile';

  static const String get_issue_history_url = BASH_URL + 'Products/isseue';
  static const String get_product_details_scan = BASH_URL + 'Products/Product_details_scan';
  static const String resend_otp = BASH_URL + 'Authentication/resend_otp';
  static const String image_gallery_url = BASH_URL + 'Products/getCatalogue';
  static const String replace_battary_url = BASH_URL + 'Products/replacementbarcode';
  static const String complent_box_request_url = BASH_URL + 'Products/replacement';
}

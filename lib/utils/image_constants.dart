class AllImages {
  AllImages._();
  static final AllImages _instance = AllImages._();
  factory AllImages() => _instance;

  String image = 'assets/image';
  String logo = 'assets/images/logo.png';
  String login = 'assets/images/login.png';
  String signup = 'assets/images/signup.png';
  String imageError = 'assets/images/error.png';
  String postorLogoError = 'assets/images/postor_logo_error.png';
  String kDefaultImage = 'assets/images/error.png';
  String imageNotFound =
      "https://www.ncenet.com/wp-content/uploads/2020/04/no-image-png-2.png";
  String onboarding_1_backGroundImage =
      'assets/images/onboarding/spiderman.png';
  String onboarding_1_featureImage =
      "assets/images/onboarding/onboarding_1.jpg";

  String onboarding_2_backGroundImage =
      'assets/images/onboarding/rick_morty_t.png';
  String onboarding_2_featureImage =
      "assets/images/onboarding/onboarding_3_1.jpg";
  String onboarding_3_backGroundImage = 'assets/images/onboarding/deadpool.png';
  String onboarding_3_featureImage =
      "assets/images/onboarding/onboarding_2.jpg";
}

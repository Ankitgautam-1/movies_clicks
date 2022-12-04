import 'dart:math';
import 'dart:ui';
import 'package:go_router/go_router.dart';
import 'package:movies_clicks/utils/string_const.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movies_clicks/common_export.dart';
import 'package:movies_clicks/utils/screen_rotation_lock.dart';
import 'package:movies_clicks/widgets/button.widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with PortraitStatefulModeMixin<OnboardingScreen> {
  final PageController pageController = PageController(
    initialPage: 0,
  );
  int index = 0;
  double dx = 0;
  double dy = 0;

  double pageOffset = 0.0;
  void pageControllerListner() {
    setState(() {
      pageOffset = pageController.offset;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController.addListener(pageControllerListner);
  }

  @override
  void dispose() {
    pageController.removeListener(pageControllerListner);
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: ColorConstants().darkBackgroundColor,
        body: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 700,
                          child: Stack(
                            children: [
                              Positioned(
                                child: PageView(
                                  controller: pageController,
                                  onPageChanged: (i) {
                                    if (i == 2) {
                                      setState(() {
                                        dx = -0.25;
                                        dy = 0;
                                        index = i;
                                      });
                                    } else {
                                      setState(() {
                                        dx = 0;
                                        dy = 0;
                                        index = i;
                                      });
                                    }
                                  },
                                  children: [
                                    Screens(
                                      imagePath:
                                          AllImages().onboarding_1_featureImage,
                                      bottomImageUrl: AllImages()
                                          .onboarding_1_backGroundImage,
                                      pageOffset: pageOffset,
                                      fraction: -0.85,
                                      title: StringConst.onboard_1_title,
                                      subTitle: StringConst.onboard_1_subtitle,
                                    ),
                                    Screens(
                                      imagePath:
                                          AllImages().onboarding_2_featureImage,
                                      bottomImageUrl: AllImages()
                                          .onboarding_2_backGroundImage,
                                      pageOffset: pageOffset,
                                      fraction: 0.18,
                                      title: StringConst.onboard_2_title,
                                      subTitle: StringConst.onboard_2_subtitle,
                                    ),
                                    Screens(
                                      imagePath:
                                          AllImages().onboarding_3_featureImage,
                                      bottomImageUrl: AllImages()
                                          .onboarding_3_backGroundImage,
                                      pageOffset: pageOffset,
                                      fraction: 0.10,
                                      title: StringConst.onboard_3_title,
                                      subTitle: StringConst.onboard_3_subtitle,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    AnimatedContainer(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).padding.bottom + 40,
                          left: 20,
                          right: 20),
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      alignment: Alignment(dx, dy),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmoothPageIndicator(
                            controller: pageController,
                            count: 3,
                            effect: ExpandingDotsEffect(
                              dotHeight: 12,
                              dotWidth: 12,
                              activeDotColor: Theme.of(context).primaryColor,
                              strokeWidth: 5,
                            ),
                          ),
                          SizedBox(
                            width: index == 2 ? 40 : 0,
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.easeInOut,
                            height: 40,
                            width: index == 2 ? 200 : 0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 40.0),
                              child: index == 2
                                  ? SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: InkWell(
                                          child: CustomButton(
                                        index: index,
                                        onPressed: () async {
                                          SharedPrefs sharedPrefs =
                                              SharedPrefs.instance;
                                          sharedPrefs
                                              .setShouldSkipOnboard(true);
                                          GoRouter.of(context)
                                              .replace('/homepage');
                                        },
                                      )),
                                    )
                                  : Container(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}

class Screens extends StatefulWidget {
  const Screens({
    super.key,
    required this.imagePath,
    required this.bottomImageUrl,
    required this.pageOffset,
    required this.fraction,
    required this.title,
    required this.subTitle,
  });
  final String imagePath;
  final String bottomImageUrl;
  final String title;
  final String subTitle;
  final double pageOffset;
  final double fraction;

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late CurvedAnimation _curve;
  void updateValues() {
    setState(() {});
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _curve =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animation = Tween<double>(begin: 0, end: -40).animate(_curve);
    animation.addListener(updateValues);
    animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    animationController.removeListener(updateValues);
    _curve.dispose();

    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // double offset = pageController.hasClients ? pageController.offset : 0;
    // double leftOffSet = -0.85 * offset;
    double opc = (1 / (-40 / animation.value));
    double op = min(1, max(0.0000001, 1 - opc));
    return Column(
      children: [
        SizedBox(
          height: 550,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned.fill(
                top: 0,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 60.0),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          widget.imagePath,
                          height: 600,
                          color: Colors.black26,
                          colorBlendMode: BlendMode.darken,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Positioned.fill(
                          child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                                begin: FractionalOffset.topCenter,
                                end: FractionalOffset.bottomCenter,
                                colors: [
                                  Colors.grey.withOpacity(0.0),
                                  Colors.grey.withOpacity(0.0),
                                  ColorConstants()
                                      .darkBackgroundColor
                                      .withOpacity(1),
                                ],
                                stops: [
                                  0.0,
                                  0.8,
                                  1.0
                                ])),
                      )),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: widget.fraction * widget.pageOffset,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Transform.translate(
                    offset: Offset(0, animation.value),
                    child: SimpleShadow(
                      offset: const Offset(0, 10),
                      opacity: op,
                      child: Image.asset(
                        widget.bottomImageUrl,
                        width: 280,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title.toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                widget.subTitle.toUpperCase(),
                style: TextStyle(
                    color: Colors.grey.withOpacity(0.8),
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SimpleShadow extends StatelessWidget {
  final Widget child;
  final double opacity;
  final double sigma;
  final Color color;
  final Offset offset;

  const SimpleShadow({
    super.key,
    required this.child,
    this.opacity = 0.5,
    this.sigma = 2,
    this.color = Colors.black,
    this.offset = const Offset(2, 2),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Transform.translate(
          offset: offset,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(
                sigmaY: sigma, sigmaX: sigma, tileMode: TileMode.decal),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.transparent,
                  width: 0,
                ),
              ),
              child: Opacity(
                opacity: opacity,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(color, BlendMode.srcATop),
                  child: child,
                ),
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

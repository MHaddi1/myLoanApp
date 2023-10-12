import 'dart:async';
import 'package:flutter/material.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:get/get.dart';
import 'package:loan_app/consts/colors.dart';
import 'package:loan_app/widgets/my_button.dart';
import 'package:loan_app/widgets/my_text_field.dart';
import '../controllers/ads_controller.dart';

class LoanScreen extends StatefulWidget {
  final String idfa;

  const LoanScreen({Key? key, this.idfa = ''}) : super(key: key);

  @override
  LoanScreenState createState() => LoanScreenState();
}

class LoanScreenState extends State<LoanScreen> {
  final adsController = Get.put(AdsController());
  // final ct = TextEditingController();
//   bool _isInterstitialAdLoaded = false;
//   bool _isRewardedAdLoaded = false;
  bool acceptedTerms = false;

//   static const String _sdkKey =
//       "wnthEbggxFvZP9qdyoZ3sKTWAxNfGt3HEcbGArhxU7SWbcwBstJ8aDGXsq4HWXP1KXyUf4zlO9fGPLBreTn65F";

//   final String _interstitialAdUnitId =
//       Platform.isAndroid ? "ANDROID_INTER_AD_UNIT_ID" : "IOS_INTER_AD_UNIT_ID";
//   final String _rewardedAdUnitId = Platform.isAndroid
//       ? "ANDROID_REWARDED_AD_UNIT_ID"
//       : "IOS_REWARDED_AD_UNIT_ID";
//   final String _bannerAdUnitId = Platform.isAndroid
//       ? "ANDROID_BANNER_AD_UNIT_ID"
//       : "IOS_BANNER_AD_UNIT_ID";
//   final String _mrecAdUnitId =
//       Platform.isAndroid ? "ANDROID_MREC_AD_UNIT_ID" : "IOS_MREC_AD_UNIT_ID";
//   final String _nativeAdUnitId = Platform.isAndroid
//       ? "ANDROID_NATIVE_AD_UNIT_ID"
//       : "IOS_NATIVE_AD_UNIT_ID";

// // Create states
//   var _isInitialized = false;
//   var _interstitialLoadState = AdLoadState.notLoaded;
//   var _interstitialRetryAttempt = 0;
//   var _rewardedAdLoadState = AdLoadState.notLoaded;
//   var _rewardedAdRetryAttempt = 0;

//   var _statusText = "";
  Widget _currentAd = const SizedBox(
    width: 0.0,
    height: 0.0,
  );

  late Timer _adsTimer;

  @override
  void initState() {
    super.initState();
    adsController.initializePlugin();
     _adsTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
    //adsController.loadAndShowAds();
    adsController.loadInterstitialAd();
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _adsTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: back,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: SizedBox(
        height: Get.height,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Your Credit Limit: ",
                    style: TextStyle(color: mainColor),
                  ),
                  const Icon(Icons.money),
                  const Text("100,000"),
                  const SizedBox(
                    width: 5,
                  ),
                  Image.asset("assets/icons/question.png"),
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 15.0,
                            ),
                            child: Column(
                              children: [
                                MyTextFields(
                                  myController: adsController.ct.value,
                                  hintText: "Enter Loan Amount",
                                  obscureText: false,
                                  suffixIconData: Icons.money,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text("Add Quick: "),
                                    const SizedBox(
                                      width: 7.0,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: feildColor,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("10,000"),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Icon(Icons.money),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: feildColor,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: const Row(
                                        children: [
                                          Text("50,00"),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Icon(Icons.money),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text("Applicable Interest rate: "),
                                    const SizedBox(
                                      width: 7.0,
                                    ),
                                    const SizedBox(
                                      height: 7.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          "15%",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Image.asset(
                                            "assets/icons/question.png"),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                MyTextFields(
                                  myController: adsController.ct.value,
                                  hintText: "Extra Payment",
                                  obscureText: false,
                                  suffixIconData: Icons.money,
                                  labelText: "Extra Payment (Optional)",
                                ),
                                const SizedBox(
                                  height: 40.0,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.10,
                                  decoration: BoxDecoration(
                                    color: feildColor,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Monthly Payment",
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            Text(
                                              "NIL",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            VerticalDivider(
                                              thickness: 2,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "No of Payments",
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            Text(
                                              "NIL",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            VerticalDivider(
                                              thickness: 2,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Total Payback",
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            Text(
                                              "NIL",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            VerticalDivider(
                                              thickness: 2,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      value: acceptedTerms,
                                      onChanged: (value) {
                                        setState(() {
                                          acceptedTerms = value!;
                                        });
                                      },
                                    ),
                                    const Text(
                                        "I accept the Terms and Conditions"),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                MyButton(
                                  text: "Apply now",
                                  onTap: acceptedTerms
                                      ? () {
                                          // Handle Apply Now button press when Terms and Conditions are accepted
                                          // Get.toNamed(Routes.detailScreen);
                                          _showBannerAd();
                                        }
                                      : null, // Disable the button when Terms and Conditions are not accepted
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Align(
                  alignment: Alignment(0, 1.0),
                  child: _currentAd,
                ),
              ),
            ],
          ),
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      //floatingActionButton:
    );
  }

  // Widget _getAllButtons() {
  //   return GridView.count(
  //     shrinkWrap: true,
  //     crossAxisCount: 2,
  //     childAspectRatio: 3,
  //     children: <Widget>[
  //       _getRaisedButton(title: "Banner Ad", onPressed: _showBannerAd),
  //       _getRaisedButton(title: "Native Ad", onPressed: _showNativeAd),
  //       _getRaisedButton(
  //           title: "Native Banner Ad", onPressed: _showNativeBannerAd),
  //       _getRaisedButton(
  //           title: "Intestitial Ad", onPressed: _showInterstitialAd),
  //       _getRaisedButton(title: "Rewarded Ad", onPressed: _showRewardedAd),
  //     ],
  //   );
  // }

  Widget _getRaisedButton({required String title, void Function()? onPressed}) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // _showInterstitialAd() {
  //   if (_isInterstitialAdLoaded == true)
  //     FacebookInterstitialAd.showInterstitialAd();
  //   else
  //     print("Interstial Ad not yet loaded!");
  // }

  // _showRewardedAd() {
  //   if (_isRewardedAdLoaded == true)
  //     FacebookRewardedVideoAd.showRewardedVideoAd();
  //   else
  //     print("Rewarded Ad not yet loaded!");
  // }

  _showBannerAd() {
    setState(() {
      _currentAd = FacebookBannerAd(
        // placementId: "YOUR_PLACEMENT_ID",
        placementId:
            "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047", //testid
        bannerSize: BannerSize.STANDARD,
        listener: (result, value) {
          print("Banner Ad: $result -->  $value");
        },
      );
    });
  }

  _showNativeBannerAd() {
    setState(() {
      _currentAd = _nativeBannerAd();
    });
  }

  Widget _nativeBannerAd() {
    return FacebookNativeAd(
      // placementId: "YOUR_PLACEMENT_ID",
      placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2964953543583512",
      adType: NativeAdType.NATIVE_BANNER_AD,
      bannerAdSize: NativeBannerAdSize.HEIGHT_100,
      width: double.infinity,
      backgroundColor: Colors.blue,
      titleColor: Colors.white,
      descriptionColor: Colors.white,
      buttonColor: Colors.deepPurple,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      listener: (result, value) {
        print("Native Banner Ad: $result --> $value");
      },
    );
  }

  _showNativeAd() {
    setState(() {
      _currentAd = _nativeAd();
    });
  }

  Widget _nativeAd() {
    return FacebookNativeAd(
      placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2964952163583650",
      adType: NativeAdType.NATIVE_AD_VERTICAL,
      width: double.infinity,
      height: 300,
      backgroundColor: Colors.blue,
      titleColor: Colors.white,
      descriptionColor: Colors.white,
      buttonColor: Colors.deepPurple,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      listener: (result, value) {
        print("Native Ad: $result --> $value");
      },
      keepExpandedWhileLoading: true,
      expandAnimationDuraion: 1000,
    );
  }
}

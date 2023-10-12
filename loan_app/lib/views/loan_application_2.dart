import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_app/routes/routing.dart';
import 'package:loan_app/widgets/my_button.dart';
import 'package:loan_app/widgets/my_option.dart';
import 'package:loan_app/widgets/my_text_field.dart';
import '../consts/colors.dart';

//SNT5-P7PL-5P2J-J0SH

class WorkDetail extends StatefulWidget {
  const WorkDetail({super.key});

  @override
  State<WorkDetail> createState() => _WorkDetailState();
}

class _WorkDetailState extends State<WorkDetail> {
  // late BannerAd bannerAd;
  // bool isAdsLoaded = false;
  // initBannerAd() {
  //   bannerAd = BannerAd(
  //       size: AdSize.banner,
  //       adUnitId: '',
  //       listener: BannerAdListener(
  //         onAdLoaded: (ads) {
  //           setState(() => isAdsLoaded = true);
  //         },
  //         onAdFailedToLoad: (ad, error) {
  //           bannerAd.dispose();
  //           print(error);
  //         },
  //       ),
  //       request: const AdRequest());
  //   bannerAd.load();
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   initBannerAd();
  // }

  @override
  Widget build(BuildContext context) {
    final TextEditingController ct = TextEditingController();
    // final controller = Get.find<>();
    return Scaffold(
      backgroundColor: back,
      appBar: AppBar(
        backgroundColor: back,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Slider(
                activeColor: mainColor,
                inactiveColor: mainColor,
                thumbColor: mainColor,
                secondaryActiveColor: mainColor,
                value: 50,
                onChanged: null,
                min: 0,
                max: 100,
                divisions: 10,
                label: '25',
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Business Information",
                    style: TextStyle(
                      fontSize: 11,
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Further Details",
                    style: TextStyle(
                      fontSize: 11,
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Document Upload",
                    style: TextStyle(
                      fontSize: 11,
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Review",
                    style: TextStyle(
                      fontSize: 11,
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 16.0,
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: Card(
                    elevation: 3,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 12.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Push content to top and button to the bottom
                        children: [
                          const SizedBox(
                            height: 7.0,
                          ),
                          MyTextFields(
                            myController: ct,
                            hintText: "Business Name",
                            obscureText: false,
                            labelText: "Business Name",
                          ),
                          MyTextFields(
                            myController: ct,
                            hintText: "Business Email",
                            obscureText: false,
                            labelText: "Business Email",
                          ),
                          MyTextFields(
                            myController: ct,
                            hintText: "Business Address",
                            obscureText: false,
                            labelText: "Business Address",
                          ),
                          MyTextFields(
                            myController: ct,
                            hintText: "Your Name",
                            obscureText: false,
                            labelText: "Your Name",
                          ),
                          MyOption(
                            options: const ["CFO", "employee", "Manager"],
                            selectedOption: "CFO",
                            onChanged: (val) {
                              print(val);
                            },
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: MyButton(
                              text: "Proceed",
                              onTap: () {
                                Get.toNamed(
                                  Routes.doucment,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // bottomNavigationBar: isAdsLoaded
      //     ? SizedBox(
      //         height: bannerAd.size.height.toDouble(),
      //         width: bannerAd.size.width.toDouble(),
      //         child: AdWidget(ad: bannerAd),
      //       )
      //     : const SizedBox(),
    );
  }
}

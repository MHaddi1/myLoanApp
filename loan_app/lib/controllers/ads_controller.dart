import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/status.dart';

// Define the AdLoadState enum (replace with your actual enum)
// enum AdLoadState { notLoaded, loading, loaded }

class AdsController extends GetxController {
  final ct = TextEditingController().obs;
  // bool _isInterstitialAdLoaded = false.obs;
  // bool _isRewardedAdLoaded = false;
  // bool acceptedTerms = false;
  final _statusText = "".obs;

  static const String _sdkKey =
      "wnthEbggxFvZP9qdyoZ3sKTWAxNfGt3HEcbGArhxU7SWbcwBstJ8aDGXsq4HWXP1KXyUf4zlO9fGPLBreTn65F";

  final String _interstitialAdUnitId =
      Platform.isAndroid ? "ANDROID_INTER_AD_UNIT_ID" : "IOS_INTER_AD_UNIT_ID";
  final String _rewardedAdUnitId = Platform.isAndroid
      ? "ANDROID_REWARDED_AD_UNIT_ID"
      : "IOS_REWARDED_AD_UNIT_ID";
  // final String _bannerAdUnitId = Platform.isAndroid
  //     ? "ANDROID_BANNER_AD_UNIT_ID"
  //     : "IOS_BANNER_AD_UNIT_ID";
  // final String _mrecAdUnitId =
  //     Platform.isAndroid ? "ANDROID_MREC_AD_UNIT_ID" : "IOS_MREC_AD_UNIT_ID";
  // final String _nativeAdUnitId = Platform.isAndroid
  //     ? "ANDROID_NATIVE_AD_UNIT_ID"
  //     : "IOS_NATIVE_AD_UNIT_ID";

// Create states
  final _isInitialized = false.obs;
  final _interstitialLoadState = AdLoadState.notLoaded.obs;
  var _interstitialRetryAttempt = 0.obs;
  final _rewardedAdLoadState = AdLoadState.notLoaded.obs;
  var _rewardedAdRetryAttempt = 0.obs;



  Future<void> loadAndShowAds() async {
    loadInterstitialAd();
    loadRewaredads();
  }


  Future<void> initializePlugin() async {
    logStatus("Initializing SDK...");

    Map? configuration = await AppLovinMAX.initialize(
      _sdkKey,
    );
    if (configuration != null) {
      _isInitialized.value = true;

      logStatus("SDK Initialized: $configuration");

      attachAdListeners();
    }
  }

  void loadInterstitialAd() async {
    if (_isInitialized.value) {
      if (_interstitialLoadState.value != AdLoadState.loading) {
        bool isInterstitialReady =
            (await AppLovinMAX.isInterstitialReady(_interstitialAdUnitId))!;
        if (isInterstitialReady) {
          AppLovinMAX.showInterstitial(_interstitialAdUnitId);
        } else {
          logStatus('Loading interstitial ad...');
          _interstitialLoadState.value = AdLoadState.loading;
          AppLovinMAX.loadInterstitial(_interstitialAdUnitId);
        }
      }
    }
  }

  void loadRewaredads() async {
    if (_isInitialized.value) {
      if (_rewardedAdLoadState.value != AdLoadState.loading) {
        bool isRewardedAdReady =
            (await AppLovinMAX.isRewardedAdReady(_rewardedAdUnitId))!;
        if (isRewardedAdReady) {
          AppLovinMAX.showRewardedAd(_rewardedAdUnitId);
        } else {
          logStatus('Loading rewarded ad...');
          _rewardedAdLoadState.value = AdLoadState.loading;
          AppLovinMAX.loadRewardedAd(_rewardedAdUnitId);
        }
      }
    }
  }

  void attachAdListeners() {
    /// Interstitial Ad Listeners
    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) {
        _interstitialLoadState.value = AdLoadState.loaded;

        // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialAdReady(_interstitial_ad_unit_id) will now return 'true'
        logStatus('Interstitial ad loaded from ${ad.networkName}');

        // Reset retry attempt
        _interstitialRetryAttempt.value = 0;
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        _interstitialLoadState.value = AdLoadState.notLoaded;

        // Interstitial ad failed to load
        // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
        _interstitialRetryAttempt = _interstitialRetryAttempt + 1;

        int retryDelay =
            pow(2, min(6, _interstitialRetryAttempt.value)).toInt();
        logStatus(
            'Interstitial ad failed to load with code ${error.code} - retrying in ${retryDelay}s');

        Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
          AppLovinMAX.loadInterstitial(_interstitialAdUnitId);
        });
      },
      onAdDisplayedCallback: (ad) {
        logStatus('Interstitial ad displayed');
      },
      onAdDisplayFailedCallback: (ad, error) {
        _interstitialLoadState.value = AdLoadState.notLoaded;
        logStatus(
            'Interstitial ad failed to display with code ${error.code} and message ${error.message}');
      },
      onAdClickedCallback: (ad) {
        logStatus('Interstitial ad clicked');
      },
      onAdHiddenCallback: (ad) {
        _interstitialLoadState.value = AdLoadState.notLoaded;
        logStatus('Interstitial ad hidden');
      },
      onAdRevenuePaidCallback: (ad) {
        logStatus('Interstitial ad revenue paid: ${ad.revenue}');
      },
    ));

    /// Rewarded Ad Listeners
    AppLovinMAX.setRewardedAdListener(
        RewardedAdListener(onAdLoadedCallback: (ad) {
      _rewardedAdLoadState.value = AdLoadState.loaded;

      // Rewarded ad is ready to be shown. AppLovinMAX.isRewardedAdReady(_rewarded_ad_unit_id) will now return 'true'
      logStatus('Rewarded ad loaded from ${ad.networkName}');

      // Reset retry attempt
      _rewardedAdRetryAttempt.value = 0;
    }, onAdLoadFailedCallback: (adUnitId, error) {
      _rewardedAdLoadState.value = AdLoadState.notLoaded;

      // Rewarded ad failed to load
      // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
      _rewardedAdRetryAttempt = _rewardedAdRetryAttempt + 1;

      int retryDelay = pow(2, min(6, _rewardedAdRetryAttempt.value)).toInt();
      logStatus(
          'Rewarded ad failed to load with code ${error.code} - retrying in ${retryDelay}s');

      Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
        AppLovinMAX.loadRewardedAd(_rewardedAdUnitId);
      });
    }, onAdDisplayedCallback: (ad) {
      logStatus('Rewarded ad displayed');
    }, onAdDisplayFailedCallback: (ad, error) {
      _rewardedAdLoadState.value = AdLoadState.notLoaded;
      logStatus(
          'Rewarded ad failed to display with code ${error.code} and message ${error.message}');
    }, onAdClickedCallback: (ad) {
      logStatus('Rewarded ad clicked');
    }, onAdHiddenCallback: (ad) {
      _rewardedAdLoadState.value = AdLoadState.notLoaded;
      logStatus('Rewarded ad hidden');
    }, onAdReceivedRewardCallback: (ad, reward) {
      logStatus('Rewarded ad granted reward');
    }, onAdRevenuePaidCallback: (ad) {
      logStatus('Rewarded ad revenue paid: ${ad.revenue}');
    }));

    /// Banner Ad Listeners
    AppLovinMAX.setBannerListener(AdViewAdListener(onAdLoadedCallback: (ad) {
      logStatus('Banner ad loaded from ${ad.networkName}');
    }, onAdLoadFailedCallback: (adUnitId, error) {
      logStatus(
          'Banner ad failed to load with error code ${error.code} and message: ${error.message}');
    }, onAdClickedCallback: (ad) {
      logStatus('Banner ad clicked');
    }, onAdExpandedCallback: (ad) {
      logStatus('Banner ad expanded');
    }, onAdCollapsedCallback: (ad) {
      logStatus('Banner ad collapsed');
    }, onAdRevenuePaidCallback: (ad) {
      logStatus('Banner ad revenue paid: ${ad.revenue}');
    }));

    /// MREC Ad Listeners
    AppLovinMAX.setMRecListener(AdViewAdListener(onAdLoadedCallback: (ad) {
      logStatus('MREC ad loaded from ${ad.networkName}');
    }, onAdLoadFailedCallback: (adUnitId, error) {
      logStatus(
          'MREC ad failed to load with error code ${error.code} and message: ${error.message}');
    }, onAdClickedCallback: (ad) {
      logStatus('MREC ad clicked');
    }, onAdExpandedCallback: (ad) {
      logStatus('MREC ad expanded');
    }, onAdCollapsedCallback: (ad) {
      logStatus('MREC ad collapsed');
    }, onAdRevenuePaidCallback: (ad) {
      logStatus('MREC ad revenue paid: ${ad.revenue}');
    }));
  }

  String getInterstitialButtonTitle() {
    if (_interstitialLoadState == AdLoadState.notLoaded) {
      return "Load Interstitial";
    } else if (_interstitialLoadState == AdLoadState.loading) {
      return "Loading...";
    } else {
      return "Show Interstitial"; // adLoadState.loaded
    }
  }

  String getRewardedButtonTitle() {
    if (_rewardedAdLoadState == AdLoadState.notLoaded) {
      return "Load Rewarded Ad";
    } else if (_rewardedAdLoadState.value == AdLoadState.loading) {
      return "Loading...";
    } else {
      return "Show Rewarded Ad"; // adLoadState.loaded
    }
  }

  void logStatus(String status) {
    /// ignore: avoid_print
    print(status);

    _statusText.value = status;
  }
}

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <PokktSDK/PokktSDK.h>
#import <PokktSDK/PokktAdapter.h>
//#import <PersonalizedAdConsent/PersonalizedAdConsent.h>

@import GoogleMobileAds;

@interface PokktCustomRewardedVideo : NSObject<GADMRewardBasedVideoAdNetworkAdapter,GADMRewardBasedVideoAdNetworkConnector,PokktAdDelegate>
@end

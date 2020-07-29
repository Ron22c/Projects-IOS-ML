#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <PokktSDK/PokktSDK.h>
#import <PokktSDK/PokktAdapter.h>
//#import <PersonalizedAdConsent/PersonalizedAdConsent.h>

@import GoogleMobileAds;

@interface PokktCustomBanner : NSObject<GADCustomEventBanner,PokktBannerAdDelegate>
{
    PokktBannerView *banner_top;
    NSString *screenName;
    NSString *appId;
    NSString *securityKey;
}

@end

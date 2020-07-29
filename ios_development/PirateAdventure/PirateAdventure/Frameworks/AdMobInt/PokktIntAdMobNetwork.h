#import <Foundation/Foundation.h>
#import "PokktSDK/PokktSDK.h"
#import <PokktSDK/PokktAdapter.h>

@import GoogleMobileAds;

@interface PokktIntRewardedAdMobAD : NSObject<PokktAdNetwork,GADRewardBasedVideoAdDelegate>
{
    
}

@property(nonatomic, strong) PokktNetworkModel *networkModel;
@property (nonatomic, retain) PokktAdConfig *adConfig;
@property (nonatomic, assign) BOOL isTimedout;
@property (nonatomic, retain) NSRecursiveLock *cacheLock;

@property (nonatomic, retain) NSMutableDictionary * adConfigDictionary;
@property (nonatomic, retain) NSMutableDictionary * rewardedAdDictionary;
@property (nonatomic, retain) NSMutableDictionary * timedoutDictionary;

@end

@interface PokktIntInterstitialAdMobAd : NSObject<PokktAdNetwork,GADInterstitialDelegate>
{
    
}

@property(nonatomic, strong) PokktNetworkModel *networkModel;
@property (nonatomic, retain) PokktAdConfig *adConfig;
@property (nonatomic, assign) BOOL isTimedout;

@property (nonatomic, retain) NSMutableDictionary * adConfigDictionary;
@property (nonatomic, retain) NSMutableDictionary * interstitialDictionary;
@property (nonatomic, retain) NSMutableDictionary * timedoutDictionary;


@end

@interface PokktIntAdMobBanner : NSObject<GADBannerViewDelegate,PokktAdNetwork>
{
    
}

@property (nonatomic, strong) PokktNetworkModel *networkModel;
@property (nonatomic, retain) PokktAdConfig *adConfig;
@property (nonatomic, assign) BOOL isTimedout;
@property (nonatomic, retain) UIViewController *rootViewController;
@property (nonatomic, retain) UIView *bannerParentView;
@property (nonatomic, retain) id<PokktBannerDelegate> bannerDelegate;

@end


@interface PokktIntAdMobNetwork : NSObject<PokktAdNetwork, GADInterstitialDelegate>

@property (nonatomic, retain) PokktNetworkModel * networkModel;
@property (nonatomic, retain) PokktIntRewardedAdMobAD * rewardedAd;
@property (nonatomic, retain) PokktIntInterstitialAdMobAd * interstitialAd;
@property (nonatomic, retain) PokktIntAdMobBanner * bannerAd;
@end



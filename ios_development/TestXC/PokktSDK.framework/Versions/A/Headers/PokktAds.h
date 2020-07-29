#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PokktModels.h"


@protocol PokktAdDelegate <NSObject>

/**
 * Caching
 **/
- (void) adCached:(NSString*) screenId
       withReward:(double) reward;

- (void) adFailedToCache:(NSString*) screenId
            errorMessage:(NSString*) errorMessage;

/**
 * Ad Display
 **/
- (void) adDisplayed:(NSString*) screenId;

- (void) adFailedToShow:(NSString*) screenId
           errorMessage:(NSString*) errorMessage;

/**
 * Ad Closed
 **/
- (void) adClosed:(NSString*) screenId
      adCompleted:(BOOL) adCompleted;

/**
 * Ad Interaction
 **/
- (void) adClicked:(NSString*) screenId;

- (void) adGratified:(NSString*) screenId
          withReward:(double) reward;

@end


@protocol PokktBannerAdDelegate <NSObject, PokktAdDelegate>

-(void) bannerExpanded:(NSString*) screenId;

-(void) bannerResized:(NSString*) screenId;

-(void) bannerCollapsed:(NSString*) screenId;

@end


@interface PokktBannerView : UIView

-(void) loadBanner:(NSString*) screenId
rootViewController:(UIViewController*) rootViewController;

-(void) destroyBanner;

@end


@interface PokktConsentInfo : NSObject

@property (nonatomic) BOOL isGDPRApplicable;

@property (nonatomic) BOOL isGDPRConsentAvailable;

@end


@interface PokktAds : NSObject

/**
 * Mandatory APIs
 **/
+(void) setPokktConfigWithAppId:(NSString*) appId
                    securityKey:(NSString*) securityKey;


/**
 * Ads APIs
 **/
+(BOOL) isAdCached:(NSString*) screenId;

+(void) cacheAd:(NSString *)screenId
   withDelegate:(id<PokktAdDelegate>) delegate;

+(void) showAd:(NSString *)screenId
withViewController:(UIViewController*) viewController
  withDelegate:(id<PokktAdDelegate>) delegate;

+(void) showAd:(NSString *)screenId
withViewController:(UIViewController*) viewController
bannerContainer:(PokktBannerView*) bannerView
  withDelegate:(id<PokktBannerAdDelegate>) delegate;

+(void) destroyBanner:(PokktBannerView*) bannerContainer;


/**
 * Consent/GDPR APIs
 **/
+(void) setPokktConsentInfo:(PokktConsentInfo*) consentObject;

+(PokktConsentInfo*) getPokktConsentInfo;


/**
 * Optional Params and Configs APIs
 **/
+(NSString*) getSDKVersion;

+(void) setThirdPartyUserId:(NSString*) userId;

+(void) setCallbackExtraParam:(NSDictionary*) extraParam;

+(void) setUserDetails:(PokktUserInfo*) userInfo;

+(void) setPokktAdPlayerViewConfig:(PokktAdPlayerViewConfig*) adPlayerViewConfig;


/**
 * InApp Notification APIs
 **/
#if TARGET_OS_IOS
+(void) setupNotification:(SEL) aSelector
              application:(UIApplication*) application;

+(void) callBackgroundTaskCompletedHandler:(void (^)(UIBackgroundFetchResult result)) completionHandler;

+(void) inAppNotificationEvent:(UILocalNotification *) localNotification;
#endif


/**
 * Analytics APIs
 **/
+(void) setPokktAnalyticsDetail:(PokktAnalyticsDetails*) analyticsDetail;

+(void) trackIAP:(PokktIAPDetails*) inAppPurchaseDetails;

@end


/**
 * Debugging
 **/
@interface PokktDebugger : NSObject

+(BOOL) isDebugEnabled;

+(void) setDebug:(BOOL) isDebug;

+(void) exportLog:(UIViewController*) viewController;

+(void) showToast:(NSString*) message
   viewController:(UIViewController*) viewController;

+(void) printLog:(NSString*) message;

@end

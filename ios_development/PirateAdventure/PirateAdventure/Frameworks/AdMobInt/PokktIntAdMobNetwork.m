#import "PokktIntAdMobNetwork.h"

@implementation PokktIntAdMobNetwork

#define NewVersion "7.35.2"

static bool isInitialized;

- (void) initNetworkWithNetworkModel:(PokktNetworkModel *)networkModel
{
    if (isInitialized)
    {
        [PokktDebugger printLog:@"[AdMob SDK]Already Initialised AdMobNetwork Network"];
        return;
    }
    
    isInitialized = YES;
    [PokktDebugger printLog:@"[AdMob SDK] Initialising AdMobNetwork Network"];
    self.networkModel = networkModel;
    
    self.interstitialAd = [[PokktIntInterstitialAdMobAd alloc] init];
    [self.interstitialAd initNetworkWithNetworkModel:networkModel];
    
    self.rewardedAd = [[PokktIntRewardedAdMobAD alloc] init];
    [self.rewardedAd initNetworkWithNetworkModel:networkModel];
    
    self.bannerAd = [[PokktIntAdMobBanner alloc] init];
    self.bannerAd.networkModel = networkModel;
}


-(void) fetchAd:(PokktAdConfig *)adConfig withAdView:(UIView *)bannerView withRootViewController:(UIViewController *)rootViewController withDelegate:(id<PokktBannerDelegate>)bannerDelegate onSuccess:(void (^)(id))successCallback onFailure:(void (^)(id))failureHandler
{
    [self.bannerAd fetchAd:adConfig withAdView:bannerView withRootViewController:rootViewController withDelegate:bannerDelegate onSuccess:successCallback onFailure:failureHandler];
}

- (void)cacheAd:(PokktAdConfig *)adConfig
{
    if (adConfig.adFormat == VIDEO)
    {
        [self.rewardedAd cacheAd:adConfig];
    }
    else if(adConfig.adFormat == INTERSTITIAL)
    {
        [self.interstitialAd cacheAd:adConfig];
    }
}

- (void) showAd: (PokktAdConfig *)adConfig viewController:(UIViewController *)viewController
{
    if (adConfig.adFormat == VIDEO)
    {
        [self.rewardedAd showAd:adConfig viewController:viewController];
    }
    else if(adConfig.adFormat == INTERSTITIAL)
    {
        [self.interstitialAd showAd:adConfig viewController:viewController];
    }
}

- (void)checkAdAvailability:(PokktAdConfig *)adConfig
{
    if (adConfig.adFormat == VIDEO)
    {
        [self.rewardedAd checkAdAvailability:adConfig];
    }
    else if(adConfig.adFormat == INTERSTITIAL)
    {
        [self.interstitialAd checkAdAvailability:adConfig];
    }
}

- (PokktNetworkModel *)getNetworkModel
{
    return self.networkModel;
}

- (void)setCacheTimedOut:(PokktAdConfig *)adConfig
{
    if (adConfig.adFormat == VIDEO)
    {
        [self.rewardedAd setCacheTimedOut:adConfig];
    }
    else if(adConfig.adFormat == INTERSTITIAL)
    {
        [self.interstitialAd setCacheTimedOut:adConfig];
    }
}

-(BOOL) checkAdFormatSupport:(PokktAdConfig *)adConfig
{
    if (adConfig.adFormat == VIDEO)
    {
        return [self.rewardedAd checkAdFormatSupport:adConfig];
    }
    
    if (adConfig.adFormat == BANNER)
    {
        return [self.bannerAd checkAdFormatSupport:adConfig];
    }

    if (adConfig.adFormat == INTERSTITIAL)
    {
        if (adConfig.isRewarded)
        {
            return false;
        }
        return [self.interstitialAd checkAdFormatSupport:adConfig];
    }
    
    return true;
}

- (BOOL) isAdCached: (PokktAdConfig *)adConfig
{
    BOOL flag = NO;
    
    if (adConfig.adFormat == VIDEO)
    {
        flag = [self.rewardedAd isAdCached:adConfig];
    }
    
    else if (adConfig.adFormat == INTERSTITIAL)
    {
        flag = [self.interstitialAd isAdCached:adConfig];
    }
    
    return flag;
}

- (void) notifyDataConsentChanged:(PokktConsentInfo *)consentInfo
{
    if (self.rewardedAd) {
        [self.rewardedAd notifyDataConsentChanged:consentInfo];
    }
    
    if (self.interstitialAd) {
        [self.interstitialAd notifyDataConsentChanged:consentInfo];
    }
    
    if (self.bannerAd) {
        [self.bannerAd notifyDataConsentChanged:consentInfo];
    }
}


@end

@implementation PokktIntInterstitialAdMobAd


- (void) initNetworkWithNetworkModel:(PokktNetworkModel *)networkModel
{
    
    [PokktDebugger printLog:@"[AdMob SDK] Initialising AdMobNetwork Network"];
    self.networkModel = networkModel;
    self.adConfigDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    self.interstitialDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    self.timedoutDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
}

- (void)cacheAd:(PokktAdConfig *)adConfig
{
    if (adConfig.isRewarded)
    {
        [PokktDebugger printLog:@"[AdMob SDK]Caching failed.... Invalid network"];
        [PokktNetworkDelegate didFailedAdDownload:self.networkModel adConfig:adConfig errorMessage:@"Rewarded is not supported in AdMob"];
        return;
    }
    
    
    GADInterstitial *interstitial = [self createAndLoadInterstitial:adConfig];
    
    if (interstitial == nil)
    {
        [PokktDebugger printLog:@"[AdMob SDK]Caching failed.... Invalid screenName"];
        [PokktNetworkDelegate didFailedAdDownload:self.networkModel adConfig:adConfig
                                     errorMessage:@"Invalid screenName for AdMob"];
    }
}

- (void) showAd: (PokktAdConfig *)adConfig viewController:(UIViewController *)viewController
{
    viewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    
    if (adConfig.isRewarded)
    {
        [PokktDebugger printLog:@"[AdMob SDK] Failed to show ad...Invalid Network"];
        [PokktNetworkDelegate didFailedToShowAd:self.networkModel adConfig:adConfig];
        return;
    }
    
    if ([self.interstitialDictionary objectForKey:adConfig.getKey])
    {
        GADInterstitial *interstitial = [self.interstitialDictionary objectForKey:adConfig.getKey];
        
        if (interstitial.isReady && !interstitial.hasBeenUsed)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [interstitial presentFromRootViewController:viewController];
            });
        }
        else
        {
            [PokktNetworkDelegate didFailedToShowAd:self.networkModel adConfig:adConfig];
        }
    }
    else
    {
        [PokktNetworkDelegate didFailedToShowAd:self.networkModel adConfig:adConfig];
    }
}

- (void)checkAdAvailability:(PokktAdConfig *)adConfig
{
    BOOL flag = NO;
    
    if (!adConfig.isRewarded)
    {
        if ([self.interstitialDictionary objectForKey:adConfig.getKey])
        {
            GADInterstitial *interstitial = [self.interstitialDictionary objectForKey:adConfig.getKey];
            
            if (interstitial.isReady && !interstitial.hasBeenUsed)
            {
                flag = YES;
            }
        }
    }
    
    [PokktNetworkDelegate onAdAvailabilityStatus:self.networkModel adConfig:adConfig isAdAvailable:flag];
}

- (PokktNetworkModel *)getNetworkModel
{
    return self.networkModel;
}

- (void)setCacheTimedOut:(PokktAdConfig *)adConfig
{
    [self.timedoutDictionary setObject:[NSNumber numberWithBool:YES] forKey:adConfig.getKey];
}

-(BOOL) checkAdFormatSupport:(PokktAdConfig *)adConfig
{
    if (adConfig.adFormat == 3)
    {
        return true;
    }
    
    return false;
}

- (BOOL) isAdCached: (PokktAdConfig *)adConfig
{
    BOOL flag = NO;
    
    if ([self.interstitialDictionary objectForKey:adConfig.getKey])
    {
        GADInterstitial *interstitial = [self.interstitialDictionary objectForKey:adConfig.getKey];
        
        if (interstitial.isReady && !interstitial.hasBeenUsed)
        {
            flag = YES;
        }
    }
    
    return flag;
}

- (void) notifyDataConsentChanged:(PokktConsentInfo *)consentInfo
{

}

-(BOOL)isGDPRRestricted:(PokktConsentInfo *)consentInfo
{
    if (consentInfo.isGDPRApplicable)
    {
        return !consentInfo.isGDPRConsentAvailable;
    }
    return false;
}

- (GADInterstitial *)createAndLoadInterstitial: (PokktAdConfig *)adConfig
{
    GADInterstitial *interstitial = nil;
    
    if ([self.interstitialDictionary objectForKey:adConfig.getKey])
    {
        GADInterstitial *interstitial = [self.interstitialDictionary objectForKey:adConfig.getKey];
        if (interstitial.isReady && !interstitial.hasBeenUsed)
        {
            [self.adConfigDictionary setObject:adConfig forKey:interstitial.adUnitID];
            return interstitial;
        }
        else
        {
            interstitial = nil;
        }
    }
    
    NSDictionary *screenMapdictionary = [self.networkModel.customData objectForKey:@"screens_mapping_data"];
    
    if (screenMapdictionary != nil && [screenMapdictionary objectForKey:@"AdMob_Interstitial"])
    {
        NSDictionary * networkScreenDetails = [screenMapdictionary objectForKey:@"AdMob_Interstitial"];
        
        NSString * adUnitID = [networkScreenDetails objectForKey:@"network_screen"];
        
        if (adUnitID != nil && adUnitID.length !=0)
        {
            interstitial = [[GADInterstitial alloc] initWithAdUnitID:adUnitID];
            interstitial.delegate = self;
            
            [self.timedoutDictionary setObject:[NSNumber numberWithBool:NO] forKey:adConfig.getKey];
            [self.adConfigDictionary setObject:adConfig forKey:adUnitID];
            [self.interstitialDictionary setObject:interstitial forKey:adConfig.getKey];
            
            GADRequest *request = [GADRequest request];
            
            NSString *testDevice = [self.networkModel.customData objectForKey:@"TestDeviceId"];
            request.testDevices = @[testDevice];
            
            PokktConsentInfo *consentInfo = [PokktAds getPokktConsentInfo];
            BOOL isRestricted = [self isGDPRRestricted:consentInfo];
            if (isRestricted) {
                GADExtras *extras = [[GADExtras alloc] init];
                extras.additionalParameters = @{@"npa": @"1"};
                [request registerAdNetworkExtras:extras];
            }
            
            [interstitial loadRequest:request];
        }
    }
    else
    {
        interstitial = [[GADInterstitial alloc] initWithAdUnitID:adConfig.screenName];
        interstitial.delegate = self;
        
        [self.timedoutDictionary setObject:[NSNumber numberWithBool:NO] forKey:adConfig.getKey];
        [self.adConfigDictionary setObject:adConfig forKey:adConfig.screenName];
        [self.interstitialDictionary setObject:interstitial forKey:adConfig.getKey];
        
        GADRequest *request = [GADRequest request];
        
        NSString *testDevice = [self.networkModel.customData objectForKey:@"TestDeviceId"];
        request.testDevices = @[testDevice];
        
        PokktConsentInfo *consentInfo = [PokktAds getPokktConsentInfo];
        BOOL isRestricted = [self isGDPRRestricted:consentInfo];
        if (isRestricted) {
            GADExtras *extras = [[GADExtras alloc] init];
            extras.additionalParameters = @{@"npa": @"1"};
            [request registerAdNetworkExtras:extras];
        }
        
        [interstitial loadRequest:request];
    }
    
    return interstitial;
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial
{
    PokktAdConfig *adConfig = [self.adConfigDictionary objectForKey:interstitial.adUnitID];
    [PokktDebugger printLog:@"[AdMob SDK]Ad Closed"];
    [PokktNetworkDelegate onAdClosed:self.networkModel adConfig:adConfig];
}

- (void)interstitialWillPresentScreen:(GADInterstitial *)ad
{
    PokktAdConfig *adConfig = [self.adConfigDictionary objectForKey:ad.adUnitID];
    [PokktDebugger printLog:@"[AdMob SDK] AdMob Ad Displayed"];
    [PokktNetworkDelegate onAdDisplayed:self.networkModel adConfig:adConfig];
}

- (void)interstitialWillDismissScreen:(GADInterstitial *)ad
{
    // Interstitial Dismiss
}

/// Called just after dismissing an interstitial and it has animated off the screen.
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad
{
    PokktAdConfig *adConfig = [self.adConfigDictionary objectForKey:ad.adUnitID];
    
    if (![[self.timedoutDictionary objectForKey:adConfig.getKey] boolValue])
    {
        [PokktDebugger printLog:@"[AdMob SDK] AdMob Ad Downloaded"];
        [PokktNetworkDelegate didFinishedAdDownload:self.networkModel adConfig:adConfig rewardValue:0 downLoadTime:@""];
    }
}

/// Called when an interstitial ad request completed without an interstitial to
/// show. This is common since interstitials are shown sparingly to users.

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error
{
    PokktAdConfig *adConfig = [self.adConfigDictionary objectForKey:ad.adUnitID];
    
    if (![[self.timedoutDictionary objectForKey:adConfig.getKey] boolValue])
    {
        NSString *errorMessage = @"[AdMob SDK] AdMob Ad Download failed";
        if (error != nil && error.description != nil)
        {
            errorMessage  = [NSString stringWithFormat:@"[AdMob SDK] AdMob Ad Download failed with error: %@",error.description];
        }
        
        [PokktDebugger printLog:errorMessage];
        [PokktNetworkDelegate didFailedAdDownload:self.networkModel adConfig:adConfig errorMessage:error.description];
    }
}

@end

@implementation PokktIntRewardedAdMobAD

static bool isInitialized;

- (void) initNetworkWithNetworkModel:(PokktNetworkModel *)networkModel
{

    [PokktDebugger printLog:@"[AdMob SDK] Initialising AdMobNetwork Network"];
  
    self.networkModel = networkModel;
    
    self.cacheLock = [NSRecursiveLock new];
    
    self.adConfigDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    self.rewardedAdDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    self.timedoutDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
}

- (void)cacheAd:(PokktAdConfig *)adConfig
{
    if ([self.cacheLock tryLock])
    {
        self.adConfig = adConfig;
        NSString *adUnitID = [self getAdUnit:adConfig];
        if (adUnitID != nil && adUnitID.length > 0)
        {
            GADRewardBasedVideoAd *rewardedVideo = [GADRewardBasedVideoAd sharedInstance];
            GADRequest *request = [GADRequest request];
            rewardedVideo.delegate = self;
            NSString *testDevice = [self.networkModel.customData objectForKey:@"TestDeviceId"];
            request.testDevices = @[testDevice];
            
            PokktConsentInfo *consentInfo = [PokktAds getPokktConsentInfo];
            BOOL isRestricted = [self isGDPRRestricted:consentInfo];
            if (isRestricted) {
                GADExtras *extras = [[GADExtras alloc] init];
                extras.additionalParameters = @{@"npa": @"1"};
                [request registerAdNetworkExtras:extras];
            }
            
            [rewardedVideo loadRequest:request withAdUnitID:[self getAdUnit:adConfig]];
            
            [self.adConfigDictionary setObject:adConfig forKey:adUnitID];
        }
        else
        {
            [PokktDebugger printLog:@"[AdMob SDK]Caching failed for rewarded Video.... Invalid network"];
            [PokktNetworkDelegate didFailedAdDownload:self.networkModel adConfig:adConfig errorMessage:@"Caching failed for rewarded Video in AdMob"];
            return;
        }
    }
}

- (void) showAd: (PokktAdConfig *)adConfig viewController:(UIViewController *)viewController
{
    viewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    self.adConfig = adConfig;
    GADRewardBasedVideoAd *rewardedVideo = [GADRewardBasedVideoAd sharedInstance];
    if (rewardedVideo.isReady)
    {
        [self.adConfigDictionary setObject:adConfig forKey:adConfig.screenName];
        dispatch_async(dispatch_get_main_queue(), ^{
            [rewardedVideo presentFromRootViewController:viewController];
        });
    }
    else
    {
       [PokktDebugger printLog:@"[AdMob SDK] Failed to show ad...Ad is not ready to show"];
       [PokktNetworkDelegate didFailedToShowAd:self.networkModel adConfig:adConfig];
    }
    
    if (adConfig.isRewarded)
    {
        [PokktDebugger printLog:@"[AdMob SDK] Failed to show ad...Invalid Network"];
        [PokktNetworkDelegate didFailedToShowAd:self.networkModel adConfig:adConfig];
        return;
    }
    
}

- (void)checkAdAvailability:(PokktAdConfig *)adConfig
{
    BOOL flag = NO;
    
    GADRewardBasedVideoAd *rewardedVideo = [GADRewardBasedVideoAd sharedInstance];
    if (rewardedVideo.isReady)
    {
        flag = YES;
    }
    
    [PokktNetworkDelegate onAdAvailabilityStatus:self.networkModel adConfig:adConfig isAdAvailable:flag];
}

- (PokktNetworkModel *)getNetworkModel
{
    return self.networkModel;
}

- (void)setCacheTimedOut:(PokktAdConfig *)adConfig
{
    self.isTimedout = YES;
}

-(BOOL) checkAdFormatSupport:(PokktAdConfig *)adConfig
{
    if (adConfig.adFormat == 0)
    {
        return true;
    }
    
    return false;
}

- (BOOL) isAdCached: (PokktAdConfig *)adConfig
{
    BOOL flag = NO;
    
    GADRewardBasedVideoAd *rewardedVideo = [GADRewardBasedVideoAd sharedInstance];
    if (rewardedVideo.isReady)
    {
        flag = YES;
    }
    
    
    return flag;
}

- (void) notifyDataConsentChanged:(PokktConsentInfo *)consentInfo
{
   
}

-(BOOL)isGDPRRestricted:(PokktConsentInfo *)consentInfo
{
    if (consentInfo.isGDPRApplicable)
    {
        return !consentInfo.isGDPRConsentAvailable;
    }
    return false;
}

-(NSString *)getAdUnit:(PokktAdConfig *)adConfig
{
    NSString *adUnitId = nil;
    
    if ([self.networkModel.customData objectForKey:@"screens_mapping_data"] != nil && [self.networkModel.customData objectForKey:@"screens_mapping_data"])
    {
        NSDictionary *screenDict = [self.networkModel.customData objectForKey:@"screens_mapping_data"];
        NSString *screenName = adConfig.isRewarded ? @"AdMob_Rewarded_Video" : @"AdMob_Non_Rewarded_Video";
        if ([screenDict objectForKey:screenName] != nil && [screenDict objectForKey:screenName])
        {
            NSDictionary *networkDict = [screenDict objectForKey:screenName];
            
            if ([networkDict objectForKey:@"network_screen"] != nil && [networkDict objectForKey:@"network_screen"])
            {
                adUnitId = [networkDict objectForKey:@"network_screen"];
            }
        }
    }
    else
    {
        adUnitId = adConfig.screenName;
    }
    
    return adUnitId;
//@"ca-app-pub-3948179566165653/3958298921";
}

/// Tells the delegate that the reward based video ad failed to load.
- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
    didFailToLoadWithError:(NSError *)error
{
    if (self.isTimedout)
    {
       NSString  *errorMsg = [NSString stringWithFormat: @"[AdMob SDK] Time out and Rewarded Video failed to load with error  %@", error.description];
        [PokktDebugger printLog:errorMsg];
    }
    else
    {
        NSString  *errorMsg = [NSString stringWithFormat: @"[AdMob SDK] Rewarded Video failed to load with error  %@", error.description];
        [PokktDebugger printLog:errorMsg];
        [PokktNetworkDelegate didFailedAdDownload:self.networkModel adConfig:self.adConfig errorMessage:errorMsg];
    }
    
    [self.cacheLock unlock];
}

/// Tells the delegate that a reward based video ad was received.
- (void)rewardBasedVideoAdDidReceiveAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
{

    if (self.isTimedout)
    {
        [PokktDebugger printLog:@"[AdMob SDK]Rewarded Video timeOut"];
    }
    else
    {
        [PokktDebugger printLog:@"[AdMob SDK]Rewarded Video Download Successfully"];
        [PokktNetworkDelegate didFinishedAdDownload:self.networkModel adConfig:self.adConfig rewardValue:0.0 downLoadTime:@""];
    }
}

/// Tells the delegate that the reward based video ad opened.
- (void)rewardBasedVideoAdDidOpen:(GADRewardBasedVideoAd *)rewardBasedVideoAd
{
    
}

/// Tells the delegate that the reward based video ad started playing.
- (void)rewardBasedVideoAdDidStartPlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd
{
    [PokktNetworkDelegate onAdDisplayed:self.networkModel adConfig:self.adConfig];
}

/// Tells the delegate that the reward based video ad closed.
- (void)rewardBasedVideoAdDidClose:(GADRewardBasedVideoAd *)rewardBasedVideoAd
{
    [PokktNetworkDelegate onAdCompleted:self.networkModel adConfig:self.adConfig];
    [PokktNetworkDelegate onAdClosed:self.networkModel adConfig:self.adConfig];
     [self.cacheLock unlock];
}

/// Tells the delegate that the reward based video ad will leave the application.
- (void)rewardBasedVideoAdWillLeaveApplication:(GADRewardBasedVideoAd *)rewardBasedVideoAd
{
    [PokktNetworkDelegate onAdSkipped:self.networkModel adConfig:self.adConfig];
}

/// Tells the delegate that the reward based video ad has rewarded the user.
- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
   didRewardUserWithReward:(GADAdReward *)reward
{
    if (self.adConfig.isRewarded)
    {
         [PokktNetworkDelegate onAdGratified:self.networkModel adConfig:self.adConfig rewardPoint:[reward.amount floatValue]];
    }
}

@end

@implementation PokktIntAdMobBanner


-(void) fetchAd:(PokktAdConfig *)adConfig withAdView:(UIView *)bannerView withRootViewController:(UIViewController *)rootViewController withDelegate:(id<PokktBannerDelegate>)bannerDelegate onSuccess:(void (^)(id))successCallback onFailure:(void (^)(id))failureHandler
{
   
    NSString *screenName = [self getScreenName:adConfig];
    self.bannerDelegate = bannerDelegate;
    if (screenName != nil && screenName.length != 0)
    {
        GADBannerView *bannerV = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
        bannerV.delegate = self;
        bannerV.adUnitID = screenName;
        bannerV.rootViewController = rootViewController;
        
        GADRequest *request = [GADRequest request];
        
        PokktConsentInfo *consentInfo = [PokktAds getPokktConsentInfo];
        BOOL isRestricted = [self isGDPRRestricted:consentInfo];
        if (isRestricted) {
            GADExtras *extras = [[GADExtras alloc] init];
            extras.additionalParameters = @{@"npa": @"1"};
            [request registerAdNetworkExtras:extras];
        }
        [bannerV loadRequest:request];
        [bannerView addSubview:bannerV];
    }
    else
    {
        [self.bannerDelegate bannerLoadFailed:adConfig.screenName errorMessage:@"[Admob SDK] Invalid adConfig"];
    }

}

- (BOOL) checkAdFormatSupport:(PokktAdConfig *)adConfig
{
    if (adConfig.adFormat == BANNER)
    {
        return true;
    }
    return false;
}

- (void) notifyDataConsentChanged:(PokktConsentInfo *)consentInfo
{
   
}

-(BOOL)isGDPRRestricted:(PokktConsentInfo *)consentInfo
{
    if (consentInfo.isGDPRApplicable)
    {
        return !consentInfo.isGDPRConsentAvailable;
    }
    return false;
}

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView
{
    [self.bannerDelegate bannerLoaded:@""];
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error
{
    [self.bannerDelegate bannerLoadFailed:@"" errorMessage:error.description];
}

- (void)adViewWillPresentScreen:(GADBannerView *)bannerView {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)adViewWillDismissScreen:(GADBannerView *)bannerView {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)adViewDidDismissScreen:(GADBannerView *)bannerView {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)adViewWillLeaveApplication:(GADBannerView *)bannerView {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

-(NSString *)getScreenName:(PokktAdConfig *)adConfig
{
    NSString *screenName = nil;
    
    if ([self.networkModel.customData objectForKey:@"screens_mapping_data"] != nil && [self.networkModel.customData objectForKey:@"screens_mapping_data"])
    {
        NSDictionary *screenDict = [self.networkModel.customData objectForKey:@"screens_mapping_data"];
        
        if ([screenDict objectForKey:@"AdMob_Banner"] != nil && [screenDict objectForKey:@"AdMob_Banner"])
        {
            NSDictionary *networkDict = [screenDict objectForKey:@"AdMob_Banner"];
            
            if ([networkDict objectForKey:@"network_screen"] != nil && [networkDict objectForKey:@"network_screen"])
            {
                screenName = [networkDict objectForKey:@"network_screen"];
            }
        }
    }
    else
    {
        screenName = adConfig.screenName;
    }
    
    return screenName;
}

@end


#import "PokktCustomRewardedVideo.h"

@interface PokktCustomRewardedVideo () {
    /// Connector from Google Mobile Ads SDK to receive ad configurations.
    __weak id<GADMAdNetworkConnector> _connector;
    
    /// Connector from Google Mobile Ads SDK to receive reward-based video ad configurations.
    __weak id<GADMRewardBasedVideoAdNetworkConnector> _rewardBasedVideoAdConnector;
    
    NSString *pokktScreenName;
    NSString *appId;
    NSString *securityKey;
    BOOL isDebug;
    NSString *thirdPartyId;
    
}

@end

@implementation PokktCustomRewardedVideo


- (instancetype)initWithRewardBasedVideoAdNetworkConnector:
(id<GADMRewardBasedVideoAdNetworkConnector>)connector {
    if (!connector) {
        return nil;
    }
    
    self = [super init];
    if (self) {
       _rewardBasedVideoAdConnector = connector;
        
        NSString *serverParam = [connector.credentials objectForKey:GADCustomEventParametersServer];
        if (serverParam != nil && serverParam.length > 0)
        {
            NSError *jsonError;
            NSData *objectData = [serverParam dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:&jsonError];
            NSLog(@"Data recieved from server: %@", json);

            pokktScreenName = [json objectForKey:@"SCREEN"];
            appId = [json objectForKey:@"APPID"];
            securityKey = [json objectForKey:@"SECKEY"];
            isDebug = [[json objectForKey:@"DBG"] boolValue];
            thirdPartyId = [json objectForKey:@"TPID"];
            
            NSLog(@"AdMob Custom Network Initialised...");
            
            
//            //TODO: FOR testing REMOVE IT LATER
//            pokktScreenName = @"83916eed8a2fc5afd567ced93c1f2f86";
//            appId = @"b26277c8c81d33706179288e7bcd9847";
//            securityKey = @"04817587aa780627188b9dff0eb7757a";
//            isDebug = true;
//            thirdPartyId = @"12345";
        }
    }
    return self;
}

- (void)setUp
{
    [self setGDPR];
    
    [PokktAds setPokktConfigWithAppId:appId securityKey:securityKey];
    
    // [optional] set it to true if you want to enable logs for PokktSDK
    [PokktDebugger setDebug:isDebug];
    
    [PokktAds setThirdPartyUserId:thirdPartyId];
    
    // OPTIONAL but we SUGGEST you to implement delegates as it will help you to determine the status of your request
    [PokktAds cacheAd:pokktScreenName withDelegate:self];
    
     NSLog(@"Pokkt ads start caching....");
}

- (void)requestRewardBasedVideoAd
{
    [self setGDPR];
    
    [PokktAds cacheAd:pokktScreenName withDelegate:self];
    NSLog(@"Pokkt ads start caching....");
}

- (void)presentRewardBasedVideoAdWithRootViewController:(UIViewController *)viewController
{
    NSLog(@"Pokkt ads presenting ad...");
    [self setGDPR];
    [PokktAds showAd:pokktScreenName withViewController:viewController withDelegate:self];
}

- (void)stopBeingDelegate
{
   
}

-(void)setGDPR
{
    //    PACConsentStatus status =  [[PACConsentInformation sharedInstance] consentStatus];
    PokktConsentInfo *consentInfo = [[PokktConsentInfo alloc] init];
    //    if (status == PACConsentStatusNonPersonalized)
    //    {
    //        consentInfo.isGDPRApplicable = true;
    //        consentInfo.isGDPRConsentAvailable = false;
    //    }
    //    else if (status == PACConsentStatusPersonalized)
    {
        consentInfo.isGDPRApplicable = true;
        consentInfo.isGDPRConsentAvailable = true;
    }
    
    [PokktAds setPokktConsentInfo:consentInfo];
}

- (void)adapterDidSetUpRewardBasedVideoAd:
(id<GADMRewardBasedVideoAdNetworkAdapter>)rewardBasedVideoAdAdapter
{
    NSLog(@"Adapter setup successfully");
}

- (void)adapter:(id<GADMRewardBasedVideoAdNetworkAdapter>)rewardBasedVideoAdAdapter
didFailToSetUpRewardBasedVideoAdWithError:(NSError *)error
{
    NSLog(@"%@",error.description);
}

#pragma mark Pokkt Video Ads Delegates

- (void)adCached: (NSString *) screenId withReward:(double) reward
{
    NSLog(@"Pokkt ads cached successfully...");
    id<GADMRewardBasedVideoAdNetworkConnector> strongConnector = _rewardBasedVideoAdConnector;
    
    [strongConnector adapterDidReceiveRewardBasedVideoAd:self];
}

- (void) adFailedToCache:(NSString*) screenId
            errorMessage:(NSString*) errorMessage
{
    NSLog(@"Pokkt ads caching failed...");
    id<GADMRewardBasedVideoAdNetworkConnector> strongConnector = _rewardBasedVideoAdConnector;
    
    NSError *err = [NSError errorWithDomain:@"Error"
                                       code:0
                                   userInfo:@{
                                       NSLocalizedDescriptionKey:errorMessage
                                   }];
    
    [strongConnector adapter:self didFailToLoadRewardBasedVideoAdwithError:err];
}

- (void) adDisplayed:(NSString*) screenId
{
    id<GADMRewardBasedVideoAdNetworkConnector> strongConnector = _rewardBasedVideoAdConnector;
    [strongConnector adapterDidOpenRewardBasedVideoAd:self];
    [strongConnector adapterDidStartPlayingRewardBasedVideoAd:self];
}

- (void) adClicked:(NSString*) screenId
{
    id<GADMRewardBasedVideoAdNetworkConnector> strongConnector = _rewardBasedVideoAdConnector;
    [strongConnector adapterDidGetAdClick:self];
}

- (void) adGratified:(NSString*) screenId withReward:(double) reward
{
    id<GADMRewardBasedVideoAdNetworkConnector> strongConnector = _rewardBasedVideoAdConnector;
    
    GADAdReward *GadReward = [[GADAdReward alloc] initWithRewardType:@"Coin" rewardAmount:[[NSDecimalNumber alloc] initWithFloat:reward]];
    [strongConnector adapter:self didRewardUserWithReward:GadReward];
}

- (void) adClosed:(NSString*) screenId adCompleted:(BOOL) adCompleted
{
    id<GADMRewardBasedVideoAdNetworkConnector> strongConnector = _rewardBasedVideoAdConnector;
    [strongConnector adapterDidCloseRewardBasedVideoAd:self];
}

- (void) adFailedToShow:(NSString*) screenId errorMessage:(NSString*) errorMessage
{
}

@end

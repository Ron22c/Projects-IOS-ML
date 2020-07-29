#import "PokktCustomInterstitial.h"

@implementation PokktCustomInterstitial


@synthesize delegate;

#pragma mark Pokkt Video Ads Request

- (void)requestInterstitialAdWithParameter:(NSString *)serverParameter
                                     label:(NSString *)serverLabel
                                   request:(GADCustomEventRequest *)request
{
    
    if (serverParameter == nil)
    {
        return;
    }
    NSError *jsonError;
    NSData *objectData = [serverParameter dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
    
    NSLog(@"Data recieved from server: %@", json);
    
    screenName = [json objectForKey:@"SCREEN"];
    appId = [json objectForKey:@"APPID"];
    securityKey = [json objectForKey:@"SECKEY"];
    BOOL isDebug = [[json objectForKey:@"DBG"] boolValue];
    NSString *thirdPartyId = [json objectForKey:@"TPID"];
    
    //TODO: FOR testing REMOVE IT LATER
    screenName = @"d5e09dbd3b57e88ad29b063cd3da436b";
    appId = @"b26277c8c81d33706179288e7bcd9847";
    securityKey = @"04817587aa780627188b9dff0eb7757a";
    isDebug = true;
    thirdPartyId = @"12345";
    
    [self setGDPR];

    [PokktAds setPokktConfigWithAppId:appId securityKey:securityKey];
    
    // [optional] set it to true if you want to enable logs for PokktSDK
    [PokktDebugger setDebug:isDebug];
    
    [PokktAds setThirdPartyUserId:thirdPartyId];
    
    // OPTIONAL but we SUGGEST you to implement delegates as it will help you to determine the status of your request
    
    [PokktAds cacheAd:screenName withDelegate:self];

}


- (void)presentFromRootViewController:(UIViewController *)rootViewController
{
    [self setGDPR];
    
    [PokktAds showAd:screenName withViewController:rootViewController withDelegate:self];
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
#pragma mark Pokkt Interstitial Ads Delegates

- (void) adDisplayed:(NSString*) screenId
{
    [self.delegate customEventInterstitialWillPresent:self];
}


- (void) adCached:(NSString*) screenId
withReward:(double) reward
{
    adType = Interstitial_Ad;
    [self.delegate customEventInterstitialDidReceiveAd:self];
}

- (void) adFailedToCache:(NSString*) screenId
errorMessage:(NSString*) errorMessage
{
     adType = No_Ad;
    NSError *err = [NSError errorWithDomain:@"Error"
                                       code:0
                                   userInfo:@{
                                              NSLocalizedDescriptionKey:errorMessage
                                              }];
    [self.delegate customEventInterstitial:self didFailAd:err];
}

- (void) adClosed:(NSString*) screenId adCompleted:(BOOL) adCompleted
{
    adType = No_Ad;
    [self.delegate customEventInterstitialWillDismiss:self];
    [self.delegate customEventInterstitialDidDismiss:self];
}

- (void) adClicked:(NSString*) screenId
{
    [self.delegate customEventInterstitialWasClicked:self];
}

- (void)adFailedToShow:(NSString *)screenId errorMessage:(NSString *)errorMessage
{
}

- (void)adGratified:(NSString *)screenId withReward:(double)reward
{
}

@end

#import "PokktCustomBanner.h"

@implementation PokktCustomBanner
@synthesize delegate;


#pragma mark Pokkt Banner Ads Request

- (void)requestBannerAd:(GADAdSize)adSize
              parameter:(NSString *)serverParameter
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
    screenName = @"982affdc0f14ce349c62aab7e00c7bdd";
    appId = @"b26277c8c81d33706179288e7bcd9847";
    securityKey = @"04817587aa780627188b9dff0eb7757a";
    isDebug = true;
    thirdPartyId = @"12345";
    
    [self setGDPR];
    
    [PokktAds setPokktConfigWithAppId:appId securityKey:securityKey];
    
    // [optional], set it to true if you want to enable logs for PokktSDK
    [PokktDebugger setDebug:isDebug];
    
    [PokktAds setThirdPartyUserId:thirdPartyId];

    banner_top = [[PokktBannerView alloc] initWithFrame: CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 50)];
    [banner_top setBackgroundColor:[UIColor lightGrayColor]];
    
    UIViewController *topVC = [self topViewController];
    [topVC.view addSubview:banner_top];
    
    [PokktAds showAd:screenName withViewController:topVC withDelegate:self];
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
//    {
        consentInfo.isGDPRApplicable = true;
        consentInfo.isGDPRConsentAvailable = true;
//    }
    
    [PokktAds setPokktConsentInfo:consentInfo];
}


#pragma mark Pokkt Banner Ads Delegates


- (void) adDisplayed:(NSString*) screenId
{
    [self.delegate customEventBanner:self didReceiveAd:banner_top];
}

- (void) adFailedToShow:(NSString*) screenId errorMessage:(NSString*) errorMessage
{
    NSError *err = [NSError errorWithDomain:@"some_domain"
                                       code:100
                                   userInfo:@{
                                              NSLocalizedDescriptionKey:errorMessage
                                              }];
    [self.delegate customEventBanner:self didFailAd:err];
}

- (void) adClicked:(NSString*) screenId
{
    [self.delegate customEventBannerWasClicked:self];
}

- (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

- (void)adCached:(NSString *)screenId withReward:(double)reward
{
}


- (void)adClosed:(NSString *)screenId adCompleted:(BOOL)adCompleted
{
}


- (void)adFailedToCache:(NSString *)screenId errorMessage:(NSString *)errorMessage
{
}


- (void)adGratified:(NSString *)screenId withReward:(double)reward
{
}

- (void)bannerCollapsed:(NSString *)screenId
{
}

- (void)bannerExpanded:(NSString *)screenId
{
}

- (void)bannerResized:(NSString *)screenId
{
}

@end

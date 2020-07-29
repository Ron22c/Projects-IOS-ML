//
//  Inheritace.h
//  objectiveCApp
//
//  Created by Ranajit on 25/01/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestController.h"

NS_ASSUME_NONNULL_BEGIN

@interface Inheritace : TestController{
    NSString *_blabla;
}
 
-(NSString *)blabla;
-(void) setBlabla:(NSString *)blabla;
-(void) getPuppyEyes;

@end

NS_ASSUME_NONNULL_END

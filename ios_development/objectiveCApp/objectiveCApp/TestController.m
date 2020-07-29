//
//  TestController.m
//  objectiveCApp
//
//  Created by Ranajit on 22/01/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

#import "TestController.h"
@implementation TestController
typedef void (^successCallback)(id result);
typedef void (^failureCallback)(NSString* error);

-(void) bark{
    NSLog(@"We are inside bark method");
    self.name = @"delta";
}

-(void) barkNumber:(int)number{
    for(int i=0; i<number; i++){
        NSLog(@"bhow bhow");
        [self bark];
    }
    printf("the dog barked %d number of times", number);
    NSLog(self.name);
}

-(void) barkNumber:(int)number loud:(BOOL)isLoud {
    if(!isLoud) {
        for(int i=0;i<number;i++){
            NSLog(@"yup yup");
        }
    } else {
        for(int i=0;i<number;i++){
            NSLog(@"bhow bhow");
        }
    }
}

-(int) getAge: (int) multiplier {
    return self.age * multiplier;
}

-(NSString *) getName {
    return self.name;
}

-(int) getDogYears: (int) regularAge{
    return regularAge*7;
}

-(int)factorial:(int) number{
    if(number==1){
        return 1;
    }
    return number * [self factorial:number-1];
}


@end

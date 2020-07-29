//
//  Inheritace.m
//  objectiveCApp
//
//  Created by Ranajit on 25/01/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

#import "Inheritace.h"

@implementation Inheritace

-(NSString *)blabla
{
    return _blabla;
}

-(void) setBlabla:(NSString *)blabla
{
    _blabla = blabla;
}

-(void) getPuppyEyes
{
    NSLog(@": (");
}

-(void) bark
{
    [super bark];
    NSLog(@"now we are inside bark method of inheritance class");
}
@end

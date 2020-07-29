//
//  Factory.h
//  PirateAdventure
//
//  Created by Ranajit Chandra on 27/01/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Character.h"

@interface Factory : NSObject

- (NSArray *) tiles;
- (Character *) character;

@end



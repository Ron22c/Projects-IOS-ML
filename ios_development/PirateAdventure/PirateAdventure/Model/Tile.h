//
//  Tile.h
//  PirateAdventure
//
//  Created by Ranajit Chandra on 27/01/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface Tile : NSObject

@property (strong, nonnull) NSString *story;
@property (strong, nonnull) UIImage *backGroundImage;
@property (strong, nonnull) NSString *actionButtonName;

@end



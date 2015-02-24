//
//  BumperButton.h
//  BumperButtonIOS
//
//  Created by Joshua on 2/24/15.
//  Copyright (c) 2015 Joshua. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BumperButton : SKSpriteNode
-(id) initWithMasterButtonRadius: (float)mbRadius
               MasterButtonColor: (UIColor*)mbColor
                bumperPointCount: (int)bpCount
               bumperPointColors: (NSArray*)bpColors
               bumberPointImages: (NSArray*)bpImages;

-(void)masterButtonDidMakeContact;
@end

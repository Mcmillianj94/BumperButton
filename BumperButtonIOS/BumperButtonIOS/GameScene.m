//
//  GameScene.m
//  BumperButtonIOS
//
//  Created by Joshua on 2/24/15.
//  Copyright (c) 2015 Joshua. All rights reserved.
//

#import "GameScene.h"
@interface GameScene()
@property BumperButton* bumperButton;
@end
@implementation GameScene

static const uint32_t upBumperCollionCONST  = 0x1 << 1;
static const uint32_t downBumperCollionCONST  = 0x2 << 2;
static const uint32_t leftBumperCollionCONST  = 0x3 << 3;
static const uint32_t rightBumperCollionCONST  = 0x4 << 4;

-(void)didMoveToView:(SKView *)view {
    self.physicsWorld.contactDelegate = self;
    
    NSMutableArray* bumperPointColors = [[NSMutableArray alloc] initWithObjects:[UIColor redColor],[UIColor blackColor],[UIColor blueColor],[UIColor greenColor], nil];
    self.bumperButton = [[BumperButton alloc] initWithMasterButtonRadius:30.0f MasterButtonColor:[UIColor whiteColor] bumperPointCount:4 bumperPointColors:bumperPointColors bumberPointImages:nil];
    self.bumperButton.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self addChild: self.bumperButton];
}

-(void)didBeginContact:(SKPhysicsContact *)contact{
    
    //NSLog(@"contact Began");
    SKPhysicsBody *firstBody, *secondBody;
    firstBody = contact.bodyA;
    secondBody = contact.bodyB;
    
    //Check if one of the contacts matches a BumperPoints collisionCONST
    ////If contact is made the masterButton recenters
    if (firstBody.categoryBitMask == upBumperCollionCONST || secondBody.categoryBitMask == upBumperCollionCONST) {
        NSLog(@"Up Button was hit");
        [self.bumperButton masterButtonDidMakeContact];
    }else if (firstBody.categoryBitMask == downBumperCollionCONST || secondBody.categoryBitMask == downBumperCollionCONST) {
        NSLog(@"Down Button was hit");
        [self.bumperButton masterButtonDidMakeContact];
    }else if (firstBody.categoryBitMask == leftBumperCollionCONST || secondBody.categoryBitMask == leftBumperCollionCONST) {
        NSLog(@"Left Button was hit");
        [self.bumperButton masterButtonDidMakeContact];
    }if (firstBody.categoryBitMask == rightBumperCollionCONST || secondBody.categoryBitMask == rightBumperCollionCONST) {
        NSLog(@"Right Button was hit");
        [self.bumperButton masterButtonDidMakeContact];
    }
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end

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
@property NSMutableArray* bumperPointColors;
@property SKSpriteNode* testSprite;
@end
@implementation GameScene

static const uint32_t upBumperCollionCONST  = 0x1 << 1;
static const uint32_t downBumperCollionCONST  = 0x2 << 2;
static const uint32_t leftBumperCollionCONST  = 0x3 << 3;
static const uint32_t rightBumperCollionCONST  = 0x4 << 4;

-(void)didMoveToView:(SKView *)view {
    self.physicsWorld.contactDelegate = self;
    
    self.bumperPointColors = [[NSMutableArray alloc] initWithObjects:[UIColor redColor],[UIColor blackColor],[UIColor blueColor],[UIColor greenColor], nil];
    
    self.bumperButton = [[BumperButton alloc] initWithScene: self masterButtonRadius:30.0f MasterButtonColor:[UIColor whiteColor] bumperPointCount:4 bumperPointColors:self.bumperPointColors bumberPointImages:nil];
    [self addChild: self.bumperButton];
    
    //Node will change color based on the bumper hit
    self.testSprite = [[SKSpriteNode alloc] initWithColor:[UIColor grayColor] size:CGSizeMake(100.0f, 100.0f)];
    self.testSprite.position = CGPointMake(self.size.width/4, self.size.height/2);
    [self addChild:self.testSprite];

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
        self.testSprite.color = [UIColor redColor];
    }else if (firstBody.categoryBitMask == downBumperCollionCONST || secondBody.categoryBitMask == downBumperCollionCONST) {
        NSLog(@"Down Button was hit");
        self.testSprite.color = [UIColor blackColor];
    }else if (firstBody.categoryBitMask == leftBumperCollionCONST || secondBody.categoryBitMask == leftBumperCollionCONST) {
        NSLog(@"Left Button was hit");
        self.testSprite.color = [UIColor blueColor];
    }if (firstBody.categoryBitMask == rightBumperCollionCONST || secondBody.categoryBitMask == rightBumperCollionCONST) {
        NSLog(@"Right Button was hit");
        self.testSprite.color = [UIColor greenColor];
    }
    
}

-(void)update:(CFTimeInterval)currentTime {
    [self.bumperButton sendUpdateTime:&currentTime];
}

@end

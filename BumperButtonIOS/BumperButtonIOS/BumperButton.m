//
//  BumperButton.m
//  BumperButtonIOS
//
//  Created by Joshua on 2/24/15.
//  Copyright (c) 2015 Joshua. All rights reserved.
//

#import "BumperButton.h"
@interface BumperButton()
//BumperButton data
@property float masterButtonRadius;
@property UIColor* masterButtonColor;
@property int bumperPointCount;
@property NSArray* bumperPointColors;
@property NSArray* bumperPointImages;
//BumperButton UI
@property SKShapeNode* masterButton;
@property SKShapeNode* upBumper;
@property SKShapeNode* downBumper;
@property SKShapeNode* leftBumper;
@property SKShapeNode* rightBumper;

@end

@implementation BumperButton

//Collision Constants
static const uint32_t masterButtonCollionCONST = 0x0 << 0;
static const uint32_t upBumperCollionCONST  = 0x1 << 1;
static const uint32_t downBumperCollionCONST  = 0x2 << 2;
static const uint32_t leftBumperCollionCONST  = 0x3 << 3;
static const uint32_t rightBumperCollionCONST  = 0x4 << 4;


-(id) initWithMasterButtonRadius: (float)mbRadius
               MasterButtonColor: (UIColor*)mbColor
                bumperPointCount: (int)bpCount
               bumperPointColors: (NSArray*)bpColors
               bumberPointImages: (NSArray*)bpImages
{
    if (self = [super init]) {
        
        
        self.masterButtonRadius = mbRadius;
        self.masterButtonColor = mbColor;
        self.bumperPointCount = bpCount;
        self.bumperPointColors = bpColors;
        self.bumperPointImages = bpImages;
        
        //Create the MasterButton
        self.masterButton = [SKShapeNode shapeNodeWithCircleOfRadius:self.masterButtonRadius];
        self.masterButton.fillColor = self.masterButtonColor;
        self.masterButton.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.masterButtonRadius];
        self.masterButton.physicsBody.affectedByGravity = false;
        
        self.masterButton.physicsBody.categoryBitMask = masterButtonCollionCONST;
        self.masterButton.physicsBody.contactTestBitMask = upBumperCollionCONST | downBumperCollionCONST | leftBumperCollionCONST | rightBumperCollionCONST;
        [self addChild:self.masterButton];
        
        //Create and position BumperPoints
        self.upBumper = [SKShapeNode shapeNodeWithCircleOfRadius:self.masterButtonRadius/1.5];
        self.upBumper.position = CGPointMake(0, self.masterButton.frame.size.height + (self.upBumper.frame.size.height/3));
        self.upBumper.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.masterButtonRadius/1.5];
        self.upBumper.physicsBody.affectedByGravity = false;
        self.upBumper.physicsBody.categoryBitMask = upBumperCollionCONST;
        self.upBumper.physicsBody.contactTestBitMask = masterButtonCollionCONST;
        
        self.downBumper = [SKShapeNode shapeNodeWithCircleOfRadius:self.masterButtonRadius/1.5];
        self.downBumper.position = CGPointMake(0, -(self.masterButton.frame.size.height + (self.upBumper.frame.size.height/3)));
        self.downBumper.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.masterButtonRadius/1.5];
        self.downBumper.physicsBody.affectedByGravity = false;
        self.downBumper.physicsBody.categoryBitMask = downBumperCollionCONST;
        self.downBumper.physicsBody.contactTestBitMask = masterButtonCollionCONST;
        
        self.leftBumper = [SKShapeNode shapeNodeWithCircleOfRadius:self.masterButtonRadius/1.5];
        self.leftBumper.position = CGPointMake(-(self.masterButton.frame.size.height + (self.upBumper.frame.size.height/2.5)), 0);
        self.leftBumper.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.masterButtonRadius/1.5];
        self.leftBumper.physicsBody.affectedByGravity = false;
        self.leftBumper.physicsBody.categoryBitMask = leftBumperCollionCONST;
        self.leftBumper.physicsBody.contactTestBitMask = leftBumperCollionCONST;
        
        self.rightBumper = [SKShapeNode shapeNodeWithCircleOfRadius:self.masterButtonRadius/1.5];
        self.rightBumper.position = CGPointMake(self.masterButton.frame.size.height + (self.upBumper.frame.size.height/2.5), 0);
        self.rightBumper.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.masterButtonRadius/1.5];
        self.rightBumper.physicsBody.affectedByGravity = false;
        self.rightBumper.physicsBody.categoryBitMask = rightBumperCollionCONST;
        self.rightBumper.physicsBody.contactTestBitMask = rightBumperCollionCONST;
        
        NSMutableArray* bumperArray = [[NSMutableArray alloc] initWithObjects:self.upBumper, self.downBumper, self.leftBumper, self.rightBumper, nil];
        
        //Add the number of bumperPoints specified
        ////bumperpoints are added in this order Up - Down - Left - Right
        //////set Image or Color
        for (NSInteger i = 0; i < bpCount; i++){
            SKShapeNode* currentBumper = bumperArray[i];
            
            if (self.bumperPointImages[0] == nil) {
                currentBumper.fillColor = self.bumperPointColors[i];
            }else{
                SKTexture* tempTexture = [SKTexture textureWithImageNamed:self.bumperPointImages[i]];
                currentBumper.fillTexture = tempTexture;
            };
            [self addChild:currentBumper];
        }
        [self setUserInteractionEnabled:true];
    }
    return self;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    
    //Move masterButton to new locaton
    SKAction* moveAction = [SKAction moveTo:positionInScene duration:0];
    [self.masterButton runAction:moveAction];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    //Move masterButton back to center
    [self centerMasterButton];
}
-(void)masterButtonDidMakeContact{
    [self centerMasterButton];
}
-(void)centerMasterButton{
    SKAction* moveAction = [SKAction moveTo: CGPointMake(0, 0) duration:0];
    [self.masterButton runAction:moveAction];
}
@end

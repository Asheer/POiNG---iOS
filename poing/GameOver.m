//
//  GameOver.m
//  POiNG
//
//  Created by Final on 5/28/14.
//  Copyright (c) 2014 final. All rights reserved.
//

#import "GameOver.h"
#import "MyScene.h"

@implementation GameOver

-(instancetype) initWithSize:(CGSize)size {
    
    if(self == [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor whiteColor];
        SKAction *sound = [SKAction playSoundFileNamed:@"gameover.caf"
                                     waitForCompletion:NO];
        [self runAction:sound];
        
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        label.text = @"GAME OVER";
        label.fontColor = [SKColor greenColor];
        label.fontSize = 44;
        label.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:label];
        
        SKLabelNode *tryAgain = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        tryAgain.text = @"tap to play again";
        tryAgain.fontColor = [SKColor orangeColor];
        tryAgain.fontSize = 24;
        tryAgain.position = CGPointMake(self.size.width/2, -50);
        
        SKAction *moveLabel = [SKAction moveToY:size.height/2 - 40 duration:2.0];
        [tryAgain runAction:moveLabel];
        [self addChild:tryAgain];
        
    }
    
    return self;
    
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    MyScene *firstScene = [MyScene sceneWithSize:self.size];
    
    [self.view presentScene:firstScene transition:[SKTransition doorsOpenVerticalWithDuration:1.5]];
    
}

@end

//
//  MainMenu.m
//  POiNG
//
//  Created by Final on 5/28/14.
//  Copyright (c) 2014 final. All rights reserved.
//

#import "MainMenu.h"
#import "MyScene.h"

@implementation MainMenu

-(id)initWithSize:(CGSize)size {
    if(self == [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor redColor];
        
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        
        label.text = @"Main Menu";
        label.fontColor = [SKColor orangeColor];
        label.fontSize = 44;
        label.position = CGPointMake(self.size.width/2,self.size.height/2);
        [self addChild:label];
        
        SKLabelNode *play = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        play.text = @"TAP TO START";
        play.fontColor = [SKColor blueColor];
        play.fontSize = 24;
        play.position = CGPointMake(size.width/2, -50);
        
        SKLabelNode *poing = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        poing.text = @"POiNG!";
        poing.fontColor = [SKColor blueColor];
        poing.fontSize = 40;
        poing.position = CGPointMake(size.width/2, self.size.height - 40);
        
        SKAction *moveLabel = [SKAction moveToY:label.position.y - 40 duration:1.5];
        [play runAction:moveLabel];
        [self addChild:poing];
        [self addChild:play];
    		
        
    }
    
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    MyScene *firstScene = [MyScene sceneWithSize:self.size];
    [self.view presentScene:firstScene transition:[SKTransition doorsOpenHorizontalWithDuration:1.5]];
    
}


@end

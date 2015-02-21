//
//  MyScene.m
//  POiNG
//
//  Created by Final on 5/27/14.
//  Copyright (c) 2014 final. All rights reserved.
//

#import "MyScene.h"
#import "MainMenu.h"
#import "GameOver.h"

@interface MyScene()

@property (nonatomic) SKSpriteNode *playerPaddle;
@property (nonatomic) SKSpriteNode *npcPaddle;
@property (nonatomic) SKSpriteNode *ball;
@property (nonatomic) SKNode *rightEdge;
@property (nonatomic) SKNode *leftEdge;
@property (nonatomic) SKLabelNode *pScore;
@property (nonatomic) SKLabelNode *npScore;

@property (nonatomic) SKLabelNode *playerScore;
@property (nonatomic) SKLabelNode *npcScore;
@property int newPScore;
@property int newnpcScore;

@end

static const uint32_t ballCategory = 1;
static const uint32_t playerPaddleCategory = 2;
static const uint32_t npcPaddleCategory = 4;
static const uint32_t rightEdgeCategory = 16;
static const uint32_t leftEdgeCategory = 32;

//static const uint32_t edgeCategory = 8;

@implementation MyScene

-(instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
       
        self.backgroundColor = [SKColor blackColor];
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsWorld.contactDelegate = self;
       // self.physicsBody.categoryBitMask = edgeCategory;
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        
        self.newPScore = 0;
        self.newnpcScore = 0;
        
        [self addPlayerPaddle:size];
        [self addnpcPaddle:size];
        [self addBall:size];
        [self addLeftEdge:size];
        [self addRightEdge:size];
        [self addPlayerScoreLabel:size];
        [self npcPlayerScoreLabel:size];
        
    }
    return self;
}

-(void) addPlayerScoreLabel:(CGSize)size {
    
    self.pScore = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    self.pScore.text = @"Player Score:";
    self.pScore.fontColor = [SKColor redColor];
    self.pScore.position = CGPointMake(size.width - 100, size.height-20);
    self.pScore.fontSize = 20;

    [self addChild:self.pScore];
    
    self.playerScore = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    
    self.playerScore.text = [NSString stringWithFormat:@"%i",self.newPScore];
    
    self.playerScore.position = CGPointMake(self.pScore.position.x + 70, size.height - 20);
    self.playerScore.fontSize = 20;
    self.playerScore.fontColor = [SKColor redColor];
    
    [self addChild:self.playerScore];
    
    
}

-(void) npcPlayerScoreLabel:(CGSize)size {
    self.npScore = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    self.npScore.text = @"NPC Score:";
    self.npScore.fontColor = [SKColor redColor];
    self.npScore.position = CGPointMake(100, size.height-20);
    self.npScore.fontSize = 20;
    
    [self addChild:self.npScore];
    
    self.npcScore = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    
    self.npcScore.text = [NSString stringWithFormat:@"%i",self.newPScore];
    
    self.npcScore.position = CGPointMake(self.npScore.position.x + 60, size.height - 20);
    self.npcScore.fontSize = 20;
    self.npcScore.fontColor = [SKColor redColor];
    
    [self addChild:self.npcScore];

}


-(void) addPlayerPaddle:(CGSize)size{
    self.playerPaddle = [SKSpriteNode spriteNodeWithImageNamed:@"p1"];
    self.playerPaddle.position = CGPointMake(size.width - 20, size.height/2);
    self.playerPaddle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.playerPaddle.frame.size];
    self.playerPaddle.physicsBody.categoryBitMask = playerPaddleCategory;
    self.playerPaddle.physicsBody.dynamic = NO;
    self.playerPaddle.physicsBody.friction = 0;;
    
    [self addChild:self.playerPaddle];

}

-(void) addRightEdge:(CGSize)size {
    
    self.rightEdge = [SKNode node];
    self.rightEdge.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(self.size.width, 0) toPoint:CGPointMake(self.size.width, self.size.height)];
    self.rightEdge.physicsBody.categoryBitMask = rightEdgeCategory;
    
    [self addChild:self.rightEdge];
    
}

-(void) addLeftEdge:(CGSize)size {
    
    self.leftEdge = [SKNode node];
    self.leftEdge.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, 0) toPoint:CGPointMake(0, self.size.height)];
    self.leftEdge.physicsBody.categoryBitMask = leftEdgeCategory;
    
    [self addChild:self.leftEdge];
    
}

-(void) addnpcPaddle:(CGSize)size {
    self.npcPaddle = [SKSpriteNode spriteNodeWithImageNamed:@"p2"];
    self.npcPaddle.position = CGPointMake(20, self.size.height/2);
    self.npcPaddle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.npcPaddle.frame.size];
    self.npcPaddle.physicsBody.friction = 0;
    self.npcPaddle.physicsBody.categoryBitMask = npcPaddleCategory;
    self.npcPaddle.physicsBody.dynamic = NO;
    
    [self addChild:self.npcPaddle];

}

-(void) didBeginContact:(SKPhysicsContact *)contact {
    SKPhysicsBody *notTheBall;
    
    
    if(contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        notTheBall = contact.bodyB;
        
    }
    else {
        notTheBall = contact.bodyA;
    }
    
    if(notTheBall.categoryBitMask == playerPaddleCategory) {
       SKAction *sound = [SKAction playSoundFileNamed:@"paddlehit.caf" waitForCompletion:NO];
        [self.scene runAction:sound];
                           
    }
    
    if(notTheBall.categoryBitMask == npcPaddleCategory) {
       SKAction *sound = [SKAction playSoundFileNamed:@"paddlehit.caf" waitForCompletion:NO];
        [self.scene runAction:sound];
    }
    
    if(notTheBall.categoryBitMask == rightEdgeCategory) {
        self.npcScore.text = [NSString stringWithFormat:@"%i",++self.newnpcScore];
        if(self.newnpcScore > 2) {
            GameOver *gameover = [GameOver sceneWithSize:self.size];
            [self.view presentScene:gameover transition:[SKTransition doorsOpenHorizontalWithDuration:0.5]];
            
            
        }
        NSLog(@"NPC SCORE!");
    }
    
    if(notTheBall.categoryBitMask == leftEdgeCategory) {
        self.playerScore.text = [NSString stringWithFormat:@"%i",++self.newPScore];
    }
    
}

-(void) addBall:(CGSize)size {
   
    self.ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball"];
    CGPoint point = CGPointMake(size.width/2, size.height/2);
    self.ball.position = point;
    self.ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.ball.frame.size.width/2];
    self.ball.physicsBody.categoryBitMask = ballCategory;
    self.ball.physicsBody.friction = 0;
    self.ball.physicsBody.linearDamping = 0;
    self.ball.physicsBody.restitution = 1.0f; // always bouncing
    self.ball.physicsBody.contactTestBitMask = npcPaddleCategory | playerPaddleCategory | rightEdgeCategory | leftEdgeCategory;
    	
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"orb"];
    NSArray *orbiImageNames = [atlas textureNames]; // name of files, not objects
    NSArray *sortedNames = [orbiImageNames sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    NSMutableArray *orbTextures = [NSMutableArray array];
    for(NSString *filename in sortedNames) {
        SKTexture *texture = [atlas textureNamed:filename];
        [orbTextures addObject:texture];

    }
    SKAction * glow = [SKAction animateWithTextures:orbTextures timePerFrame:0.1];
    SKAction *keepGlowing = [SKAction repeatActionForever:glow];
    [self.ball runAction:keepGlowing];
    
    [self addChild:self.ball];

    
    CGVector myVector = CGVectorMake(20,2 );
    [self.ball.physicsBody applyImpulse:myVector];
    
}


-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for(UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        CGPoint newPosition = CGPointMake(self.size.width-20,location.y);
        
       if(newPosition.y < self.playerPaddle.size.height /2) {
            newPosition.y = self.playerPaddle.size.height/2;
        }
        
       if(newPosition.y > self.size.height - (self.playerPaddle.size.height/2)) {
            newPosition.y = self.size.height - (self.playerPaddle.size.height/2);
        }
        
        self.playerPaddle.position = newPosition;
    }
  

}

-(void)update:(CFTimeInterval)currentTime {
    if(self.npcPaddle.position.y > self.ball.position.y) {
        self.npcPaddle.position = CGPointMake(self.npcPaddle.position.x, self.npcPaddle.position.y - 12);
       
    }
    else if(self.npcPaddle.position.y < self.ball.position.y) {
        self.npcPaddle.position = CGPointMake(self.npcPaddle.position.x, self.npcPaddle.position.y + 12);
    }
    
    if(self.npcPaddle.position.y < self.npcPaddle.size.height / 2) {
        self.npcPaddle.position = CGPointMake(self.npcPaddle.position.x, self.npcPaddle.position.y + 12);
    }
    
    else if(self.npcPaddle.position.y > self.size.height - (self.npcPaddle.size.height / 2)) {
        self.npcPaddle.position = CGPointMake(self.npcPaddle.position.x, self.npcPaddle.position.y - 12);
    }
    
    
 

}

@end

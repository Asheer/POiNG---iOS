//
//  ViewController.m
//  POiNG
//
//  Created by Final on 5/27/14.
//  Copyright (c) 2014 final. All rights reserved.
//

#import "ViewController.h"
#import "MainMenu.h"

@implementation ViewController

-(BOOL) prefersStatusBarHidden {
    return YES;
    
}

-(void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
   // skView.showsFPS = YES;
    //skView.showsNodeCount = YES;
    
    if(!skView.scene) {
        SKScene * scene = [MainMenu sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene.
        [skView presentScene:scene];
    }
   
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end

//
//  JWViewController.h
//  JesterWildApp
//
//  Created by Gerard Moreno-Torres Bertran on 03/05/14.
//  Copyright (c) 2014 Gerard Moreno-Torres Bertran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISlider *progression;
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;
@property (strong, nonatomic) IBOutlet UIButton *playPauseButton;
@property (strong, nonatomic) IBOutlet UILabel *showTitle;

- (IBAction)progressionChanged:(UISlider *)sender;
- (IBAction)volumeChanged:(UISlider *)sender;
- (IBAction)playPause;
- (IBAction)next;
- (IBAction)previous;

@end

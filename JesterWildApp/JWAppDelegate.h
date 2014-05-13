//
//  JWAppDelegate.h
//  JesterWildApp
//
//  Created by Gerard Moreno-Torres Bertran on 03/05/14.
//  Copyright (c) 2014 Gerard Moreno-Torres Bertran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface JWAppDelegate : UIResponder <UIApplicationDelegate, AVAudioPlayerDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

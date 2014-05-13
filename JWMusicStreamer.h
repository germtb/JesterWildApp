//
//  JWMusicStreamer.h
//  JesterWildApp
//
//  Created by Gerard Moreno-Torres Bertran on 03/05/14.
//  Copyright (c) 2014 Gerard Moreno-Torres Bertran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVPlayer.h>
#import <AVFoundation/AVPlayerItem.h>
#import <AVFoundation/AVAsset.h>

@interface JWMusicStreamer : NSObject

- (void) initializeWithProgressBar:(UISlider*)slider andTimerLabel:(UILabel*) label;
- (void) play;
- (void) pause;
- (void) next;
- (void) previous;
- (void) setVolume:(float) value;
- (void) seekToTime:(float) value;
- (NSString*) currentTitle;
- (AVPlayer*) player;

@end
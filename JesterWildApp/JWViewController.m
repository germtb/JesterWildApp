//
//  JWViewController.m
//  JesterWildApp
//
//  Created by Gerard Moreno-Torres Bertran on 03/05/14.
//  Copyright (c) 2014 Gerard Moreno-Torres Bertran. All rights reserved.
//

#import "JWViewController.h"
#import "JWMusicStreamer.h"
#import <Foundation/Foundation.h>
#import <AVFoundation/AVPlayer.h>
#import "Notifications.h"

@interface JWViewController ()
{
    JWMusicStreamer* streamer;
    BOOL isPlaying;
}

@end

@implementation JWViewController

@synthesize progression = _progression;
@synthesize timerLabel = _timerLabel;
@synthesize playPauseButton = _playPauseButton;
@synthesize showTitle = _showTitle;

extern NSString *remoteControlPlayButtonTapped;
extern NSString *remoteControlPauseButtonTapped;
extern NSString *remoteControlStopButtonTapped;
extern NSString *remoteControlForwardButtonTapped;
extern NSString *remoteControlBackwardButtonTapped;
extern NSString *remoteControlOtherButtonTapped;

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    switch (event.subtype)
    {
        case UIEventSubtypeRemoteControlPlay:
            [self postNotificationWithName:remoteControlPlayButtonTapped];
            [self play];
            break;
        case UIEventSubtypeRemoteControlPause:
            [self postNotificationWithName:remoteControlPauseButtonTapped];
            [self pause];
            break;
        case UIEventSubtypeRemoteControlStop:
            [self postNotificationWithName:remoteControlStopButtonTapped];
            [self pause];
            break;
        case UIEventSubtypeRemoteControlNextTrack:
            [self postNotificationWithName:remoteControlForwardButtonTapped];
            [self next];
            break;
        case UIEventSubtypeRemoteControlPreviousTrack:
            [self postNotificationWithName:remoteControlBackwardButtonTapped];
            [self previous];
            break;
        default:
            [self postNotificationWithName:remoteControlOtherButtonTapped];
            break;
    }
}

- (void)postNotificationWithName:(NSString *)name
{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil];
}
 
- (void)viewDidLoad
{
    [super viewDidLoad];
    streamer = [[JWMusicStreamer alloc] init];
    [streamer initializeWithProgressBar:_progression andTimerLabel:_timerLabel];
//  [_progression setThumbImage:[[UIImage alloc] init] forState:UIControlStateNormal];
    isPlaying = NO;
    _showTitle.text = [streamer currentTitle];
    
    NSNotificationCenter* notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:nil name:nil object:streamer.player];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)progressionChanged:(UISlider *)sender
{
    [streamer seekToTime:sender.value];
}

- (IBAction)volumeChanged:(UISlider *)sender
{
    [streamer setVolume:[sender value]];
}

- (IBAction)playPause
{
    if (isPlaying)
        [self pause];
    else
        [self play];
}

- (void) play
{
    [streamer play];
    [_playPauseButton setImage:[UIImage imageNamed:@"pause-100"] forState:UIControlStateNormal];
    isPlaying = YES;
}

- (void)  pause
{
    [streamer pause];
    [_playPauseButton setImage:[UIImage imageNamed:@"play-100"] forState:UIControlStateNormal];
    isPlaying = NO;
}

- (IBAction)previous
{
    [streamer previous];
    [self pause];
    _showTitle.text = [streamer currentTitle];
}

- (IBAction)next
{
    [streamer next];
    [self pause];
    _showTitle.text = [streamer currentTitle];
}

@end




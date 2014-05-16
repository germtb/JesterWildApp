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
#import <MediaPlayer/MPNowPlayingInfoCenter.h>
#import <MediaPlayer/MPMediaItem.h>
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
    isPlaying = NO;

    NSNotificationCenter* notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:nil name:nil object:streamer.player];
    
    [self reloadUI];
}

- (void) reloadUI
{
    _timerLabel.text = @"00:00";
    _progression.value = 0;
    _showTitle.text = [streamer currentTitle];

    
    NSArray *keys = [NSArray arrayWithObjects:
                     MPMediaItemPropertyTitle,
                     MPMediaItemPropertyPlaybackDuration,
                     nil];
    NSArray *values = [NSArray arrayWithObjects:
                       [streamer currentTitle],
                       [NSNumber numberWithDouble:[streamer duration]],
                       nil];
    
    NSDictionary *mediaInfo = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:mediaInfo];
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

- (void) pause
{
    [streamer pause];
    [_playPauseButton setImage:[UIImage imageNamed:@"play-100"] forState:UIControlStateNormal];
    isPlaying = NO;
}

- (IBAction)previous
{
    if (![streamer previous])
        return;
    
    [self pause];

    CGRect origin = _showTitle.frame;
    _showTitle.frame = CGRectMake(origin.origin.x - 1000, origin.origin.y, origin.size.width, origin.size.height);
    [UIView animateWithDuration:0.35 animations:^(void){
        _showTitle.frame = origin;
    }];
    
    [self reloadUI];
}

- (IBAction)next
{
    if (![streamer next])
        return;
    
    [self pause];
    
    CGRect origin = _showTitle.frame;
    _showTitle.frame = CGRectMake(origin.origin.x + 1000, origin.origin.y, origin.size.width, origin.size.height);
    [UIView animateWithDuration:0.35 animations:^(void){
        _showTitle.frame = origin;
    }];
    
    [self reloadUI];
}

@end




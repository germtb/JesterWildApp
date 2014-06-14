//
//  JWMusicStreamer.m
//  JesterWildApp
//
//  Created by Gerard Moreno-Torres Bertran on 03/05/14.
//  Copyright (c) 2014 Gerard Moreno-Torres Bertran. All rights reserved.
//

#import "JWMusicStreamer.h"
#import "JWShows.h"

@interface JWMusicStreamer ()
{
    AVPlayer* player;
    JWShows* shows;
    UISlider* progressBar;
    UILabel* timerLabel;
    id progressBarBlock;
}

@end

@implementation JWMusicStreamer

- (AVPlayer*) player
{
    return player;
}

- (id) initWithProgressBar:(UISlider*)slider andTimerLabel:(UILabel *)label
{
    self = [super init];
    progressBar = slider;
    timerLabel = label;
    
    shows = [[JWShows alloc] init];
    
    [shows addShow:@"http://www.jesterwild.com/podcast/100508_jesterwildshow.mp3" withTitle:@"Volume 01 - Mr. Mojo" withImage:nil];
    
    [progressBar addTarget:self action:@selector(deattachProgressBar) forControlEvents:UIControlEventTouchDown];
    [progressBar addTarget:self action:@selector(attachProgressBar) forControlEvents:UIControlEventTouchUpInside |UIControlEventTouchUpOutside];
    
//  [self initPlayer];
    return self;
}

- (void) initPlayer {
    player = [[AVPlayer alloc] initWithURL:[shows currentShow]];
    [self setProgressBarBlock];
}

- (void) addShow:(NSString *)showURL withTitle:(NSString *)title withImage:(NSString *)imageURL{
    [shows addShow:showURL withTitle:title withImage:imageURL];
}

- (void) play
{
    [player play];
}

- (void) pause
{
    [player pause];
}

- (BOOL) next
{
    NSURL* nextURL = [shows next];
    
    if (nextURL == nil)
        return NO;

    [player removeTimeObserver:progressBarBlock];
    player = [[AVPlayer alloc] initWithURL:nextURL];
    [self setProgressBarBlock];
    return YES;
}

- (BOOL) previous
{
    NSURL* previousURL = [shows previous];
    
    if (previousURL == nil)
        return NO;

    [player removeTimeObserver:progressBarBlock];
    player = [[AVPlayer alloc] initWithURL:previousURL];
    [self setProgressBarBlock];
    return YES;
}

- (NSString*) currentTitle
{
    return [shows currentTitle];
}

- (void) attachProgressBar
{
    [player seekToTime:CMTimeMakeWithSeconds(CMTimeGetSeconds(player.currentItem.asset.duration)*progressBar.value,1)];
    [self performSelector:@selector(play)];
    [self performSelector:@selector(setProgressBarBlock)];
}

- (void) deattachProgressBar
{
    [player removeTimeObserver:progressBarBlock];
}

- (void) setProgressBarBlock
{
    __weak UISlider* wProgressBar = progressBar;
    __weak UILabel* wTimerLabel = timerLabel;
    __weak AVPlayer* wPlayer = player;
    
    progressBarBlock = [player
                        addPeriodicTimeObserverForInterval:CMTimeMake(33, 1000)
                        queue:nil
                        usingBlock:^(CMTime time)
                        {
                            CMTime endTime = CMTimeConvertScale (wPlayer.currentItem.asset.duration, wPlayer.currentTime.timescale,kCMTimeRoundingMethod_RoundHalfAwayFromZero);
                            if (CMTimeCompare(endTime, kCMTimeZero) != 0)
                            {
                                wTimerLabel.text = [JWMusicStreamer secondsToString:(int) CMTimeGetSeconds(wPlayer.currentTime)];
                                wProgressBar.value = (double) wPlayer.currentTime.value / (double) endTime.value;
                            }
                        }];
}

- (double) duration
{
    CMTime endTime = CMTimeConvertScale (player.currentItem.asset.duration, player.currentTime.timescale,kCMTimeRoundingMethod_RoundHalfAwayFromZero);
    
    return CMTimeGetSeconds(endTime);
}

- (void) setVolume:(float)value
{
    [player setVolume:value];
}

+ (NSString*) secondsToString : (int) time
{
    uint minutes = time/60;
    uint seconds = time % 60;
    
    NSString* sMinutes = [@(minutes) stringValue];
    
    if (minutes < 10)
        sMinutes = [NSString stringWithFormat:@"%@%@", @"0", sMinutes];
    
    NSString* sSeconds = [@(seconds) stringValue];
    
    if (seconds < 10)
        sSeconds = [NSString stringWithFormat:@"%@%@", @"0", sSeconds];
    
    return  [NSString stringWithFormat:@"%@:%@", sMinutes, sSeconds];
}

@end

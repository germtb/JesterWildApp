//
//  JWMusicStreamer.m
//  JesterWildApp
//
//  Created by Gerard Moreno-Torres Bertran on 03/05/14.
//  Copyright (c) 2014 Gerard Moreno-Torres Bertran. All rights reserved.
//

#import "JWMusicStreamer.h"
#import "JWSShows.h"

@interface JWMusicStreamer ()
{
    AVPlayer* player;
    JWSShows* shows;
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

- (void) initializeWithProgressBar:(UISlider*)slider andTimerLabel:(UILabel *)label
{
    progressBar = slider;
    timerLabel = label;
    
    shows = [[JWSShows alloc] init];
    [shows initialize];
    [shows addURL:@"http://www.jesterwild.com/podcast/100508_jesterwildshow.mp3" withTitle:@"Volume 01 - Mr. Mojo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/100522_jesterwildshow.mp3" withTitle:@"Volume 02 - Screaming Jordan"];
    [shows addURL:@"http://www.jesterwild.com/podcast/100605_jesterwildshow.mp3" withTitle:@"Volume 03 - Mr. Mojo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/100619_jesterwildshow.mp3" withTitle:@"Volume 04 - Screaming Jordan"];
    [shows addURL:@"http://www.jesterwild.com/podcast/100703_jesterwildshow.mp3" withTitle:@"Volume 05 - Linda Popcorn"];
    [shows addURL:@"http://www.jesterwild.com/podcast/100717_jesterwildshow.mp3" withTitle:@"Volume 06 - Mr. Mojo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/100731_jesterwildshow.mp3" withTitle:@"Volume 07 - Luis Soulful"];
    [shows addURL:@"http://www.jesterwild.com/podcast/100814_jesterwildshow.mp3" withTitle:@"Volume 08 - Mace"];
    
    player = [[AVPlayer alloc] initWithURL:[shows current]];
    [self setProgressBarBlock];
}

- (void) play
{
    [player play];
}

- (void) pause
{
    [player pause];
}

- (void) next
{
    NSURL* nextURL = [shows next];
    
    if (nextURL == nil)
        return;

    [player removeTimeObserver:progressBarBlock];
    player = [[AVPlayer alloc] initWithURL:nextURL];
    [self setProgressBarBlock];
}

- (void) previous
{
    NSURL* previousURL = [shows previous];
    
    if (previousURL == nil)
        return;

    [player removeTimeObserver:progressBarBlock];
    player = [[AVPlayer alloc] initWithURL:previousURL];
    [self setProgressBarBlock];
}

- (NSString*) currentTitle
{
    return [shows currentTitle];
}

- (void) seekToTime:(float)value
{
    [player removeTimeObserver:progressBarBlock];
    [player seekToTime:CMTimeMakeWithSeconds(CMTimeGetSeconds(player.currentItem.asset.duration)*value,1)];
    [self performSelector:@selector(play) withObject:nil afterDelay:1.0];
    [self performSelector:@selector(setProgressBarBlock) withObject:nil afterDelay:1.0];
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
                                wTimerLabel.text = [JWMusicStreamer secondsToCountDown:(int) CMTimeGetSeconds(wPlayer.currentTime)];
                                wProgressBar.value = (double) wPlayer.currentTime.value / (double) endTime.value;
                            }
                        }];
}

- (void) setVolume:(float)value
{
    [player setVolume:value];
}

+ (NSString*) secondsToCountDown : (int) time
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

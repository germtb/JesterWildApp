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

- (void) initializeWithProgressBar:(UISlider*)slider andTimerLabel:(UILabel *)label
{
    progressBar = slider;
    timerLabel = label;
    
    shows = [[JWShows alloc] init];
    [shows initialize];
    [shows addURL:@"http://www.jesterwild.com/podcast/100508_jesterwildshow.mp3" withTitle:@"Volume 01 - Mr. Mojo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/100522_jesterwildshow.mp3" withTitle:@"Volume 02 - Screaming Jordan"];
    [shows addURL:@"http://www.jesterwild.com/podcast/100605_jesterwildshow.mp3" withTitle:@"Volume 03 - Mr. Mojo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/100619_jesterwildshow.mp3" withTitle:@"Volume 04 - Screaming Jordan"];
    [shows addURL:@"http://www.jesterwild.com/podcast/100703_jesterwildshow.mp3" withTitle:@"Volume 05 - Linda Popcorn"];
    [shows addURL:@"http://www.jesterwild.com/podcast/100717_jesterwildshow.mp3" withTitle:@"Volume 06 - Mr. Mojo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/100731_jesterwildshow.mp3" withTitle:@"Volume 07 - Luis Soulful"];
    [shows addURL:@"http://www.jesterwild.com/podcast/100814_jesterwildshow.mp3" withTitle:@"Volume 08 - Mace"];
    [shows addURL:@"http://www.jesterwild.com/podcast/100828_jesterwildshow.mp3" withTitle:@"Volume 09 (Soul Inn Berlin) - Dynamic Don"];
    [shows addURL:@"http://www.jesterwild.com/podcast/100911_jesterwildshow.mp3" withTitle:@"Volume 10 (Pure Souls Record) - Thorsten Wegner"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101009_jesterwildshow.mp3" withTitle:@"Volume 11 (Soulful Torino) - Jimmy Soulful"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101023_jesterwildshow.mp3" withTitle:@"Volume 12 - Bill Kealy"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101113_jesterwildshow.mp3" withTitle:@"Volume 13 (Delinquent Beats HH) - Nils Soehl"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101127_jesterwildshow.mp3" withTitle:@"Volume 14 (Jukebox Jam, London) - Liam Large"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 15 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/110115_jesterwildshow.mp3" withTitle:@"Volume 16 (Dirtyquiff) - Henrik Akerberg"];
    [shows addURL:@"http://www.jesterwild.com/podcast/110129_jesterwildshow.mp3" withTitle:@"Volume 17 (Baltimore) - Action Pat"];
    [shows addURL:@"http://www.jesterwild.com/podcast/110227_jesterwildshow.mp3" withTitle:@"Volume 18 - Christopher Stukenbrock"];
    [shows addURL:@"http://www.jesterwild.com/podcast/110326_jesterwildshow.mp3" withTitle:@"Volume 19 (McCormack's Ballroom) - Screamin' Jordan"];
    /*
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 20 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 21 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 22 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 23 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 24 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 25 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 26 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 27 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 28 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 29 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 30 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 31 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 32 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 33 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 34 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 35 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 36 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 37 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 38 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 39 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 40 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 41 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 42 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 43 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 44 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 45 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 46 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 47 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 48 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 49 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 50 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 51 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 52 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 53 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 54 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 55 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 56 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 57 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 58 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 59 - Alfredo"];
    [shows addURL:@"http://www.jesterwild.com/podcast/101218_jesterwildshow.mp3" withTitle:@"Volume 60 - Alfredo"];
    */
    
    
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

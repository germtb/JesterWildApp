//
//  JWMusicStreamer.m
//  JesterWildApp
//

#import "JWMusicStreamer.h"
#import "JWShows.h"

@interface JWMusicStreamer ()
{
    NSUInteger index;
}

@property(retain,nonatomic) AVPlayer* player;
@property(retain,nonatomic) JWShows* shows;
@property(retain,nonatomic) UISlider* progressBar;
@property(retain,nonatomic) UILabel* timerLabel;
@property(retain,nonatomic) id progressBarBlock;

@end

@implementation JWMusicStreamer

@synthesize player = _player;
@synthesize shows = _shows;
@synthesize progressBar = _progressBar;
@synthesize timerLabel = _timerLabel;
@synthesize progressBarBlock = _progressBarBlock;

- (id) initWithShows:(JWShows*) shows andProgressBar:(UISlider*)progressBar andTimerLabel:(UILabel*) timerLabel
{
    self = [super init];
    _shows = shows;
    index = _shows.lastIndex;
    _progressBar = progressBar;
    _timerLabel = timerLabel;
    [self atatchTouchEventsToProgressBar];
    
    return self;
}

- (void) atatchTouchEventsToProgressBar
{
    [_progressBar addTarget:self action:@selector(deattachProgressBar) forControlEvents:UIControlEventTouchDown];
    [_progressBar addTarget:self action:@selector(attachProgressBar) forControlEvents:UIControlEventTouchUpInside |UIControlEventTouchUpOutside];
}

- (void) initPlayer {
    _player = [[AVPlayer alloc] initWithURL:[_shows showForIndex:_shows.lastIndex]];
    [self setProgressBarBlock];
}

- (void) play
{
    [_player play];
}

- (void) pause
{
    [_player pause];
}

- (BOOL) next
{
    NSURL *nextURL = [_shows showForIndex:(index + 1)];
    
    if (nextURL == nil)
        return NO;

    index++;
    [_player removeTimeObserver:_progressBarBlock];
    _player = [[AVPlayer alloc] initWithURL:nextURL];
    [self setProgressBarBlock];
    return YES;
}

- (BOOL) previous
{
    NSURL *previousURL = [_shows showForIndex:(index - 1)];
    
    if (previousURL == nil)
        return NO;

    index--;
    [_player removeTimeObserver:_progressBarBlock];
    _player = [[AVPlayer alloc] initWithURL:previousURL];
    [self setProgressBarBlock];
    return YES;
}

- (NSString*) currentTitle
{
    return [_shows titleForIndex:index];
}

- (UIImage*) currentImage
{
    return [_shows imageForIndex:index];
}

- (void) attachProgressBar
{
    [_player seekToTime:CMTimeMakeWithSeconds(CMTimeGetSeconds(_player.currentItem.asset.duration)*_progressBar.value,1)];
    [self performSelector:@selector(play)];
    [self performSelector:@selector(setProgressBarBlock)];
}

- (void) deattachProgressBar
{
    [_player removeTimeObserver:_progressBarBlock];
}

- (void) setProgressBarBlock
{
    __weak UISlider* wProgressBar = _progressBar;
    __weak UILabel* wTimerLabel = _timerLabel;
    __weak AVPlayer* wPlayer = _player;
    
    _progressBarBlock = [_player
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
    CMTime endTime = CMTimeConvertScale (_player.currentItem.asset.duration, _player.currentTime.timescale,kCMTimeRoundingMethod_RoundHalfAwayFromZero);
    
    return CMTimeGetSeconds(endTime);
}

- (void) setVolume:(float)value
{
    [_player setVolume:value];
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

- (BOOL) streamShowAtIndex:(NSUInteger)newIndex
{
    NSURL *URL = [_shows showForIndex:newIndex];
    
    if (URL == nil)
        return NO;
    
    index = newIndex;
    [_player removeTimeObserver:_progressBarBlock];
    _player = [[AVPlayer alloc] initWithURL:URL];
    [self setProgressBarBlock];
    return YES;
}

- (NSUInteger) currentIndex
{
    return index;
}

@end

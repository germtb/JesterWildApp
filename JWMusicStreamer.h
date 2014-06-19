//
//  JWMusicStreamer.h
//  JesterWildApp
//

#import "JWShows.h"
#import <Foundation/Foundation.h>
#import <AVFoundation/AVPlayer.h>
#import <AVFoundation/AVPlayerItem.h>
#import <AVFoundation/AVAsset.h>

@interface JWMusicStreamer : NSObject

- (id) initWithShows:(JWShows*) shows andProgressBar:(UISlider*)progressBar andTimerLabel:(UILabel*) timerLabel;
- (BOOL) streamShowAtIndex:(NSUInteger) newIndex;
- (void) initPlayer;
- (void) play;
- (void) pause;
- (BOOL) next;
- (BOOL) previous;
- (void) setVolume:(float) value;
- (NSString*) currentTitle;
- (UIImage*) currentImage;
- (AVPlayer*) player;
- (double) duration;

@end

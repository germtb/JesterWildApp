//
//  JWShows.h
//  JesterWildApp
//

#import <Foundation/Foundation.h>
#import "JWShow.h"

@interface JWShows : NSObject

- (void) addShow : (JWShow*) show;
- (NSUInteger) count;
- (NSUInteger) lastIndex;
- (NSURL*) showForIndex : (NSUInteger) index;
- (NSString*) titleForIndex : (NSUInteger) index;
- (UIImage*) imageForIndex : (NSUInteger) index;

@end

//
//  JWStreamerViewProtocol.h
//  JesterWildApp
//

#import <Foundation/Foundation.h>
#import "JWShows.h"

@protocol JWStreamerViewProtocol <NSObject>

- (BOOL) streamShowAtIndex:(NSUInteger) index;
- (JWShows*) shows;
- (NSUInteger) count;

@end

//
//  JWShows.h
//  JesterWildApp
//
//  Created by Gerard Moreno-Torres Bertran on 03/05/14.
//  Copyright (c) 2014 Gerard Moreno-Torres Bertran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWShows : NSObject

- (void) addShow : (NSString*) showURL withTitle: (NSString*) title withImage: (NSString*) imageURL;
- (NSURL*) next;
- (NSURL*) previous;
- (NSURL*) currentShow;
- (NSString*) currentTitle;
- (NSURL*) currentImage;

@end

//
//  JWShows.h
//  JesterWildApp
//
//  Created by Gerard Moreno-Torres Bertran on 03/05/14.
//  Copyright (c) 2014 Gerard Moreno-Torres Bertran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWShows : NSObject

- (void) initialize;
- (void) addShow : (NSString*) url withTitle: (NSString*) title;
- (NSURL*) next;
- (NSURL*) previous;
- (NSURL*) current;
- (NSString*) currentTitle;

@end

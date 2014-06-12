    //
//  JWShows.m
//  JesterWildApp
//
//  Created by Gerard Moreno-Torres Bertran on 03/05/14.
//  Copyright (c) 2014 Gerard Moreno-Torres Bertran. All rights reserved.
//

#import "JWShows.h"

@interface JWShows () {
    NSUInteger index;
    NSMutableArray* shows;
    NSMutableArray* titles;
}

@end

@implementation JWShows

- (void) initialize {
    index = -1;
    shows = [[NSMutableArray alloc] init];
    titles = [[NSMutableArray alloc] init];
}

- (void) addShow:(NSString *)url withTitle:(NSString *)title {
    [shows addObject:[[NSURL alloc] initWithString:url]];
    [titles addObject:title];
    index++;
}

- (void) addURL:(NSURL *)item {
    [shows addObject:item];
    index++;
}

- (NSURL*) current {
    return [shows objectAtIndex:index];
}

- (NSString*) currentTitle {
    return [titles objectAtIndex:index];
}

- (NSURL*) next {
    if (index == [shows count] - 1)
        return nil;
    
    index++;
    return [shows objectAtIndex:index];
}

- (NSURL*) previous {
    if (index == 0)
        return nil;
    
    index--;
    return [shows objectAtIndex:index];
}

@end

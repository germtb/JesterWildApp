    //
//  JWShows.m
//  JesterWildApp
//
//  Created by Gerard Moreno-Torres Bertran on 03/05/14.
//  Copyright (c) 2014 Gerard Moreno-Torres Bertran. All rights reserved.
//

#import "JWShows.h"

@interface JWShows ()
{
    NSUInteger index;
    NSMutableArray* shows;
    NSMutableArray* titles;
    NSMutableArray* images;
}

@end

@implementation JWShows

- (id) init
{
    self = [super init];
    index = -1;
    shows = [[NSMutableArray alloc] init];
    titles = [[NSMutableArray alloc] init];
    images = [[NSMutableArray alloc] init];
    return self;
}

- (void) addShow:(NSString *) showURL withTitle:(NSString *)title withImage:(NSString *)imageURL
{
    [shows addObject:[[NSURL alloc] initWithString:showURL]];
    [titles addObject:title];
    
//    if (imageURL == nil)
//       [images addObject:[[NSURL alloc] initWithString:imageURL]];
//    else
        [images addObject:showURL];
    
    index++;
}

- (void) addURL:(NSURL *)item
{
    [shows addObject:item];
    index++;
}

- (NSURL*) currentShow
{
    if (index == -1) return nil;
    return [shows objectAtIndex:index];
}

- (NSString*) currentTitle
{
    if (index == -1) return nil;
    return [titles objectAtIndex:index];
}

- (NSURL*) currentImage
{
    if (index == -1) return nil;
    return [images objectAtIndex:index];
}

- (NSURL*) next
{
    if (index == [shows count] - 1)
        return nil;
    
    index++;
    return [shows objectAtIndex:index];
}

- (NSURL*) previous
{
    if (index == 0)
        return nil;
    
    index--;
    return [shows objectAtIndex:index];
}

@end

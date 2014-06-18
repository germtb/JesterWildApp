//
//  JWShows.m
//  JesterWildApp
//

#import "JWShows.h"

@interface JWShows ()
{
    NSMutableDictionary *shows;
    NSMutableDictionary *cachedImages;
}

@end

@implementation JWShows

- (id) init
{
    self = [super init];
    shows = [[NSMutableDictionary alloc] init];
    cachedImages = [[NSMutableDictionary alloc] init];
    return self;
}

- (void) addShow:(JWShow*) show
{
    [shows setObject:show forKey:[NSNumber numberWithLong:self.count]];
}

- (NSUInteger) count
{
    return shows.count;
}

- (NSUInteger) lastIndex
{
    return self.count - 1;
}

- (NSURL*) showForIndex:(NSUInteger)index
{
    return [shows[[NSNumber numberWithLong:index]] getShowURL];
}

- (NSString*) titleForIndex:(NSUInteger)index
{
    return [shows[[NSNumber numberWithLong:index]] getTitle];
}

- (UIImage*) imageForIndex:(NSUInteger)index
{
    NSNumber *key = [NSNumber numberWithLong:index];
    
    if (cachedImages[key] == nil)
    {
        if ([shows[key] getImageURL] != nil)
        {
            NSData *imageData = [[NSData alloc] initWithContentsOfURL: [shows[key] getImageURL]];
            if (imageData != nil)
                cachedImages[key] = [UIImage imageWithData:imageData];
        }
    }
    
    return cachedImages[key];
}

@end

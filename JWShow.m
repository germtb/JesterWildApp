//
//  JWShow.m
//  JesterWildApp
//

#import "JWShow.h"

@interface JWShow()
@property(retain,nonatomic) NSURL* showURL;
@property(retain,nonatomic) NSString* title;
@property(retain,nonatomic) NSURL* imageURL;

@end

@implementation JWShow

@synthesize showURL = _showURL;
@synthesize title = _title;
@synthesize imageURL = _imageURL;

- (id) initWithShowURL:(NSURL *)showURL andTitle:(NSString *)title andImageURL:(NSURL *)imageURL
{
    self = [super init];
    _showURL = showURL;
    _title = title;
    _imageURL = imageURL;
    return self;
}

- (NSURL*) getShowURL
{
    return _showURL;
}

- (NSString*) getTitle
{
    return _title;
}

- (NSURL*) getImageURL
{
    return _imageURL;
}

@end

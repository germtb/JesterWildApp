//
//  JWShow.h
//  JesterWildApp
//

#import <UIKit/UIKit.h>

@interface JWShow : NSObject

- (id) initWithShowURL:(NSURL*) showURL andTitle:(NSString*)title andImageURL:(NSURL*) imageURL;
- (NSURL*) getShowURL;
- (NSString*) getTitle;
- (NSURL*) getImageURL;

@end

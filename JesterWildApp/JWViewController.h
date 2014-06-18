//
//  JWViewController.h
//  JesterWildApp
//

#import <UIKit/UIKit.h>

@interface JWViewController : UIViewController <NSXMLParserDelegate>

@property (strong, nonatomic) IBOutlet UISlider *progression;
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;
@property (strong, nonatomic) IBOutlet UIButton *playPauseButton;
@property (strong, nonatomic) IBOutlet UILabel *showTitle;
@property (strong, nonatomic) IBOutlet UIImageView *showImage;

- (IBAction)volumeChanged:(UISlider *)sender;
- (IBAction)playPause;
- (IBAction)next;
- (IBAction)previous;
- (IBAction)githubLink;
- (IBAction)jesterwildLink;

@end

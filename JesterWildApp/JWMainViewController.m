//
//  JWViewController.m
//  JesterWildApp
//

#import "JWMainViewController.h"
#import "JWShows.h"
#import "JWMusicStreamer.h"
#import <Foundation/Foundation.h>
#import <AVFoundation/AVPlayer.h>
#import <MediaPlayer/MPNowPlayingInfoCenter.h>
#import <MediaPlayer/MPMediaItem.h>
#import "Notifications.h"
#import "JWShowsTableViewController.h"
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>

@interface JWMainViewController ()
{
    JWMusicStreamer* streamer;
    JWShows* shows;
    BOOL isPlaying;
}

@end

@implementation JWMainViewController

@synthesize progression = _progression;
@synthesize timerLabel = _timerLabel;
@synthesize playPauseButton = _playPauseButton;
@synthesize showTitle = _showTitle;
@synthesize showImage = _showImage;

extern NSString *remoteControlPlayButtonTapped;
extern NSString *remoteControlPauseButtonTapped;
extern NSString *remoteControlStopButtonTapped;
extern NSString *remoteControlForwardButtonTapped;
extern NSString *remoteControlBackwardButtonTapped;
extern NSString *remoteControlOtherButtonTapped;

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    switch (event.subtype)
    {
        case UIEventSubtypeRemoteControlPlay:
            [self postNotificationWithName:remoteControlPlayButtonTapped];
            [self play];
            break;
        case UIEventSubtypeRemoteControlPause:
            [self postNotificationWithName:remoteControlPauseButtonTapped];
            [self pause];
            break;
        case UIEventSubtypeRemoteControlStop:
            [self postNotificationWithName:remoteControlStopButtonTapped];
            [self pause];
            break;
        case UIEventSubtypeRemoteControlNextTrack:
            [self postNotificationWithName:remoteControlForwardButtonTapped];
            [self next];
            break;
        case UIEventSubtypeRemoteControlPreviousTrack:
            [self postNotificationWithName:remoteControlBackwardButtonTapped];
            [self previous];
            break;
        default:
            [self postNotificationWithName:remoteControlOtherButtonTapped];
            break;
    }
}

- (void)postNotificationWithName:(NSString *)name
{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil];
}
 
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Initialize shows
    shows = [[JWShows alloc] init];

    //Check network availability
    Reachability *reachability = [Reachability reachabilityForLocalWiFi];
    NetworkStatus networkStatus = reachability.currentReachabilityStatus;
    
    if (networkStatus == NotReachable)
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You have to be connected to a WIFI network to use this app" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    else if (networkStatus == ReachableViaWWAN)
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You have to be connected to a WIFI network to use this app" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    else if (networkStatus == ReachableViaWiFi)
    {
        NSLog(@"All good!");
    }
    
    //Download file: https://dl.dropboxusercontent.com/u/140127353/shows.xml
    NSString *url = @"https://dl.dropboxusercontent.com/u/140127353/shows.xml";
    NSURLRequest *postRequest = [NSURLRequest requestWithURL:[NSURL URLWithString: url]];
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:postRequest returningResponse:&response error:&error];
    
    //Parse
    NSXMLParser *xmlParser = [[NSXMLParser alloc ] initWithData:responseData];
    xmlParser.delegate = self;
    BOOL result = xmlParser.parse;
    
    if (!result){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Connection error" message:@"Make sure you are connected to the internet and try restarting the app" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [alertView show];
        return;
    }

    //Initialize streamer
    streamer = [[JWMusicStreamer alloc] initWithShows:shows andProgressBar:_progression andTimerLabel:_timerLabel];
    isPlaying = NO;
    
    //Init de player
    [streamer initPlayer];
    
    //Link the streamer to the notification center
    NSNotificationCenter* notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:nil name:nil object:streamer.player];
    
    //Set navigation bar
    [self addShowsTableViewController];
    
    [self reloadUI];
}

- (void) addShowsTableViewController
{
    UIBarButtonItem *showsButton = [[UIBarButtonItem alloc] initWithTitle:@"Shows" style:UIBarButtonItemStylePlain target:self action:@selector(pushShowsTableViewController)];
    showsButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = showsButton;
}

- (void) pushShowsTableViewController
{
    JWShowsTableViewController *tableViewController = [[JWShowsTableViewController alloc] initWithStreamerViewProtocol:self];
    [self.navigationController pushViewController: tableViewController animated:YES];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict {
    
    if([elementName isEqualToString:@"show"]) {
        NSURL *showURL = [[NSURL alloc] initWithString:attributeDict[@"showURL"]];
        NSURL *imageURL = nil;
        if (attributeDict[@"imageURL"] != nil)
            imageURL = [[NSURL alloc] initWithString:attributeDict[@"imageURL"]];
        JWShow *newShow = [[JWShow alloc] initWithShowURL:showURL andTitle:attributeDict[@"title"] andImageURL:imageURL];
        [shows addShow:newShow];
    }
}

- (void) reloadUI
{
    _timerLabel.text = @"00:00";
    _progression.value = 0;
    _showTitle.text = [streamer currentTitle];
    _showImage.image = [streamer currentImage];
    
    NSArray *keys = [NSArray arrayWithObjects:
                     MPMediaItemPropertyTitle,
                     MPMediaItemPropertyPlaybackDuration,
                     nil];
    NSArray *values = [NSArray arrayWithObjects:
                       [streamer currentTitle],
                       [NSNumber numberWithDouble:[streamer duration]],
                       nil];
    
    NSDictionary *mediaInfo = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:mediaInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)volumeChanged:(UISlider *)sender
{
    [streamer setVolume:[sender value]];
}

- (IBAction)playPause
{
    if (isPlaying)
        [self pause];
    else
        [self play];
}

- (void) play
{
    [streamer play];
    [_playPauseButton setImage:[UIImage imageNamed:@"pause-100"] forState:UIControlStateNormal];
    isPlaying = YES;
}

- (void) pause
{
    [streamer pause];
    [_playPauseButton setImage:[UIImage imageNamed:@"play-100"] forState:UIControlStateNormal];
    isPlaying = NO;
}

- (IBAction)previous
{
    if (![streamer previous])
    {
        return;
    }
    
    [self pause];
    [self animateHorizontalSlideWithView:_showTitle withHorizontalDistance:-1000];
    [self animateHorizontalSlideWithView:_showImage withHorizontalDistance:-1000];
    [self reloadUI];
    [self play];
}

- (IBAction)githubLink
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/germtb/JesterWildApp"]];
}

- (IBAction)jesterwildLink
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.jesterwild.com"]];    
}

- (IBAction)next
{
    if (![streamer next])
    {
        return;
    }
    
    [self pause];
    [self animateHorizontalSlideWithView:_showTitle withHorizontalDistance:1000];
    [self animateHorizontalSlideWithView:_showImage withHorizontalDistance:1000];
    [self reloadUI];
    [self play];
}

- (void) animateHorizontalSlideWithView:(UIView*) view withHorizontalDistance: (float) horizontalDistance
{
    CGRect origin = view.frame;
    view.frame = CGRectMake(origin.origin.x + horizontalDistance, origin.origin.y, origin.size.width, origin.size.height);
    [UIView animateWithDuration:0.35 animations:^(void){
        view.frame = origin;
    }];
}

//Streamer view protocol methods
- (BOOL) streamShowAtIndex:(NSUInteger)index
{
    [self pause];
    if ([streamer streamShowAtIndex:index])
    {
        [self reloadUI];
        [self play];
        return YES;
    }

    return NO;
}

- (JWShows*) shows
{
    return shows;
}

- (NSUInteger) count
{
    return shows.count;
}

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end




//
//  JWShowsTableViewController.m
//  JesterWildApp
//

#import "JWShowsTableViewController.h"
#import "JWShowCell.h"

@interface JWShowsTableViewController ()

@property(retain,nonatomic) id <JWStreamerViewProtocol> streamerViewProtocol;

@end

@implementation JWShowsTableViewController

@synthesize streamerViewProtocol = _streamerViewProtocol;

- (id) initWithStreamerViewProtocol:(id<JWStreamerViewProtocol>) streamerViewProtocol
{
    self = [super init];
    _streamerViewProtocol = streamerViewProtocol;
    return self;
}

- (void) viewDidLoad
{
    [self.tableView registerClass: [JWShowCell class] forCellReuseIdentifier:@"ShowCell"];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _streamerViewProtocol.count;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_streamerViewProtocol streamShowAtIndex:indexPath.row];
    [[self navigationController] popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ShowCell";
    JWShowCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
        cell = [[JWShowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];

    [cell setLabelText:[[_streamerViewProtocol shows] titleForIndex:indexPath.row]];
    
    return cell;
}


@end

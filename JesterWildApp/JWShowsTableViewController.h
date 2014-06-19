//
//  JWShowsTableViewController.h
//  JesterWildApp
//
//  Created by Gerard Moreno-Torres Bertran on 18/06/14.
//  Copyright (c) 2014 Gerard Moreno-Torres Bertran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWStreamerViewProtocol.h"

@interface JWShowsTableViewController : UITableViewController

- (id) initWithStreamerViewProtocol: (id <JWStreamerViewProtocol> ) streamerViewProtocol;

@end

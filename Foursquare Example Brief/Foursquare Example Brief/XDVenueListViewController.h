//
//  XDTableViewController.h
//  Foursquare Example Brief
//
//  Created by Valentin Hinov on 07/04/2014.
//  Copyright (c) 2014 xDesign365. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDVenueListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

- (void)refreshTable;

@end

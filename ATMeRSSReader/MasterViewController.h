//
//  MasterViewController.h
//  ATMeRSSReader
//
//  Created by Adam Tal on 8/16/13.
//  Copyright (c) 2013 Adam Tal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController <NSXMLParserDelegate>

- (IBAction)refreshView:(id)sender;

- (IBAction)openBrowser:(id)sender;
@end

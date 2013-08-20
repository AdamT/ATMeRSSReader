//
//  DetailViewController.h
//  ATMeRSSReader
//
//  Created by Adam Tal on 8/16/13.
//  Copyright (c) 2013 Adam Tal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *postTitle;
@property (copy, nonatomic) NSString *postContent;
@property (copy, nonatomic) NSString *postCategories;
@property (copy, nonatomic) NSString *postPublishedDate;
@property (nonatomic, assign) BOOL postIsNew;

@property (strong, nonatomic) IBOutlet UILabel *pTitle;
@property (strong, nonatomic) IBOutlet UITextView *pContent;
@property (strong, nonatomic) IBOutlet UILabel *pCategories;
@property (strong, nonatomic) IBOutlet UILabel *pPublishedDate;
@property (strong, nonatomic) IBOutlet UIImageView *pNewImage;


- (IBAction)openPostInBrowser:(id)sender;
@end

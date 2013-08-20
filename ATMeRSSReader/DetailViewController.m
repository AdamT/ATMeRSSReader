//
//  DetailViewController.m
//  ATMeRSSReader
//
//  Created by Adam Tal on 8/16/13.
//  Copyright (c) 2013 Adam Tal. All rights reserved.
//

#import "DetailViewController.h"
#import "PostWebViewViewController.h"

@implementation DetailViewController
@synthesize url, pTitle, pContent, postIsNew, pNewImage;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setupView];
}

-(void)setupView {
    
    self.pTitle.text = self.postTitle;
    self.pContent.text = self.postContent;
    self.title = self.postTitle;
    self.pCategories.text = self.postCategories;
    self.pPublishedDate.text = self.postPublishedDate;
    
    if (postIsNew) {
        UIImage *img = [UIImage imageNamed:@"new-ribbon.png"];
        [pNewImage setImage:img];
    }
    
    [self.pContent setEditable:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"webViewSegue"]) {
        PostWebViewViewController *postVC = (PostWebViewViewController *)segue.destinationViewController;

        [postVC setUrl:url];
    }
}

- (IBAction)openPostInBrowser:(id)sender
{    
    NSString *escapedUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:escapedUrl]];
}
@end

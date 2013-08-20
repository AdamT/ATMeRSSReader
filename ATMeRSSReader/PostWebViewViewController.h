//
//  PostWebViewViewController.h
//  ATMeRSSReader
//
//  Created by Adam Tal on 8/16/13.
//  Copyright (c) 2013 Adam Tal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostWebViewViewController : UIViewController <UIWebViewDelegate> {

    NSString *url;
}

@property (nonatomic) NSString *url;
@property (nonatomic) IBOutlet UIWebView *webView;

@end

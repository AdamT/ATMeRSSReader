//
//  PostCell.h
//  ATMeRSSReader
//
//  Created by Adam Tal on 8/18/13.
//  Copyright (c) 2013 Adam Tal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *postTitle;

@property (strong, nonatomic) IBOutlet UIImageView *category1Image;
@property (strong, nonatomic) IBOutlet UIImageView *category2Image;
@property (strong, nonatomic) IBOutlet UIImageView *category3Image;
@property (strong, nonatomic) IBOutlet UIImageView *category4Image;

@property (strong, nonatomic) IBOutlet UILabel *postPublicationDate;
@property (strong, nonatomic) IBOutlet UIImageView *aNewPostImage;
@end

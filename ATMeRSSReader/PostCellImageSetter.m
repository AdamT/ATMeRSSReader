//
//  PostCellImageSetter.m
//  ATMeRSSReader
//
//  Created by Adam Tal on 8/18/13.
//  Copyright (c) 2013 Adam Tal. All rights reserved.
//

#import "PostCellImageSetter.h"

@implementation PostCellImageSetter

- (NSArray *)enterString:(NSString *)categoriesString {
    
    NSMutableArray *imagesArray = [NSMutableArray arrayWithCapacity:4];
    
    if ([categoriesString rangeOfString:@"iOS"].location != NSNotFound) {
        [imagesArray addObject:@"ios2.png"];
    }
    if ([categoriesString rangeOfString:@"Xcode"].location != NSNotFound) {
        [imagesArray addObject:@"xcode1.png"];
    }
    if ([categoriesString rangeOfString:@"Lean startup"].location != NSNotFound) {
        [imagesArray addObject:@"leanstartup1.jpg"];
    }
    if ([categoriesString rangeOfString:@"vim"].location != NSNotFound) {
        [imagesArray addObject:@"vim1.png"];
    }
    if ([categoriesString rangeOfString:@"Sinatra"].location != NSNotFound) {
        [imagesArray addObject:@"sinatra2.png"];
    }
    if ([categoriesString rangeOfString:@"gem"].location != NSNotFound) {
        [imagesArray addObject:@"rubygems1.png"];
    }
    if ([categoriesString rangeOfString:@"Node.js"].location != NSNotFound) {
        [imagesArray addObject:@"nodejs1.jpg"];
    }
    if ([categoriesString rangeOfString:@"Homebrew"].location != NSNotFound) {
        [imagesArray addObject:@"homebrew1.png"];
    }
    if ([categoriesString rangeOfString:@"Postgresql"].location != NSNotFound) {
        [imagesArray addObject:@"postgres1.png"];
    }
    
    return  imagesArray;
}


@end

//
//  MasterViewController.m
//  ATMeRSSReader
//
//  Created by Adam Tal on 8/16/13.
//  Copyright (c) 2013 Adam Tal. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

#import "MBProgressHUD.h"

#import "PostCell.h"
#import "PostCellImageSetter.h"

@interface MasterViewController () {
    
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *link;
    NSString *element;
    NSMutableString *description;
    NSMutableString *category;
    NSMutableString *publicationDate;
    BOOL isNewPost;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    [self callAndPopulate];
    [self.refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
}

- (void) callAndPopulate {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                
        feeds = [[NSMutableArray alloc] init];
        NSURL *url = [NSURL URLWithString:@"http://adamtal.me/feed/"];
        parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
        [parser setDelegate:self];
        [parser setShouldResolveExternalEntities:NO];
        [parser parse];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *categoryString = [[feeds objectAtIndex:indexPath.row] objectForKey:@"category"];
    PostCellImageSetter *imageSetter = [[PostCellImageSetter alloc] init];
    NSArray *imagesArray = [imageSetter enterString:categoryString];
    
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    
    NSMutableArray *imagesOutletArray = [NSMutableArray arrayWithObjects:cell.category1Image, cell.category2Image, cell.category3Image, cell.category4Image, nil];
    
    // clear images for reuse
    if (cell != nil) {
        for (int counter = 0; counter < [imagesOutletArray count]; counter++) {
            UIImage *nilIcon = nil;
            UIImageView *imageOutlet = [imagesOutletArray objectAtIndex:counter];
            [imageOutlet setImage:nilIcon];
        }
        [cell.aNewPostImage setImage:nil];
    }
    
    // if it's a new/recent post
    BOOL isNew = [[[feeds objectAtIndex:indexPath.row] objectForKey:@"isNewPost"] boolValue];
    if (isNew == YES) {
        UIImage *img = [UIImage imageNamed:@"new-ribbon.png"];
        [cell.aNewPostImage setImage:img];
    }

    cell.postTitle.text = [[feeds objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.postPublicationDate.text = [[feeds objectAtIndex:indexPath.row] objectForKey:@"pubDate"];

    // set category/tag images
    for (int objectIndex = 0; objectIndex < [imagesArray count]; objectIndex++) {
        UIImage *icon = [UIImage imageNamed:[imagesArray objectAtIndex:objectIndex]];
        UIImageView *imageOutlet = [imagesOutletArray objectAtIndex:objectIndex];
        [imageOutlet setImage:icon];
    }

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSString *url                 = [feeds[indexPath.row] objectForKey:@"link"];
        NSString *postTitle           = [feeds[indexPath.row] objectForKey:@"title"];
        NSString *postContent         = [feeds[indexPath.row] objectForKey:@"description"];
        NSString *postCategories      = [feeds[indexPath.row] objectForKey:@"category"];
        NSString *postPublicationDate = [feeds[indexPath.row] objectForKey:@"pubDate"];
        isNewPost                     = [[feeds[indexPath.row] objectForKey:@"isNewPost"] boolValue];

        [[segue destinationViewController] setUrl:url];
        [[segue destinationViewController] setPostTitle:postTitle];
        [[segue destinationViewController] setPostContent:postContent];
        [[segue destinationViewController] setPostCategories:postCategories];
        [[segue destinationViewController] setPostPublishedDate:postPublicationDate];
        [[segue destinationViewController] setPostIsNew:isNewPost];
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {

    element = elementName;
    
    if ([element isEqualToString:@"item"]) {
        
        item = [[NSMutableDictionary alloc] init];

        title           = [[NSMutableString alloc] init];
        link            = [[NSMutableString alloc] init];
        description     = [[NSMutableString alloc] init];
        category        = [[NSMutableString alloc] init];
        publicationDate = [[NSMutableString alloc] init];
        isNewPost       = NO;

    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    }
    
    else if ([element isEqualToString:@"link"]) {
        [link appendString:string];
    }
    
    else if ([element isEqualToString:@"description"]) {
        [description appendString:string];
    }
    
    else if ([element isEqualToString:@"category"]) {
        [category appendString:string];
    }
    
    else if ([element isEqualToString:@"pubDate"]) {

        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];

        [dateFormat setDateFormat:@"EE, d LLLL yyyy HH:mm:ss Z"];
        NSDate *date = [dateFormat dateFromString:string];
        [dateFormat setDateStyle:NSDateFormatterMediumStyle];
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDate *todaysDate = [NSDate date];
        NSDateComponents *comps = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                         fromDate:todaysDate];
        NSDate *today = [cal dateFromComponents:comps];
        
        if (date != nil){
            NSTimeInterval diff = [today timeIntervalSinceDate:date];
            if (diff < 2678400) {
                isNewPost = YES;
            }

            NSString *dateString = [dateFormat stringFromDate:date];
            [publicationDate appendString:dateString];
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {

    if ([elementName isEqualToString:@"item"]) {
        
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
        [item setObject:description forKey:@"description"];
        [item setObject:category forKey:@"category"];
        [item setObject:publicationDate forKey:@"pubDate"];
        [item setObject:[NSNumber numberWithBool:isNewPost] forKey:@"isNewPost"];
                
        [feeds addObject:[item copy]];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
        
    [self.tableView reloadData];
}

- (IBAction)refreshView:(id)sender {
    
    [self callAndPopulate];
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
}

- (IBAction)openBrowser:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.adamtal.me"]];
}
@end

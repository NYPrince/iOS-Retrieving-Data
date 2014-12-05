//
//  MainViewController.h
//  RssFeed
//
//  Created by Rick Williams on 6/18/14.
//  Copyright (c) 2014 Rick Williams. All rights reserved.
//
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSURLConnectionDelegate>



@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong)NSMutableArray * appleInfo;

@property (nonatomic, strong)NSMutableData * appleData;

@property (nonatomic, retain)NSString * myURL;

- (IBAction)loadData:(id)sender;

@end

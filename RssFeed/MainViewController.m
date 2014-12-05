//
//  MainViewController.m
//  RssFeed
//
//  Created by Rick Williams on 6/18/14.
//  Copyright (c) 2014 Rick Williams. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"
#import "Entry.h"



@interface MainViewController (){
    
    NSMutableData * appleData;
    
    NSURLConnection * connect;
    
    NSMutableArray * appleInfo;
    
}

@end

@implementation MainViewController
@synthesize appleInfo, appleData ;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title= @"retrieving data from the web";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    
}




- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    appleData = [[NSMutableData alloc]init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)myData {
    
    [appleData appendData:myData];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
   
    NSDictionary * alldata = [ NSJSONSerialization JSONObjectWithData:appleData options:0 error:nil];
    
    NSDictionary * feed = [alldata objectForKey:@"feed"];
    NSArray * entryArray = [ feed objectForKey:@"entry"];
    
    appleInfo = [[NSMutableArray alloc]init];
    
    for (NSDictionary * diction in entryArray) {
        
        Entry * entry = [[Entry alloc] init];
        entry.title = [[diction objectForKey:@"title"] objectForKey:@"label"];
        entry.summary = [[diction objectForKey:@"summary"] objectForKey:@"label"];
        entry.images = [diction objectForKey:@"im:image"];
        
   
        [appleInfo addObject:entry];
    }
    
    

    [self.tableView reloadData];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    UIAlertView *errorView =[[UIAlertView alloc] initWithTitle:@"Error" message:@"Internet connect is needed, make sure you are connected and try again" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
    [errorView show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
}


-(int)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [appleInfo count];
   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        static NSString *CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Entry * currentEntryForIndexRow = [appleInfo objectAtIndex:indexPath.row];
    
    cell.textLabel.text = currentEntryForIndexRow.title;
    cell.detailTextLabel.text = currentEntryForIndexRow.artist;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
     NSLog(@"didSelectRowAtIndexPath");
    [self performSegueWithIdentifier:@"DetailViewSegue" sender:nil];
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue");
    NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
    Entry * currentEntryForIndexRow = [appleInfo objectAtIndex:indexPath.row];
    DetailViewController *detailVC = segue.destinationViewController;
    [detailVC setEntry:currentEntryForIndexRow];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadData:(id)sender {
    
    [appleInfo removeAllObjects];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURL *url = [NSURL URLWithString:@"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topgrossingapplications/sf=143441/limit=25/json"];
    NSURLRequest * req = [NSURLRequest requestWithURL:url];
    connect = [NSURLConnection connectionWithRequest:req delegate:self];
    
    if (connect) {
        appleData = [[NSMutableData alloc]init];
    }
    
}
@end

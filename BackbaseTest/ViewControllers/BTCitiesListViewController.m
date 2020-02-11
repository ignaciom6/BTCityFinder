//
//  BTCitiesListViewController.m
//  BackbaseTest
//
//  Created by Ignacio on 11/02/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

#import "BTCitiesListViewController.h"

@interface BTCitiesListViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *citiesArray;
@property (strong, nonatomic) NSMutableArray *citySearchArray;
@property (assign, nonatomic) BOOL userStartedSearching;

@end

@implementation BTCitiesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    
    self.citySearchArray = [[NSMutableArray alloc] init];
    
    self.citiesArray = [[NSArray alloc] initWithObjects:@"Paris",
                        @"Stockholm",
                        @"Amsterdam",
                        @"Munich",
                        @"Madrid",
                        @"Oslo",
                        @"Moscow",
                        @"Oklahoma",
                        @"Porto",
                        @"Roma",nil];
    
    self.citiesArray = [self orderArrayAlphabetically:self.citiesArray];
    
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = self.citiesArray.count;
    if (self.userStartedSearching) {
        rows = self.citySearchArray.count;
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cityCell"];
    
    if (self.userStartedSearching) {
        cell.textLabel.text = [self.citySearchArray objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [self.citiesArray objectAtIndex:indexPath.row];
    }
    
    return cell;
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if (searchText.length != 0) {
        self.userStartedSearching = YES;
        [self.citySearchArray removeAllObjects];

        for (NSString* city in self.citiesArray)
        {
            NSRange nameRange = [city rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(nameRange.length != 0 && nameRange.location == 0)
            {
                [self.citySearchArray addObject:city];
            }
        }
    } else {
        self.userStartedSearching = NO;
    }
    
    self.citySearchArray = [self orderArrayAlphabetically:self.citySearchArray];
    [self.tableView reloadData];

}

- (NSArray *)orderArrayAlphabetically:(NSArray *)array
{
    return [array sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

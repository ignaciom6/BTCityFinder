//
//  BTCitiesListViewController.m
//  BackbaseTest
//
//  Created by Ignacio on 11/02/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

#import "BTCitiesListViewController.h"
#import "BTArraySearcher.h"
#import "BTCityListManager.h"
#import "BTCityModel.h"
#import "BTCitiesMapViewController.h"

static NSString *const kCellIdentifier = @"cityCell";
static NSString *const kListToMapSegueIdentifier = @"ListToMapSegue";

@interface BTCitiesListViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *citiesArray;
@property (strong, nonatomic) NSMutableArray *citySearchArray;
@property (assign, nonatomic) BOOL userStartedSearching;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;
@property (strong, nonatomic) BTCityListManager *cityListManager;
@property (strong, nonatomic) BTCityModel *city;

@end

@implementation BTCitiesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    
    self.citySearchArray = [[NSMutableArray alloc] init];
    self.cityListManager = [[BTCityListManager alloc] init];

//    self.citiesArray = [[NSArray alloc] initWithObjects:@"Paris",
//                        @"Stockholm",
//                        @"Amsterdam",
//                        @"Munich",
//                        @"Madrid",
//                        @"Oslo",
//                        @"Moscow",
//                        @"Oklahoma",
//                        @"Porto",
//                        @"Roma",
//                        @"Rome",
//                        @"Bangkok",
//                        @"Ontario",
//                        @"Orlando",
//                        @"Ankara",
//                        @"Alabama",
//                        @"Ohio",
//                        @"Omaha",
//                        @"Munster",
//                        @"Rotterdam",
//                        @"Salzburg",
//                        @"Oncativo",nil];
    
//    self.citiesArray = [self orderArrayAlphabetically:self.citiesArray];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showLoading];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
        
    __weak typeof(self) weakSelf = self;
    
    [self.cityListManager getCitiesArrayWithCompletion:^(NSArray * _Nonnull value, NSError * _Nonnull error) {
        if (value) {
            weakSelf.citiesArray = value;
            weakSelf.citiesArray = [weakSelf orderArrayAlphabetically:weakSelf.citiesArray];
            [weakSelf.tableView reloadData];
            [weakSelf hideLoading];
        } else {
            //Report failure
        }
    }];
}

-(void)showLoading
{
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinner.center = self.view.center;
    [self.view addSubview:self.spinner];
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        [self.spinner startAnimating];
    });
    
}

-(void)hideLoading
{
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        [self.spinner stopAnimating];
    });
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
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if (self.userStartedSearching) {
        self.city = [self.citySearchArray objectAtIndex:indexPath.row];
    } else {
        self.city = [self.citiesArray objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = self.city.composedName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Latitude: %f, Longitude: %f", self.city.coordDataModel.latitude, self.city.coordDataModel.longitude];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.userStartedSearching) {
        self.city = [self.citySearchArray objectAtIndex:indexPath.row];
    } else {
        self.city = [self.citiesArray objectAtIndex:indexPath.row];
    }
    
    [self performSegueWithIdentifier:kListToMapSegueIdentifier sender:self];
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length != 0) {
        self.userStartedSearching = YES;
//        self.citySearchArray = [BTArraySearcher searchText:searchText inArray:self.citiesArray];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"composedName beginswith[c] %@", searchText];
        self.citySearchArray = [[self.citiesArray filteredArrayUsingPredicate:predicate] mutableCopy];
        
    } else {
        self.userStartedSearching = NO;
    }
    
    [self.tableView reloadData];

}

- (NSArray *)orderArrayAlphabetically:(NSArray *)array
{
    NSSortDescriptor * nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"composedName" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    
    return [array sortedArrayUsingDescriptors:@[nameDescriptor]];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqual:kListToMapSegueIdentifier])
    {
        BTCitiesMapViewController *mapVC = (BTCitiesMapViewController*)segue.destinationViewController;
        [mapVC setCustomCity:self.city];
        
    }
}


@end

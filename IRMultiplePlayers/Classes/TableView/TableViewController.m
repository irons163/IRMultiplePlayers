//
//  TableViewController.m
//  IRMultiplePlayers
//
//  Created by irons on 2021/3/25.
//

#import "TableViewController.h"
#import "TableViewViewModel.h"
#import "TableViewCell.h"

@interface TableViewController () <UITableViewDelegate, TableViewViewModelDelegate>

@property TableViewViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [[TableViewViewModel alloc] initWithTableView:self.tableView];
    self.viewModel.delegate = self;
    [self.viewModel update];
    
    self.tableView.dataSource = self.viewModel;
    self.tableView.estimatedRowHeight = 160;
}

@end

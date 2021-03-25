//
//  ViewController.m
//  IRMultiplePlayers
//
//  Created by irons on 2021/3/25.
//

#import "ViewController.h"
#import "TableViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSArray *items;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.items = @[@"TableView", @"CollectionView"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = nil;
    
    switch (indexPath.row) {
        case 0:
            vc = [TableViewController new];
            break;
        case 1:
            
            break;
        default:
            break;
    }
    
    [self.navigationController pushViewController:vc animated:nil];
}

@end

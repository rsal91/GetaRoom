//
//  RoomsViewController.m
//  GetaRoom
//
//  Created by Roman Salazar Lopez on 12/1/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

#import "RoomsViewController.h"
#import "Room.h"
#import "Hotel.h"

@interface RoomsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *datasource;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation RoomsViewController

- (void)loadView
{
	[super loadView];
	[self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupRoomsViewController];
	[self setupTableView];
	
}

- (void)setupRoomsViewController
{
	[self setTitle:@"Rooms"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupTableView
{
	self.tableView = [[UITableView alloc]init];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	[self.tableView registerClass:[UITableView class] forCellReuseIdentifier:@"cell"];
	
	NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop	relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
	NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
	NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
	NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
	
	top.active = YES;
	leading.active = YES;
	bottom.active = YES;
	trailing.active = YES;
	
	[self.view addSubview:self.tableView];
	self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.hotel.rooms count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
	if (!cell)
	{
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	}
	Room *room = (Room *)[self.hotel.rooms allObjects][indexPath.row];
	cell.textLabel.text = [NSString stringWithFormat:@"Room: %i (%i beds, $%0.2f per night)", room.roomNumber.intValue, room.beds.intValue, room.rate.floatValue];
	
	return cell;
}

#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
	return 200.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UIImage *headerImage = [UIImage imageNamed:@"room.jpg"];
	UIImageView *imageView = [[UIImageView alloc]initWithImage:headerImage];
	
	imageView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), 200.0);
	imageView.contentMode = UIViewContentModeScaleAspectFill;
	imageView.clipsToBounds = YES;
	return  imageView;
}

@end

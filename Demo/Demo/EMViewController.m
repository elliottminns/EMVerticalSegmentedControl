//
//  EMViewController.m
//  Demo
//
//  Created by Elliott Minns on 27/02/2014.
//  Copyright (c) 2014 Elliott Minns. All rights reserved.
//

#import "EMViewController.h"
#import "EMVerticalSegmentedControl.h"

@interface EMViewController ()

@end

@implementation EMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    EMVerticalSegmentedControl *control = [[EMVerticalSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 150, 140)];
    control.sectionTitles = @[@"On", @"Off", @"Maybe", @"Could you repeat?"];
    [control addTarget:self action:@selector(segmentDidChange:) forControlEvents:UIControlEventValueChanged];
    
    [control setIndexChangeBlock:^(NSInteger index) {
        NSLog(@"Value changed in block: %lu", index);
    }];
    
    [self.view addSubview:control];
    control.center = CGPointMake(320 / 2, 568 / 2);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)segmentDidChange:(id)sender {
    NSInteger index = ((EMVerticalSegmentedControl *)sender).selectedSegmentIndex;
    NSLog(@"Value changed selector: %lu", index);
}

@end

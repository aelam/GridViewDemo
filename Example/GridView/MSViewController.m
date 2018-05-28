//
//  MSViewController.m
//  GridView
//
//  Created by aelam on 05/28/2018.
//  Copyright (c) 2018 aelam. All rights reserved.
//

@import GridView;

#import "MSViewController.h"

@interface MSViewController ()

@end

@implementation MSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gotoGrid {
    ZXGGridViewController *controller = [ZXGGridViewController new];
    [self.navigationController pushViewController: controller animated: YES];
    
}

@end

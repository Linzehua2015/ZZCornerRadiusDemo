//
//  ViewController.m
//  ZZCornerRadiusDemo
//
//  Created by 林泽华 on 17/2/28.
//  Copyright © 2017年 林泽华. All rights reserved.
//

#import "ViewController.h"
#import "UIView-CornerRadius.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor yellowColor];
    view.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:view];
    
    [view addImageWithCornerRadius:50 color:[UIColor redColor]];
}

@end

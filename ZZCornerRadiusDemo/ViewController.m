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
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test"]];
    imageView.backgroundColor = [UIColor yellowColor];
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.frame = CGRectMake(100, 100, 100, 100);
//    imageView.layer.masksToBounds = YES;
    [self.view addSubview:imageView];
    
    [imageView addImageWithCornerRadius:50 color:[UIColor redColor]];
}

@end

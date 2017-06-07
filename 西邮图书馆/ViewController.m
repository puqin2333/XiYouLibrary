//
//  ViewController.m
//  西邮图书馆
//
//  Created by 陈普钦 on 16/11/14.
//  Copyright (c) 2016年 陈普钦. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (id)initwithPageNumber:(NSInteger)pageNumber
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height * 0.25)];
    [self.view addSubview:self.imageView];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

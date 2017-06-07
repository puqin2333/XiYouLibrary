//
//  FeHandwritingViewController.m
//  FeSpinner
//
//  Created by Nghia Tran on 1/2/15.
//  Copyright (c) 2015 fe. All rights reserved.
//

#import "FeHandwritingViewController.h"
#import "FeHandwriting.h"
#import "UIColor+flat.h"

@interface FeHandwritingViewController ()
@property (strong, nonatomic) FeHandwriting *handwritingLoader;

@end

@implementation FeHandwritingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.view.backgroundColor = [UIColor colorWithHexCode:@"#ffe200"];
    self.view.backgroundColor = [UIColor colorWithRed:84.0/255 green:181.0/255 blue:239.0/255.0 alpha:255.0/225.0];
    
    _handwritingLoader = [[FeHandwriting alloc] initWithView:self.view];
    [self.view addSubview:_handwritingLoader];
    
    [_handwritingLoader showWhileExecutingBlock:^{
        [self myTask];
    } completion:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
- (void)myTask
{
    // Do something usefull in here instead of sleeping ...
    sleep(3);
}

@end

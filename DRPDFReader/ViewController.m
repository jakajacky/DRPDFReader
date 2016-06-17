//
//  ViewController.m
//  DRPDFReader
//
//  Created by xqzh on 16/6/16.
//  Copyright © 2016年 xqzh. All rights reserved.
//

#import "ViewController.h"
#import "DRPDFViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openPdf1:(id)sender {
    DRPDFViewController *pdf = [[DRPDFViewController alloc] initWithFileName:@"1" TransitionStyle:UIPageViewControllerTransitionStylePageCurl];
    [self presentViewController:pdf animated:YES completion:^{
        
    }];
}

- (IBAction)openPdf2:(id)sender {
    DRPDFViewController *pdf = [[DRPDFViewController alloc] initWithFileName:@"2" TransitionStyle:UIPageViewControllerTransitionStyleScroll];
    [self presentViewController:pdf animated:YES completion:^{
        
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

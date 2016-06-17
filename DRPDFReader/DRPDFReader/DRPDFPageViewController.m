//
//  DRPDFPageViewController.m
//  DRPDFReader
//
//  Created by xqzh on 16/6/17.
//  Copyright © 2016年 xqzh. All rights reserved.
//

#import "DRPDFPageViewController.h"
#import "DRPDFView.h"

@interface DRPDFPageViewController ()


@property (strong, nonatomic) IBOutlet DRPDFView *containerView;



@end

@implementation DRPDFPageViewController


- (instancetype)initWithpage:(NSInteger)pageNum {
    self = [super init];
    if (self) {
//        _containerView = [[DRPDFView alloc] initWithFrame:CGRectMake(0, 0, 200, 200) page:pageNum];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

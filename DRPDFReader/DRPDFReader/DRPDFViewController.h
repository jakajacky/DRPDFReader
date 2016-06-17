//
//  ViewController.h
//  DRPDFReader
//
//  Created by xqzh on 16/6/15.
//  Copyright © 2016年 xqzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRPDFViewController : UIViewController

@property (strong, nonatomic) NSString *fileName;

- (instancetype)initWithFileName:(NSString *)filename TransitionStyle:(UIPageViewControllerTransitionStyle)style;

@end


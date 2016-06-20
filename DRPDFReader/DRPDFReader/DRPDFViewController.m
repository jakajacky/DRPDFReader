//
//  ViewController.m
//  DRPDFReader
//
//  Created by xqzh on 16/6/15.
//  Copyright © 2016年 xqzh. All rights reserved.
//

#import "DRPDFViewController.h"
#import "DRPDFView.h"
#import "DRPDFPageViewController.h"

@interface DRPDFViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageController;

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic) UIPageViewControllerTransitionStyle style;

@end

@implementation DRPDFViewController

- (instancetype)initWithFileName:(NSString *)filename TransitionStyle:(UIPageViewControllerTransitionStyle)style{
    self = [super init];
    if (self) {
        _fileName = filename;
        _style    = style;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 计算pdf页数
    NSInteger count = [DRPDFView getPdfPageNumber:_fileName];
    
    _array = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 1; i <= count; i++) {
        DRPDFView *pdf = [[DRPDFView alloc] initWithFrame:[UIScreen mainScreen].bounds page:i];
        pdf.fileName = _fileName;
        pdf.backgroundColor = [UIColor whiteColor];
       [_array addObject:pdf];
//        DRPDFPageViewController *p = [[DRPDFPageViewController alloc] initWithpage:i];
//        [_array addObject:p];
    }
    
    
    // 设置UIPageViewController的配置项
    NSDictionary *options =[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
                            
                                                       forKey: UIPageViewControllerOptionSpineLocationKey];
    
    
    
    // 实例化UIPageViewController对象，根据给定的属性
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:_style
                           
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                           
                                                                        options: options];
    
    // 设置UIPageViewController对象的代理
    _pageController.dataSource = self;
    
    // 定义“这本书”的尺寸
    [[_pageController view] setFrame:[[self view] bounds]];

    DRPDFPageViewController *initialViewController =[self viewControllerAtIndex:0];// 得到第一页
    
    NSArray *viewControllers =[NSArray arrayWithObject:initialViewController];

    [_pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    _pageController.view.backgroundColor = [UIColor grayColor];
    [self addChildViewController:_pageController];
    [self.view addSubview:_pageController.view];
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    
    NSUInteger index = [self indexOfViewController:(UIViewController *)viewController];
    
    if ((index == 0) || (index == NSNotFound)) {
        
        if (index == 0) {
            self.pageController.viewControllers[0].view.subviews[1].frame = [UIScreen mainScreen].bounds;
            [self.pageController.viewControllers[0].view.subviews[1] setNeedsDisplay];
        }
        
        return nil;
        
    }
    
    index--;
    
    // 返回的ViewController，将被添加到相应的UIPageViewController对象上。
    
    // UIPageViewController对象会根据UIPageViewControllerDataSource协议方法，自动来维护次序。
    
    // 不用我们去操心每个ViewController的顺序问题。
    
    self.pageController.viewControllers[0].view.subviews[1].frame = [UIScreen mainScreen].bounds;
    [self.pageController.viewControllers[0].view.subviews[1] setNeedsDisplay];
    
    return [self viewControllerAtIndex:index];
    
    
    
}


// 返回下一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    
    NSUInteger index = [self indexOfViewController:(UIViewController *)viewController];
    
    viewController = nil;
    
    if (index == NSNotFound) {
        
        return nil;
        
    }
    
    index++;
    
    if (index == [self.array count]) {
        
        return nil;
        
    }
    
    self.pageController.viewControllers[0].view.subviews[1].frame = [UIScreen mainScreen].bounds;
    [self.pageController.viewControllers[0].view.subviews[1] setNeedsDisplay];
    
    return [self viewControllerAtIndex:index];
    
    
    
}

// 得到相应的VC对象
- (DRPDFPageViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    if (([self.array count] == 0) || (index >= [self.array count])) {
        
        return nil;
        
    }


    DRPDFView *pdf = [[DRPDFView alloc] initWithFrame:[UIScreen mainScreen].bounds page:index];
    pdf.fileName = _fileName;
    pdf.backgroundColor = [UIColor whiteColor];
    
    // 创建一个新的控制器类，并且分配给相应的数据
    
    DRPDFPageViewController *dataViewController =[[DRPDFPageViewController alloc] init];
    
    DRPDFView *p = [self.array objectAtIndex:index];
    p.frame = [UIScreen mainScreen].bounds;
    [dataViewController.view addSubview:p];
    
    NSLog(@"%@", dataViewController.view.subviews);
    return dataViewController;
    
}


// 根据数组元素值，得到下标值
- (NSUInteger)indexOfViewController:(UIViewController *)viewController {
    
    return [self.array indexOfObject:viewController.view.subviews[1]];
//    return [self.array indexOfObject:viewController];
    
}

#pragma mark -
#pragma mark 适配横竖屏
- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    NSLog(@"%d", [UIApplication sharedApplication].statusBarOrientation);
    self.pageController.viewControllers[0].view.subviews[1].frame = [UIScreen mainScreen].bounds;
    [self.pageController.viewControllers[0].view.subviews[1] setNeedsDisplay];
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        orientation = UIInterfaceOrientationPortrait;
    }
    return orientation;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

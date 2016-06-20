//
//  DRPDFView.h
//  DRPDFReader
//
//  Created by xqzh on 16/6/15.
//  Copyright © 2016年 xqzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRPDFView : UIView<NSCopying>

@property (strong, nonatomic) NSString *fileName;

- (instancetype)initWithFrame:(CGRect)frame page:(NSInteger)pageNum;


+ (NSInteger)getPdfPageNumber:(NSString *)filename;

@end

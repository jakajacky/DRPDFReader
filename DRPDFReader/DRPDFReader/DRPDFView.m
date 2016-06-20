//
//  DRPDFView.m
//  DRPDFReader
//
//  Created by xqzh on 16/6/15.
//  Copyright © 2016年 xqzh. All rights reserved.
//

#import "DRPDFView.h"

@interface DRPDFView ()
{
    NSInteger    pagenum;
    CGContextRef myContext;
}

@end

@implementation DRPDFView

- (instancetype)initWithFrame:(CGRect)frame page:(NSInteger)pageNum {
    self = [super initWithFrame:frame];
    if (self) {
        pagenum = pageNum;
    }
    return self;
}

- (void) drawRect:(CGRect)rect {
    self.frame = [UIScreen mainScreen].bounds;
    NSLog(@"%f---%f", [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    // 获取上下文
    myContext = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(myContext, (self.frame.size.width - 610) / 2, (self.frame.size.height + 800) / 2);
    CGContextScaleCTM(myContext, 1, -1);
    
    NSString *f = [[NSBundle mainBundle] pathForResource:_fileName ofType:@"pdf"];
    [self DisplayPDFPage:myContext num:pagenum name:f];
    
}

- (CGPDFDocumentRef)GetPDFDocumentRef:(NSString *)filename {
    CFStringRef path;
    CFURLRef url;
    CGPDFDocumentRef document;
    size_t count;
    
    path = CFStringCreateWithCString (NULL, [filename UTF8String], kCFStringEncodingUTF8);
    url = CFURLCreateWithFileSystemPath (NULL, path, kCFURLPOSIXPathStyle, 0);
    
    CFRelease (path);
    document = CGPDFDocumentCreateWithURL (url);
    CFRelease(url);
    count = CGPDFDocumentGetNumberOfPages (document);
    if (count == 0) {
        printf("[%s] needs at least one page!\n", [filename UTF8String]);
        return NULL;
    } else {
        printf("[%ld] pages loaded in this PDF!\n", count);
    }
    return document;
}

- (void)DisplayPDFPage:(CGContextRef)mycontext num:(size_t)pageNum name:(NSString *)filename{
    CGPDFDocumentRef document;
    CGPDFPageRef page;
    
    document = [self GetPDFDocumentRef:filename];
    page = CGPDFDocumentGetPage (document, pageNum);
    CGContextDrawPDFPage (mycontext, page);
    CGPDFDocumentRelease (document);
}

+ (NSInteger)getPdfPageNumber:(NSString *)filename {
    CFStringRef path;
    CFURLRef url;
    CGPDFDocumentRef document;
    size_t count;
    
    NSString *f = [[NSBundle mainBundle] pathForResource:filename ofType:@"pdf"];
    path = CFStringCreateWithCString (NULL, [f UTF8String], kCFStringEncodingUTF8);
    url = CFURLCreateWithFileSystemPath (NULL, path, kCFURLPOSIXPathStyle, 0);
    
    CFRelease (path);
    document = CGPDFDocumentCreateWithURL (url);
    CFRelease(url);
    count = CGPDFDocumentGetNumberOfPages (document);
    
    return count;
}


#pragma mark -
#pragma mark 本来是要用copy的，后来因为将pdfView作为子视图了，所以取消了这计划
- (id)copyWithZone:(NSZone *)zone
{
    DRPDFView *result = [[[self class] allocWithZone:zone] init];
    return result;
}

@end

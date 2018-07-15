//
//  UIView-CornerRadius.m
//  ExpressionKingdom
//
//  Created by 林泽华 on 17/2/24.
//  Copyright © 2017年 LinZehua. All rights reserved.
//

#import "UIView-CornerRadius.h"

@implementation UIColor(Components)

- (NSString *)colorComponent {
    
    CGColorRef cgColor = self.CGColor;
    
    const CGFloat *colorComponents = CGColorGetComponents(cgColor);
    
    CGFloat r = colorComponents[0];
    CGFloat g = colorComponents[1];
    CGFloat b = colorComponents[2];
    
    NSString *result = [NSString stringWithFormat:@"r%f_g%f_b%f", r, g, b];
    return result;
}

@end

@implementation UIView(CornerRadius)

- (void)addImageWithCornerRadius:(CGFloat)radius color:(UIColor *)color {
    __weak __typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf addImageWithCornerRadius:radius color:color size:weakSelf.bounds.size];
    });
}

- (void)addImageWithCornerRadius:(CGFloat)radius color:(UIColor *)color size:(CGSize)size {
    
    // 根据颜色，圆角程度，尺寸 命名文件
    NSString *name = [NSString stringWithFormat:@"%@_%f_%@.png", [color colorComponent], radius, NSStringFromCGSize(size)];
    NSString *fullPath = [[self pathWithFolder:@"CornerRadius"] stringByAppendingPathComponent:name];
    
    // 判断本地是否已经有缓存了
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExists = [fileManager fileExistsAtPath:fullPath];
    UIImage *image;
    if (isExists) {
        // 从缓存中获取
        image = [UIImage imageNamed:fullPath];
    } else {
        // 缓存中没有 -> 生成图片 -> 保存
        image = [self getImageWithSize:size color:color radius:radius];
        NSData *data = UIImagePNGRepresentation(image);
        [data writeToFile:fullPath atomically:YES];
    }
    // 讲生成的图片覆盖到当前的图层上
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, size.width, size.height);
    [self addSubview:imageView];
}

- (UIImage *)getImageWithSize:(CGSize)size color:(UIColor *)color radius:(CGFloat)radius {
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    UIBezierPath *aPath = [UIBezierPath bezierPathWithRect:CGRectMake(0,0,size.width,size.height)];
    UIBezierPath *bPath = [UIBezierPath bezierPathWithRoundedRect:aPath.bounds cornerRadius:radius];
    [aPath appendPath:[bPath bezierPathByReversingPath]];
    [color setFill];
    [aPath fill];
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (NSString *)pathWithFolder:(NSString *)folder {
    
    NSString *documentPath = [self documentPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *folderPath = [documentPath stringByAppendingPathComponent:folder];
    BOOL isExist = [fileManager fileExistsAtPath:folderPath];
    if (!isExist) {
        [fileManager createDirectoryAtPath:folderPath
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:nil];
    }
    return folderPath;
}

- (NSString *)documentPath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}

@end



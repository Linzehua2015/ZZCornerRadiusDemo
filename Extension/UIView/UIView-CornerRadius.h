//
//  UIView-CornerRadius.h
//  ExpressionKingdom
//
//  Created by 林泽华 on 17/2/24.
//  Copyright © 2017年 LinZehua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(CornerRadius)

- (void)addImageWithCornerRadius:(CGFloat)radius color:(UIColor *)color;
- (void)addImageWithCornerRadius:(CGFloat)radius color:(UIColor *)color size:(CGSize)size;

@end

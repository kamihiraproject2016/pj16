//
//  UIAppearance+Swift.m
//  Kashiawase
//
//  Created by mi-snow on 2016/11/17.
//  Copyright © 2016年 KamihiraProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIAppearance+Swift.h"

@implementation UIView (UIViewAppearance_Swift)
+ (instancetype)my_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return [self appearanceWhenContainedIn:containerClass, nil];
}
@end
//
//  UIAppearance+Swift.h
//  Kashiawase
//
//  Created by mi-snow on 2016/11/17.
//  Copyright © 2016年 KamihiraProject. All rights reserved.
//

#ifndef UIAppearance_Swift_h
#define UIAppearance_Swift_h

#import <UIKit/UIKit.h>

@interface UIView (UIViewAppearance_Swift)
// appearanceWhenContainedIn: is not available in Swift. This fixes that.
+ (instancetype)my_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass;
@end

@interface UIBarItem (UIViewAppearance_Swift)
// appearanceWhenContainedIn: is not available in Swift. This fixes that.
+ (instancetype)my_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass;
@end


#endif /* UIAppearance_Swift_h */

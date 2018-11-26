//
//  NSObject+UIAppearance_Swift.m
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/26.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

#import "NSObject+UIAppearance_Swift.h"

@implementation NSObject (UIAppearance_Swift)

+ (instancetype)my_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return [self appearanceWhenContainedIn:containerClass, nil];
}

@end

//
//  NSObject+UIAppearance_Swift.h
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/26.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (UIAppearance_Swift)<UIAppearance>

+ (instancetype)my_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass;

@end

NS_ASSUME_NONNULL_END

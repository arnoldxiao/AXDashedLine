//
//  AXDashedLine.h
//  AXDashedLine
//
//  Created by xiaochenghua on 2020/3/19.
//  Email: arnoldxiao@163.com
//  Copyright © 2020 xiaochenghua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AXDashedLineDirection) {
    /** 水平方向 */
    AXDashedLineDirectionHorizontal,
    /** 垂直方向 */
    AXDashedLineDirectionVertical
};

typedef NS_ENUM(NSUInteger, AXDashedLineStartPoint) {
    /** 起点为实段 */
    AXDashedLineStartPointSolid,
    /** 起点为空段 */
    AXDashedLineStartPointBlank
};

NS_ASSUME_NONNULL_BEGIN

/// 可定制化虚线视图
@interface AXDashedLine : UIView

/// 虚线方向，默认Horizontal
@property (nonatomic, assign) AXDashedLineDirection direction;

/// 预估单个线段长度，默认6.0，视图将进行计算，计算结果将是接近estimatedSegmentLength的一个合适的值
/// 如果direction是Horizontal，length指width，反之如果direction是Vertical，length指height
@property (nonatomic, assign) CGFloat estimatedSegmentLength;

/// 起点类型，默认Solid
@property (nonatomic, assign) AXDashedLineStartPoint startPoint;

/// 实段和空段数量是否相等，默认NO
@property (nonatomic, assign) BOOL splitSegmentsEqually;

/// 默认grayColor
@property (nonatomic, strong) UIColor *solidColor;

/// 默认whiteColor
@property (nonatomic, strong) UIColor *blankColor;

@end

NS_ASSUME_NONNULL_END

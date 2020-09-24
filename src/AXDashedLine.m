//
//  AXDashedLine.m
//  AXDashedLine
//
//  Created by xiaochenghua on 2020/3/19.
//  Email: arnoldxiao@163.com
//  Copyright © 2020 xiaochenghua. All rights reserved.
//

#import "AXDashedLine.h"

@implementation AXDashedLine

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpInitialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setUpInitialization];
    }
    return self;
}

- (void)setUpInitialization {
    _direction = AXDashedLineDirectionHorizontal;
    _estimatedSegmentLength = 6.0;
    _startPoint = AXDashedLineStartPointSolid;
    _splitSegmentsEqually = NO;
    _solidColor = [UIColor grayColor];
    _blankColor = [UIColor whiteColor];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = rect;
    shapeLayer.lineJoin = kCALineJoinRound;
    
    switch (self.startPoint) {
        case AXDashedLineStartPointSolid: {
            shapeLayer.strokeColor = self.solidColor.CGColor;
            shapeLayer.backgroundColor = self.blankColor.CGColor;
            break;
        }
        case AXDashedLineStartPointBlank: {
            shapeLayer.strokeColor = self.blankColor.CGColor;
            shapeLayer.backgroundColor = self.solidColor.CGColor;
            break;
        }
    }
    
    CGFloat dashedWidth = 0.0;
    CGFloat lineWidth = 0.0;
    
    CGPoint start = CGPointZero;
    CGPoint stop = CGPointZero;
    
    CGMutablePathRef mutablePathRef = CGPathCreateMutable();
    
    switch (self.direction) {
        case AXDashedLineDirectionHorizontal: {
            lineWidth = CGRectGetHeight(rect);
            dashedWidth = [self segmentLengthWithTotalLength:CGRectGetWidth(rect)];
            start = CGPointMake(0.0, CGRectGetHeight(rect) / 2);
            stop = CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect) / 2);
            break;
        }
        case AXDashedLineDirectionVertical: {
            lineWidth = CGRectGetWidth(rect);
            dashedWidth = [self segmentLengthWithTotalLength:CGRectGetHeight(rect)];
            start = CGPointMake(CGRectGetWidth(rect) / 2, 0.0);
            stop = CGPointMake(CGRectGetWidth(rect) / 2, CGRectGetHeight(rect));
            break;
        }
    }
    
    CGPathMoveToPoint(mutablePathRef, NULL, start.x, start.y);
    CGPathAddLineToPoint(mutablePathRef, NULL, stop.x, stop.y);
    
    shapeLayer.lineDashPattern = @[@(dashedWidth), @(dashedWidth)];
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.path = mutablePathRef;
    CGPathRelease(mutablePathRef);
    
    [self.layer addSublayer:shapeLayer];
}

- (CGFloat)segmentLengthWithTotalLength:(CGFloat)totalLength {
    CGFloat approximatelyCount = totalLength / self.estimatedSegmentLength;
    
    int count = (int)(floor(approximatelyCount));
    
    if (self.splitSegmentsEqually) {
        if (count % 2 != 0) {
            count = (int)(ceil(approximatelyCount));
        }
    } else {
        if (count % 2 == 0) {
            count = (int)(ceil(approximatelyCount));
        }
    }
    
    return totalLength / count;
}

@end

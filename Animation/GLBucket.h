//
//  GLBucket.h
//  Animation
//
//  Created by Gautam Lodhiya on 16/09/13.
//  Copyright (c) 2013 Gautam Lodhiya. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, BucketStyle) {
    BucketStyle1OpenFromRight,
    BucketStyle1OpenFromLeft,
    BucketStyle2OpenFromRight,
    BucketStyle2OpenFromLeft
};

@protocol GLBucketDelegate <NSObject>
@optional
- (void)lidOpenAnimationDidStart;
- (void)lidOpenAnimationDidFinish;
- (void)lidCloseAnimationDidStart;
- (void)lidCloseAnimationDidFinish;
@end

@interface GLBucket : NSObject

@property (nonatomic, assign, readonly) CGRect rect;
@property (nonatomic, strong, readonly) CALayer *parentLayer;
@property (nonatomic, assign, readonly) CGFloat actualHeight;
@property (nonatomic, strong) CALayer *bucketLidLayer;
@property (nonatomic, strong) CALayer *bucketBodyLayer;
@property (nonatomic, weak) id<GLBucketDelegate> bucketDelegate;

@property (nonatomic, assign) BucketStyle bucketStyle;
@property (nonatomic, copy) UIImage *bucketLidImage;
@property (nonatomic, copy) UIImage *bucketBodyImage;
@property (nonatomic, assign) CFTimeInterval animationDuration;
@property (nonatomic, strong) CAMediaTimingFunction* animationTimingFunction;
@property (nonatomic, assign) CGFloat degreesVariance;
@property (nonatomic, assign) CGFloat interspace;
@property (nonatomic, assign) CGPoint bucketLidAnchorPoint;


- (id)initWithFrame:(CGRect)rect inLayer:(CALayer *)parentLayer;
- (void)openBucket;
- (void)closeBucket;

@end

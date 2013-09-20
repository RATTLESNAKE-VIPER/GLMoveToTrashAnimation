//
//  GLBucket.m
//  Animation
//
//  Created by Gautam Lodhiya on 16/09/13.
//  Copyright (c) 2013 Gautam Lodhiya. All rights reserved.
//

#import "GLBucket.h"

static NSString *kLidOpeningKeyPath = @"transform.rotation.z";
static NSString *kLidOpenKeyName = @"open";
static NSString *kLidCloseKeyName = @"close";
static inline CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;}

@implementation GLBucket

- (id)initWithFrame:(CGRect)rect inLayer:(CALayer *)parentLayer {
    self = [super init];
    if (self) {
        _rect = rect;
        _parentLayer = parentLayer;
        [self commonInit];
    }
    return self;
}


#pragma mark - Overidden methods

- (void)setBucketStyle:(BucketStyle)bucketStyle
{
    _bucketStyle = bucketStyle;
    
    
    switch (_bucketStyle) {
        case BucketStyle1OpenFromRight:
            self.bucketLidImage = [UIImage imageNamed:@"Resource.bundle/BucketLid.png"];
            self.bucketBodyImage = [UIImage imageNamed:@"Resource.bundle/BucketBody.png"];
            self.animationDuration = 0.1;
            self.animationTimingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            self.degreesVariance = -135;
            self.interspace = -3;
            self.bucketLidAnchorPoint = CGPointMake(0.03, 1);
            break;
            
        case BucketStyle1OpenFromLeft:
            self.bucketLidImage = [UIImage imageNamed:@"Resource.bundle/BucketLid.png"];
            self.bucketBodyImage = [UIImage imageNamed:@"Resource.bundle/BucketBody.png"];
            self.animationDuration = 0.1;
            self.animationTimingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            self.degreesVariance = 135;
            self.interspace = -3;
            self.bucketLidAnchorPoint = CGPointMake(0.94, 1);
            break;
        
        case BucketStyle2OpenFromRight:
            self.bucketLidImage = [UIImage imageNamed:@"Resource.bundle/bucket_lid_style2.png"];
            self.bucketBodyImage = [UIImage imageNamed:@"Resource.bundle/bucket_body_style2.png"];
            self.animationDuration = 0.1;
            self.animationTimingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            self.degreesVariance = -60;
            self.interspace = 0;
            self.bucketLidAnchorPoint = CGPointMake(0.15, 1.56);
            break;
            
        case BucketStyle2OpenFromLeft:
            self.bucketLidImage = [UIImage imageNamed:@"Resource.bundle/bucket_lid_style2.png"];
            self.bucketBodyImage = [UIImage imageNamed:@"Resource.bundle/bucket_body_style2.png"];
            self.animationDuration = 0.1;
            self.animationTimingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            self.degreesVariance = 60;
            self.interspace = 0;
            self.bucketLidAnchorPoint = CGPointMake(0.85, 1.56);
            break;
            
        default:
            break;
    }
}

- (void)setBucketLidAnchorPoint:(CGPoint)bucketLidAnchorPoint
{
    _bucketLidAnchorPoint = bucketLidAnchorPoint;
    
    self.bucketLidLayer.anchorPoint = self.bucketLidAnchorPoint;
    self.bucketBodyLayer.anchorPoint = CGPointZero;
    
    [self setLayerFrame];
}

- (void)setLayerFrame
{
    float x = self.rect.origin.x;
	float y = self.rect.origin.y;
    CGRect frame = CGRectZero;
    
    frame = CGRectMake(x, y, self.bucketLidImage.size.width, self.bucketLidImage.size.height);
    self.bucketLidLayer.frame = frame;
	self.bucketLidLayer.bounds = frame;
    
    frame = CGRectMake(x, CGRectGetMaxY(self.bucketLidLayer.frame) + self.interspace, self.bucketBodyImage.size.width, self.bucketBodyImage.size.height);
    self.bucketBodyLayer.frame = frame;
	self.bucketBodyLayer.bounds = frame;
    
    
    // set actual height
    _actualHeight = CGRectGetHeight(self.bucketLidLayer.bounds) + CGRectGetHeight(self.bucketBodyLayer.bounds);
}

- (CALayer *)bucketLidLayer
{
    if (!_bucketLidLayer) {
        _bucketLidLayer = [CALayer layer];
    }
    return _bucketLidLayer;
}

- (CALayer *)bucketBodyLayer
{
    if (!_bucketBodyLayer) {
        _bucketBodyLayer = [CALayer layer];
    }
    return _bucketBodyLayer;
}

- (void)setBucketLidImage:(UIImage *)bucketLidImage
{
    _bucketLidImage = bucketLidImage;
    [self.bucketLidLayer setContents:(id)self.bucketLidImage.CGImage];
}

- (void)setBucketBodyImage:(UIImage *)bucketBodyImage
{
    _bucketBodyImage = bucketBodyImage;
    [self.bucketBodyLayer setContents:(id)self.bucketBodyImage.CGImage];
}

#pragma mark - Helper methods

- (void)commonInit
{
    self.bucketStyle = BucketStyle1OpenFromRight;
    
    [self.parentLayer addSublayer:self.bucketLidLayer];
    [self.parentLayer addSublayer:self.bucketBodyLayer];
}

- (void)openBucket
{
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:kLidOpeningKeyPath];
	animation.duration = self.animationDuration;
	animation.delegate = self;
	animation.removedOnCompletion = NO;
	animation.fillMode = kCAFillModeForwards;
	NSMutableArray *values = [NSMutableArray array];
	NSMutableArray *timings = [NSMutableArray array];
    [values addObject:@(DegreesToRadians(0))];
    [timings addObject:self.animationTimingFunction];
    [values addObject:@(DegreesToRadians(self.degreesVariance))];
    [timings addObject:self.animationTimingFunction];
    animation.values = values;
	animation.timingFunctions = timings;
    [self.bucketLidLayer addAnimation:animation forKey:kLidOpenKeyName];
}

- (void)closeBucket
{
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:kLidOpeningKeyPath];
	animation.duration = self.animationDuration;
	animation.delegate = self;
	animation.removedOnCompletion = NO;
	animation.fillMode = kCAFillModeForwards;
	NSMutableArray *values = [NSMutableArray array];
	NSMutableArray *timings = [NSMutableArray array];
    [values addObject:@(DegreesToRadians(self.degreesVariance))];
    [timings addObject:self.animationTimingFunction];
    [values addObject:@(DegreesToRadians(0))];
    [timings addObject:self.animationTimingFunction];
    animation.values = values;
	animation.timingFunctions = timings;
    [self.bucketLidLayer addAnimation:animation forKey:kLidCloseKeyName];
}


#pragma mark - Animation Delegate methods

- (void)animationDidStart:(CAAnimation *)anim
{
    NSString* keyPath = [((CAKeyframeAnimation *)anim) keyPath];
    
	if ([keyPath isEqualToString:kLidOpenKeyName]) {
		if (self.bucketDelegate && ![self.bucketDelegate isKindOfClass:[NSNull class]]) {
            if ([self.bucketDelegate respondsToSelector:@selector(lidOpenAnimationDidStart)]) {
                [self.bucketDelegate lidOpenAnimationDidStart];
            }
        }
        
	} else if ([keyPath isEqualToString:kLidCloseKeyName]) {
		if (self.bucketDelegate && ![self.bucketDelegate isKindOfClass:[NSNull class]]) {
            if ([self.bucketDelegate respondsToSelector:@selector(lidCloseAnimationDidStart)]) {
                [self.bucketDelegate lidCloseAnimationDidStart];
            }
        }
	}
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
	NSString* keyPath = [((CAKeyframeAnimation *)anim) keyPath];
    
	if ([keyPath isEqualToString:kLidOpenKeyName]) {
		if (self.bucketDelegate && ![self.bucketDelegate isKindOfClass:[NSNull class]]) {
            if ([self.bucketDelegate respondsToSelector:@selector(lidOpenAnimationDidFinish)]) {
                [self.bucketDelegate lidOpenAnimationDidFinish];
            }
        }
        
	} else if ([keyPath isEqualToString:kLidCloseKeyName]) {
		if (self.bucketDelegate && ![self.bucketDelegate isKindOfClass:[NSNull class]]) {
            if ([self.bucketDelegate respondsToSelector:@selector(lidCloseAnimationDidFinish)]) {
                [self.bucketDelegate lidCloseAnimationDidFinish];
            }
        }
	}
}

@end

//
//  GLViewController.m
//  Animation
//
//  Created by Gautam Lodhiya on 13/09/13.
//  Copyright (c) 2013 Gautam Lodhiya. All rights reserved.
//

#import "GLBucketCustomizationDemoVC.h"
#import "GLBucket.h"

@interface GLBucketCustomizationDemoVC () {
    BOOL shouldOpen;
}
@property (nonatomic, strong) GLBucket *leftBucket;
@property (nonatomic, strong) GLBucket *rightBucket;
@property (nonatomic, strong) GLBucket *centerBucket;

@end

@implementation GLBucketCustomizationDemoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.leftBucket = [[GLBucket alloc] initWithFrame:CGRectMake(20, CGRectGetHeight(self.view.bounds) - 100, 30, 30) inLayer:self.view.layer];
    
    self.rightBucket = [[GLBucket alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds) - 40, CGRectGetHeight(self.view.bounds) - 100, 30, 30) inLayer:self.view.layer];
    self.rightBucket.bucketStyle = BucketStyle1OpenFromLeft;
    
    self.centerBucket = [[GLBucket alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.bounds) - 20) / 2, CGRectGetHeight(self.view.bounds) - 105, 30, 30) inLayer:self.view.layer];
    self.centerBucket.bucketStyle = BucketStyle2OpenFromRight;
    
    shouldOpen = YES;
    [self.playpausebutton setTitle:@"open" forState:UIControlStateNormal];
}

- (IBAction)playAnimation:(id)sender {
    if (shouldOpen) {
        shouldOpen = NO;
        [self.playpausebutton setTitle:@"close" forState:UIControlStateNormal];
        [self.leftBucket openBucket];
        [self.rightBucket openBucket];
        [self.centerBucket openBucket];

    } else {
        shouldOpen = YES;
        [self.playpausebutton setTitle:@"open" forState:UIControlStateNormal];
        [self.leftBucket closeBucket];
        [self.rightBucket closeBucket];
        [self.centerBucket closeBucket];
    }
    
//    UIView *sourceView = self.myview;
//    UIView *targetView = sender;
//    [self suckEffect:sourceView toTarget:targetView];
}



- (void)suckEffect:(UIView *)sourceView toTarget:(UIView *)targetView
{
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:sourceView.center];
    [movePath addQuadCurveToPoint:targetView.center
                     controlPoint:CGPointMake(targetView.center.x, sourceView.center.y)];
    
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    moveAnim.removedOnCompletion = YES;
    
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
    scaleAnim.removedOnCompletion = YES;
    
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
    opacityAnim.removedOnCompletion = YES;
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:moveAnim, scaleAnim, opacityAnim, nil];
    animGroup.duration = 0.5;
    [sourceView.layer addAnimation:animGroup forKey:nil];
}

@end

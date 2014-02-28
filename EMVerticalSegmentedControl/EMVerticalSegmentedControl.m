//
//  EMVerticalSegmentedControl.m
//  Demo
//
//  Created by Elliott Minns on 27/02/2014.
//  Copyright (c) 2014 Elliott Minns. All rights reserved.
//

#import "EMVerticalSegmentedControl.h"

@interface EMVerticalSegmentedControl()
@property (nonatomic, assign) NSInteger visibleSelectedSegmentIndex;

@property (nonatomic, strong) CALayer *selectedLayer;
@end

@implementation EMVerticalSegmentedControl

- (id)init {
    self = [super init];
    
    if (self) {
        [self initialise];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self initialise];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initialise];
    }
    return self;
}

- (void)initialise {
    self.selectedLayer = [CALayer layer];
    [self.layer addSublayer:self.selectedLayer];
    self.backgroundColor = [UIColor colorWithRed:233.0f/255.0f green:237.0f/255.0f blue:242.0f/255.0f alpha:1.0];
    self.titleFont = [UIFont fontWithName:@"Avenir Book" size:13.5];
    self.textColor = [UIColor colorWithRed:155.0f/255.0f green:173.0f/255.0f blue:176.0f/255.0 alpha:1.0];
    self.selectedTextColor = [UIColor whiteColor];
    self.textAlignment = NSTextAlignmentCenter;
    self.selectedSegmentColor = [UIColor colorWithRed:21.0/255.0 green:163.0/255.0 blue:174.0/255.0 alpha:1.0];
    self.cornerRadius = 4.0;
    self.layer.masksToBounds = YES;
    self.selectedLayer.backgroundColor = self.selectedSegmentColor.CGColor;
}

- (void)drawRect:(CGRect)rect {
    [self.backgroundColor setFill];
    UIRectFill(rect);
    
    // Work out the height of each section.
    CGFloat segmentHeight = rect.size.height / self.sectionTitles.count;

    
    for (NSInteger i = self.layer.sublayers.count - 1; i >= 0; i--) {
        CALayer *sublayer = self.layer.sublayers[i];
        if (sublayer != self.selectedLayer) {
            [sublayer removeFromSuperlayer];
        }
    }
    
    [self.sectionTitles enumerateObjectsUsingBlock:^(id title, NSUInteger idx, BOOL *stop) {
        CGFloat y = segmentHeight * idx;
        CGFloat textHeight = [self getTextSize:title].height;
        
        CGRect segmentRect = CGRectMake(0, y, rect.size.width, segmentHeight);
        
        if (self.visibleSelectedSegmentIndex == idx) {
            self.selectedLayer.frame = segmentRect;
        }
        
        CGRect titleRect = CGRectMake(0, y + segmentHeight / 2 - textHeight / 2, rect.size.width, textHeight);
        
        CATextLayer *titleLayer = [CATextLayer layer];
        // Note: text inside the CATextLayer will appear blurry unless the rect values around rounded
        titleLayer.frame = titleRect;
        [titleLayer setFont:(__bridge CFTypeRef)(self.titleFont.fontName)];
        [titleLayer setFontSize:self.titleFont.pointSize];
        
        switch(self.textAlignment) {
            case NSTextAlignmentLeft:
                [titleLayer setAlignmentMode:kCAAlignmentLeft];
                break;
            case NSTextAlignmentCenter:
                [titleLayer setAlignmentMode:kCAAlignmentCenter];
                break;
            case NSTextAlignmentRight:
                [titleLayer setAlignmentMode:kCAAlignmentRight];
                break;
            default:
                [titleLayer setAlignmentMode:kCAAlignmentCenter];
                break;
        }
        
        [titleLayer setString:title];
        if (self.visibleSelectedSegmentIndex == idx) {
            [titleLayer setForegroundColor:self.selectedTextColor.CGColor];
        } else {
            [titleLayer setForegroundColor:self.textColor.CGColor];
        }
        
        [titleLayer setContentsScale:[[UIScreen mainScreen] scale]];
        [self.layer addSublayer:titleLayer];
        
    }];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    
    if (CGRectContainsPoint(self.bounds, touchLocation)) {
        NSInteger segment = touchLocation.y / (CGFloat)(self.bounds.size.height / self.sectionTitles.count);
        
        if (segment != self.selectedSegmentIndex) {
            [self setSelectedSegmentIndex:segment animated:YES notify:YES];
        }
    }
}

- (void)setSelectedSegmentIndex:(NSInteger)index {
    [self setSelectedSegmentIndex:index animated:NO notify:NO];
}

- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated {
    [self setSelectedSegmentIndex:index animated:animated notify:NO];
}

- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated notify:(BOOL)notify {
    _selectedSegmentIndex = index;
    self.visibleSelectedSegmentIndex = index;
    
    if (notify) {
        [self notifyForSegmentChangeToIndex:index];
    }
    if (animated) {
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self setNeedsDisplay];
        } completion:nil];
    } else {
        [self setNeedsDisplay];
    }
}

#pragma mark - Setters

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}

- (void)setSelectedSegmentColor:(UIColor *)selectedSegmentColor {
    _selectedSegmentColor = selectedSegmentColor;
    self.selectedLayer.backgroundColor = selectedSegmentColor.CGColor;
}

- (void)setSectionTitles:(NSArray *)sectionTitles {
    _sectionTitles = sectionTitles;
    if (self.superview) {
        [self setNeedsDisplay];
    }
}

#pragma mark - Getters

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

#pragma mark - Notifiers

- (void)notifyForSegmentChangeToIndex:(NSInteger)index {
    if (self.superview) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    
    if (self.indexChangeBlock) {
        self.indexChangeBlock(index);
    }
}


#pragma mark - Text Utilities

- (CGSize)getTextSize:(NSString *)text {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    NSDictionary *attributes = @{NSFontAttributeName: self.titleFont,
                                 NSParagraphStyleAttributeName: paragraphStyle};
    return [text sizeWithAttributes:attributes];
}

@end

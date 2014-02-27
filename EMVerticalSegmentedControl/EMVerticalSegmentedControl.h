//
//  EMVerticalSegmentedControl.h
//  Demo
//
//  Created by Elliott Minns on 27/02/2014.
//  Copyright (c) 2014 Elliott Minns. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^IndexChangeBlock)(NSInteger index);

@interface EMVerticalSegmentedControl : UIControl

- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated;

@property (nonatomic, strong) NSArray *sectionTitles;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *selectedTextColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *selectedSegmentColor;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) NSInteger selectedSegmentIndex;
@property (nonatomic, copy) void (^indexChangeBlock)(NSInteger index) ;

@end

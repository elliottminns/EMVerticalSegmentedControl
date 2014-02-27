EMVerticalSegmentedControl
==========

A Vertical Segmented Control View for iOS

## Requirements
* Xcode 5 or higher
* Apple LLVM compiler
* iOS 7.0 or higher
* ARC

## Installation

### Cocoapods

To install via Cocoapods, add the following line to your Podfile.

``
pod 'EMVerticalSegmentedControl'
``

### Manual Installation

All you need to do is drop 'EMVerticalSegmentedControl' files into your project.

## Example Usage

Using Interface Builder, just set a designated views class to be of EMVerticalSegmentedControl or manually create with code like so:

```objective-c
    EMVerticalSegmentedControl *control = [[EMVerticalSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 150, 140)];
        control.sectionTitles = @[@"On", @"Off", @"Maybe", @"Could you repeat?"];
    [self.view addSubview:control];
    control.center = CGPointMake(320 / 2, 568 / 2);
```

Make sure you set the sectionTitles otherwise you will have a blank segment :)

To listen for segment changes you have two options. The first is the implement the classic Add Target method:

```objective-c
- (void)viewDidLoad {
    ...
    [control addTarget:self action:@selector(segmentDidChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)segmentDidChange:(id)sender {
    NSInteger index = ((EMVerticalSegmentedControl *)sender).selectedSegmentIndex;
    NSLog(@"Value changed selector: %lu", index);
}
```

You can also add a block object for a callback.

```objective-c
- (void)viewDidLoad {
    [control setIndexChangeBlock:^(NSInteger index) {
        NSLog(@"Value changed in block: %lu", index);
    }];
}
```

These are not mutually exclusive, and you can use both if you desire.

## Properties

* NSArray *sectionTitles - An Array of NSString that will display as the title for it's corresponding section index.

* NSTextAlignment textAlignment - Used to set the alignment of the title text.

* UIFont *titleFont - The font used to draw the titles.

* UIColor *selectedTextColor - The title color of the selected segment.

* UIColor *textColor - The title color for the unselected segments.

* UIColor *selectedSegmentColor - The background color of the selected segment.

* UIColor *backgroundColor - The background color for the unselected segments.

* CGFloat cornerRadius - The corner radius of the entire view.

* NSInteger selectedSegmentIndex - The currently selected segement.

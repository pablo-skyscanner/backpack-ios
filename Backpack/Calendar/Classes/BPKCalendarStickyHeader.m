/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2020 Skyscanner Ltd
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "BPKCalendarStickyHeader.h"

#import <Backpack/Font.h>
#import <Backpack/Spacing.h>

#import "BPKCalendarAppearance.h"

@interface FSCalendarStickyHeader (Private)

@property(weak, nonatomic) UIView *contentView;
@property(weak, nonatomic) UIView *bottomBorder;
@property(weak, nonatomic) FSCalendarWeekdayView *weekdayView;

@end

@implementation BPKCalendarStickyHeader

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        [self.weekdayView removeFromSuperview];
        [self.bottomBorder removeFromSuperview];
    }

    return self;
}

- (void)configureAppearance {
    [super configureAppearance];
    self.titleLabel.textAlignment = NSTextAlignmentNatural;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), CGRectGetHeight(self.contentView.bounds));
}

- (void)setMonth:(NSDate *)month {
    [super setMonth:month];
    FSCalendarAppearance *appearance = self.calendar.appearance;
    NSAssert([appearance isKindOfClass:[BPKCalendarAppearance class]], @"Return value is not of type BPKCalendarAppearance as expected.");
    BPKFontStyle fontStyle = ((BPKCalendarAppearance *)appearance).headerTitleFontStyle;
    NSAttributedString *monthText = [BPKFont attributedStringWithFontStyle:fontStyle
                                                                   content:self.titleLabel.text
                                                                 textColor:appearance.headerTitleColor];
    self.titleLabel.attributedText = monthText;
}

@end

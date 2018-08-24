/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
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
#import "BPKLabel.h"
#import <Backpack/Color.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKLabel()
- (void)setupWithStyle:(BPKFontStyle)style;
@end

@implementation BPKLabel

- (instancetype)initWithFontStyle:(BPKFontStyle)style {
    self = [super initWithFrame:CGRectZero];

    if (self) {
        [self setupWithStyle:style];
    }

    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setupWithStyle:BPKFontStyleTextBase];
    }

    return self;
}

- (void)setFontStyle:(BPKFontStyle)fontStyle {
    _fontStyle = fontStyle;
    UIFont *font = [BPKFont fontWithStyle:fontStyle];
    NSAssert(font != nil, @"Invalid font style supplied to BPKLabel");

    if (font == nil) {
        font = [BPKFont textBase];
    }

    self.font = font;
}

#pragma mark - Private

- (void)setupWithStyle:(BPKFontStyle)style {
    self.fontStyle = style;
    self.textColor = [BPKColor gray700];
}

@end
NS_ASSUME_NONNULL_END

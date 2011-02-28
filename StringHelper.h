//
//  StringHelper.h
//  PTLog
//
//  Created by Ellen Miner on 1/2/09.
//  Copyright 2009 RaddOnline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (StringHelper)
- (CGFloat)textHeightForSystemFontOfSize:(CGFloat)size withLabelWidth:(CGFloat)width;
- (CGRect)RAD_frameForCellLabelWithSystemFontOfSize:(CGFloat)size;
- (UILabel *)RAD_newSizedCellLabelWithSystemFontOfSize:(CGFloat)size;
- (void)RAD_resizeLabel:(UILabel *)aLabel WithSystemFontOfSize:(CGFloat)size;
@end


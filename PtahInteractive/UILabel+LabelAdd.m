//
//  UILabel+LabelAdd.m
//  PtahInteractive
//
//  Created by ptah on 16/8/8.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import "UILabel+LabelAdd.h"

@implementation UILabel (LabelAdd)

-(void)setfram:(CGRect)rect text:(NSString *)text  color:(UIColor *)color font:(Size)sizeFont {
    self.frame = rect;
    
    self.text = text;
    
    self.textColor = color;
    
    self.font = [UIFont systemFontOfSize:sizeFont];

}
@end

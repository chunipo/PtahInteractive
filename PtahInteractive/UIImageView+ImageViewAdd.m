//
//  UIImageView+ImageViewAdd.m
//  PtahInteractive
//
//  Created by ptah on 16/8/8.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import "UIImageView+ImageViewAdd.h"

@implementation UIImageView (ImageViewAdd)

-(void)setfram:(CGRect)rect image:(NSString *)image useinterface:(BOOL)isOpen{
    self.frame = rect;
    
    self.image = [UIImage imageNamed:image];
    
    self.userInteractionEnabled = isOpen;

}

@end

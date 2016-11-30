//
//  BaoScroView.m
//  PtahInteractive
//
//  Created by ptah on 16/8/4.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import "BaoScroView.h"

@implementation BaoScroView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setfram:(CGRect)rect color:(UIColor*)color contentSize:(CGSize)cgsize pagingEnabled:(bool)A other:(bool)B{
    self.backgroundColor = color;
   // self.scroView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, LFScreenW, headH/3)];
    self.frame = rect;
    self.contentSize = cgsize;
    
    self.pagingEnabled = A;
    
    //_scrollView.userInteractionEnabled = YES;
    
    //_topScro.contentOffset = CGPointMake(0, 0);
    
    self.alwaysBounceHorizontal = B;
    
    self.alwaysBounceVertical = B;
    
    self.showsVerticalScrollIndicator = B;
    
    self.showsHorizontalScrollIndicator = B;
    
   // self.delegate = self;
   //_topScro.backgroundColor = [UIColor redColor];
   // [self.view addSubview:_topScro];
    


}


@end

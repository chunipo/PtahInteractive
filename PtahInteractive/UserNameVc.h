//
//  UserNameVc.h
//  PtahInteractive
//
//  Created by ptah on 16/8/18.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserNameDelegate <NSObject>

- (void)ChangeUserName:(NSString *)useName;
@end


@interface UserNameVc : UIViewController

@property(nonatomic,strong)NSString *userName;

@property (nonatomic, weak) id<UserNameDelegate> delegate;

@end

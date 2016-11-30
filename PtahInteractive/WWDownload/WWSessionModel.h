//
//  WWSessionModel.h
//  WWDownload
//
//  Created by lilei on 16/7/7.
//  Copyright © 2016年 lilei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKDBHelper.h"

@interface WWSessionModel : NSObject

typedef NS_ENUM(NSInteger, DownloadState){
    DownloadStateStart = 0,     /** 下载中 */
    DownloadStateSuspended,     /** 下载暂停 */
    DownloadStateLoading,       /** 等待中*/
    DownloadStateCompleted,     /** 下载完成 */
    DownloadStateFailed         /** 下载失败 */
};

typedef void(^DownloadProgressBlock)(CGFloat progress, NSString *speed, NSString *remainingTime, NSString *writtenSize, NSString *totalSize);

typedef void(^DownloadStateBlock)(DownloadState state);

/** 流 */
@property (nonatomic, strong) NSOutputStream *stream;

/** 下载地址 */
@property (nonatomic, copy) NSString *url;
/** 开始下载时间 */
@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSString *startTimeStr;
/** 文件名 */
@property (nonatomic, copy) NSString *fileName;
/** 总文件大小 */
@property (nonatomic, copy) NSString *totalSize;
/** 获得服务器这次请求 返回数据的总长度 */
@property (nonatomic, assign) NSInteger totalLength;

//** 已接受的文件长度*/
@property (nonatomic, assign) NSInteger receivedLength;
//** 已接受的文件大小*/
@property (nonatomic,copy) NSString *receivedSize;
/** 标题*/
@property (nonatomic,copy) NSString *title;

//
@property(nonatomic,copy)NSString *displayName;//显示名称

@property(nonatomic,strong)NSString *type;//类型

@property(nonatomic,copy)NSString *filePath;//类型

/**图片data*/
@property (nonatomic,strong) NSData *imageData;



/** 下载进度 */
@property (atomic, copy) DownloadProgressBlock progressBlock;

/** 下载状态 */
@property (atomic, copy) DownloadStateBlock stateBlock;

@property(nonatomic,assign) DownloadState downloadState;

- (float)calculateFileSizeInUnit:(unsigned long long)contentLength;

- (NSString *)calculateUnit:(unsigned long long)contentLength;



@end

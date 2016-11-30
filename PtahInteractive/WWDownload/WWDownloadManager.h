//
//  WWDownloadManager.h
//  WWDownload
//
//  Created by lilei on 16/7/7.
//  Copyright © 2016年 lilei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WWSessionModel.h"

// 缓存主目录
#define WWCachesDirectory [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]stringByAppendingPathComponent:@"WWCache"]

// 保存文件名
#define WWFileName(url)  [[url componentsSeparatedByString:@"/"] lastObject]

// 文件的存放路径（caches）
#define WWFileFullpath(url) [WWCachesDirectory stringByAppendingPathComponent:WWFileName(url)]

// 文件的已下载长度
#define WWDownloadLength(url) [[[NSFileManager defaultManager] attributesOfItemAtPath:WWFileFullpath(url) error:nil][NSFileSize] integerValue]

//最多下载数
#define  MaxDownloadCount 1

@protocol WWDownloadDelegate <NSObject>
/** 下载中的回调 */
- (void)downloadResponse:(WWSessionModel *)sessionModel;

@end

@interface WWDownloadManager : NSObject


/** 保存所有下载相关信息字典 */
@property (nonatomic, strong, readonly) NSMutableDictionary *sessionModels;
/** 所有本地存储的所有下载信息数据数组 */
@property (nonatomic, strong, readonly) NSMutableArray *sessionModelsArray;
/** 下载完成的模型数组*/
@property (nonatomic, strong, readonly) NSMutableArray *downloadedArray;
/** 下载中的模型数组*/
@property (nonatomic, strong, readonly) NSMutableArray *downloadArray;

@property (nonatomic, strong, readonly) NSMutableArray *downloadingArray;
/** ZFDownloadDelegate */
@property (nonatomic, weak) id<WWDownloadDelegate> delegate;





/**
 *  单例
 *
 *  @return 返回单例对象
 */
+ (instancetype)sharedInstance;

/**
 *  开启任务下载资源(下载，暂停，恢复下载)
 *
 *  @param dic           下载需要保持的数据    
 *   首次下载需传入参数
 *   dic = @{@"image":image,
             @"ResourceUrl":resourceUrl,
             @"Title":title
            };
 *
    恢复下载和暂停只需传入
     dic = @{ @"ResourceUrl":resourceUrl};

 *  @param progressBlock 回调下载进度
 *  @param stateBlock    下载状态
 */
- (void)download:(NSDictionary *)dic progress:(DownloadProgressBlock)progressBlock state:(DownloadStateBlock)stateBlock;


/**
 *  判断资源是否已在资源列表
 *
 *  @param url 资源地址
 *
 *  @return Yes已存在 No不存在
 */
- (BOOL)isExistDownloadList:(NSString *)url;


/**
 *  删除该资源
 *
 *  @param url 下载地址
 */
- (void)deleteFile:(NSString *)url;

/**
 *  删除多个资源
 *
 *  @param urlArray 下载地址数组
 */
- (void)deleteFileWithUrlArray:(NSArray *)urlArray;


/**
 *  模糊查找下载的资源 (包含 正在下载，已下载，等待下载，暂停，下载错误)
 *
 *  @param title 资源的标题
 *
 *  @return 搜索的资源数组
 */
- (NSMutableArray *)searchResouceWithTitle:(NSString *)title;


@end

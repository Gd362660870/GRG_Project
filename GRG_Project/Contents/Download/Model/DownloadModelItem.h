//
//  DownloadModelItem.h
//  GRG_Project
//
//  Created by 陈家劲 on 16/10/27.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DownloadModelItem,model;
@protocol DownloadModelItemDelegate <NSObject>
@required
/**
 *  下载结束
 */
-(void)downloadEnd:(DownloadModelItem *)item;

@optional
/**
 *  下载开始
 */
-(void)downloadStart:(DownloadModelItem *)item;

/**
 *  下载暂停
 */
-(void)downloadPause:(DownloadModelItem *)item;

/**
 *  下载进度
 *
 *  @param progress
 */
-(void)downloadProgress:(DownloadModelItem *)item;

@end

/**
 *  文件状态类型
 */
typedef NS_ENUM(NSInteger,FileStatusType) {
    /**
     *  开始状态
     */
    FileStatusTypeStart = 0,
    /**
     *  停止状态
     */
    FileStatusTypeStop,
};

/**
 *  未下载完 与 新下载（旧值&新值）
 */
typedef NS_ENUM(NSInteger,FileNewOrOld) {
    /**
     *  旧值
     */
    FileTypeEndOld = 0,
    /**
     *  新值
     */
    FileTypeEndNew,
};


/**
 *  下载状态
 */
typedef NS_ENUM(NSInteger,DownloadStatus) {
    /**
     *  取消下载
     */
    DownloadStatusCancel,
    /**
     *  暂停下载
     */
    DownloadStatusePause,
    /**
     *  开始下载
     */
    DownloadStatusStart,
};


@interface DownloadModelItem : NSObject

@property (nonatomic,weak)id<DownloadModelItemDelegate> delegate; //代理
@property (nonatomic,strong)model *modelItem;

@property (nonatomic,strong)RACSubject *subjectDownloadStatus; //下载状态信号


/**
 *  初始化 点击连接 立即下载
 *
 *  @param url url
 *
 *  @return 实例ns
 */
-(instancetype)initWithStartDownload:(NSString *)url;

/**
 *  点击连接 立即下载
 *
 *  @param url url
 */
-(void)startDownload:(NSString *)url;



@end

@interface model : NSObject

@property (nonatomic,strong)NSString *fileURL; //下载URL
@property (nonatomic,strong)NSString *fileName; //文件名字
@property (nonatomic,strong)NSString *fileExtension;//文件后缀名
@property (nonatomic,assign)FileType fileType;//文件类型
@property (nonatomic,assign)FileStatusType modelType; //模型状态
@property (nonatomic,assign)FileNewOrOld fileNewOrOld;//文件新或旧值
@property (nonatomic,assign)CGFloat file_Size; //文件大小
@property (nonatomic,strong)NSString *fileSaveListPaht;//文件保存目录
@property (nonatomic,strong)NSString *fileSavePath; //文件保存路径
@property (nonatomic,strong)NSString *fileTypeImageStr;//文件图片
@property (nonatomic,assign)CGFloat progress; //进度
@property (nonatomic,assign)CGFloat downloadSpeed; //下载速度
@property(nonatomic, strong) NSString *dataPath;   //数据保存路径

@end

//
//  ScannerViewModel.h
//  GRG_Project
//
//  Created by 陈家劲 on 16/10/10.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScannerModel.h"
#import "AppDelegate.h"
#import "SuperNavigationController.h"
#import <AVFoundation/AVFoundation.h>


typedef NS_ENUM(NSInteger,ScannerViewModelType){
    ScannerViewModelTypeStop = 0,//暂停
    ScannerViewModelTypeStart,//开始
};

@interface ScannerViewModel : NSObject



@property (nonatomic,strong)ScannerModel *model;
@property (nonatomic,strong)NSString *name;

/**
 *  所有按钮的触发事件
 */
@property (nonatomic,strong)RACSubject *btnSubject;

/**
 *  所有事件信号
 */
@property (nonatomic,strong)RACSubject *eventSubject;

@property (nonatomic,strong) AppDelegate *appDelegate;


//输入输出的中间桥梁
@property (nonatomic,strong)AVCaptureSession *session;
//
@property (nonatomic,strong)AVCaptureDevice *device;
//
@property (nonatomic,strong)AVCaptureDeviceInput *input;
//
@property (nonatomic,strong)AVCaptureMetadataOutput *output;
//
@property (nonatomic,strong)AVCaptureVideoPreviewLayer *preview;

//扫描结果
@property (nonatomic,strong)NSString *scannedResult;

-(instancetype)initWithController:(id)controller;
@end

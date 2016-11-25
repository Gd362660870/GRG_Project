//
//  DownloadTableViewCell.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/10/26.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "DownloadTableViewCell.h"
#import "DownloadModelItem.h"
#import "LocalFileModelItem.h"
#import "UIButton+Type.h"

@interface DownloadTableViewCell()
/**
 *  图片类型
 */
@property (strong, nonatomic) IBOutlet UIImageView *typeImage;
/**
 *  标题名
 */
@property (strong, nonatomic) IBOutlet UILabel *lableTitle;
/**
 *  文件大小
 */
@property (strong, nonatomic) IBOutlet UILabel *lableSize;
/**
 *  进度动画
 */
@property (strong, nonatomic) IBOutlet UIView *progressView;

@property (strong, nonatomic) IBOutlet UILabel *dateLabel;




/**
 *  下载状态
 */
-(void)downloadStatus;

/**
 *  停止状态
 */
-(void)stopStatus;

@end
@implementation DownloadTableViewCell

- (void)awakeFromNib {
    [self addSubview:self.btnFace];
}


-(void)updateDataItem:(id)item
{

    
    if ([item isKindOfClass:[DownloadModelItem class]]) {
        
        //*************************下载部分**************************
        self.downloadModel = (DownloadModelItem *)item;
#warning typeImage
        
        
        [RACObserve(self.downloadModel, modelItem.modelType)subscribeNext:^(id x) {
            FileStatusType type = [x integerValue];

            type == FileStatusTypeStart ? [self downloadStatus] : [self stopStatus];
            
        }];
        
        [self.typeImage setImage:[UIImage imageNamed:@"90Y58PICUtb_1024"]];
        
        @weakify(self)
        [self.lableTitle setText:self.downloadModel.modelItem.fileName];
        NSLog(@"%d",[NSThread isMainThread]);
        
        
        [[[RACObserve(self.downloadModel, modelItem.downloadSpeed)map:^id(NSNumber *value) {
            CGFloat num = [value floatValue];
            NSString *str = [NSString stringWithFormat:@"%.2fMB",num];
            return str;
        }]deliverOnMainThread]subscribeNext:^(id x) {
            @strongify(self)
            [self.lableSize setText:x];
        }];

        [self.dateLabel setHidden:YES];
 

        
    }else if([item isKindOfClass:[LocalFileModelItem class]])
    {
        //*************************本地存储部分**************************
        LocalFileModelItem *localFileModel = (LocalFileModelItem *)item;
#warning typeImage
        [self.typeImage setImage:[UIImage imageNamed:@"90Y58PICUtb_1024"]];
        [self.lableTitle setText:localFileModel.fileName];
        [self.lableSize setText:[NSString stringWithFormat:@"%.2fMB",localFileModel
                                 .file_Size]];
        [self.progressView setHidden:YES];
        [self.dateLabel setHidden:NO];  
        [self.dateLabel setText:localFileModel.fileDate];
        self.filePath_URL = localFileModel.filePath_URL;
        self.fileName = localFileModel.fileName;
        //设置按钮
        [self.btnFace setHidden:NO];
        [self.btnFace setTitle:@"打开" forState:UIControlStateNormal];
        [self.btnFace setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
    }

}


#pragma mark - 下载状态
-(void)downloadStatus
{
    NSLog(@"下载状态");
    [self.btnFace setHidden:YES];
    [self.progressView setHidden:NO];
    
}


#pragma mark - 停止状态
-(void)stopStatus
{
    [self.progressView setHidden:YES];
    [self.btnFace setHidden:NO];
    [self.btnFace setTitle:@"继续" forState:UIControlStateNormal];
    [self.btnFace setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    
    NSLog(@"停止状态");
}

-(void)isMian
{
    
    if ([NSThread isMainThread]) {
        NSLog(@"是主线程");
    }else
    {
        NSLog(@"不是主线程");
    }
}

#pragma mark- 懒加载

-(UIButton *)btnFace
{
    if (!_btnFace) {
        _btnFace = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置按钮
        [_btnFace setFrame:self.progressView.frame];

    }
    return _btnFace;
}


-(RACSubject *)subjectButton
{
    if (!_subjectButton) {
        _subjectButton = [RACSubject subject];
    }
    return _subjectButton;
}


@end

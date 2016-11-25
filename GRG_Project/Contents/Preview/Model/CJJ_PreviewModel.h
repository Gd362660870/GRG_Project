//
//  CJJ_PreviewModel.h
//  GRG_Project
//
//  Created by 陈家劲 on 16/11/15.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuickLook/QuickLook.h>
@interface CJJ_PreviewModel : NSObject<QLPreviewItem>


@property(strong, nonatomic) NSURL * previewItemURL;
@property(strong, nonatomic) NSString * previewItemTitle;
@end

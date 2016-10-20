//
//  ScannerViewController.m
//  GRG_Project
//
//  Created by 陈家劲 on 16/10/10.
//  Copyright © 2016年 陈家劲. All rights reserved.
//

#import "ScannerViewController.h"
#import "UIImageView+Scanner.h"


@interface ScannerViewController ()

@property (nonatomic,strong)RACSubject *subject;


@end

@implementation ScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加视图
    [self addViews];
    
    //适配
    [self defineLayout];
    
    //设置动画
    [self setAnimation];
    
    //关联
    [self bindWithViewModel];
}
#pragma mark- 添加视图
-(void)addViews
{
    //设置视图背景颜色
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //扫描框
    [self.view addSubview:self.imageView];
    //扫描线
    [self.imageView addSubview:self.line];
    //设置首页-闪光灯-相册 （按钮）
    [self setImageViews];
    
}
#pragma mark- 设置首页-闪光灯-相册 （按钮）
-(void)setImageViews
{
    @weakify(self)
    for (int i = 0; i < self.viewModel.model.imageArray.count; i++) {
        
        CGFloat w = 25;
        CGFloat h = 25;
        CGFloat x = SCREEN_WIDTH -((w + 15) * i);
        CGFloat y = 30;
        if (i == 0) {
            x = 15;
        }
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
        [imageView setImage:[UIImage imageNamed:self.viewModel.model.imageArray[i]]];
        imageView.title = self.viewModel.model.imageNameArray[i];
        switch (i) {
            case 0:
                imageView.type = UIImageViewScannerTypeReturn;
                break;
                
            case 1:
                imageView.type = UIImageViewScannerTypeSpark;
                break;
                
            case 2:
                imageView.type = UIImageViewScannerTypePrint;
                break;
                
            default:
                break;
        }
        [self.view addSubview:imageView];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] init];
        [imageView setUserInteractionEnabled:YES];
        [imageView addGestureRecognizer:tap];
        
        
        [[tap rac_gestureSignal]subscribeNext:^(UITapGestureRecognizer *x) {
            @strongify(self)
            UIImageView *imageView = (UIImageView *)x.view;
            [self.viewModel.btnSubject sendNext:imageView];
        }];
    
        
    }
    
}

#pragma mark- 设置动画
-(void)setAnimation
{
    [CJJ_Tools sharedTools];
    
    
    [self.line pop_addAnimation:[CJJ_Tools sharedTools].animation.popBasiLine forKey:@"line_kPOPLayerPositionY"];
    
    [self.line.layer pop_addAnimation:[CJJ_Tools sharedTools].animation.popSpringLine forKey:@"line_kPOPLayerScaleXY"];
}

#pragma mark- 适配
-(void)defineLayout
{
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.sizeOffset(CGSizeMake(SCANNER_FRAME_WIDTH, SCANNER_FRAME_WIDTH));
        make.center.mas_equalTo(self.view);
    }];
    
    
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(self.imageView);
        make.left.mas_equalTo(self.imageView);
        make.right.mas_equalTo(self.imageView);
        
    }];
}

- (CGRect)rectOfInterestByScanViewRect:(CGRect)rect {
    
    CGFloat x = (SCREEN_HEIGHT - CGRectGetHeight(rect)) / 2 / SCREEN_WIDTH;
    CGFloat y = (SCREEN_WIDTH - CGRectGetWidth(rect)) / 2 / SCREEN_WIDTH;
    
    CGFloat w = CGRectGetHeight(rect) / SCREEN_HEIGHT;
    CGFloat h = CGRectGetWidth(rect) / SCREEN_WIDTH;
    
    return CGRectMake(x, y, w, h);
}
#pragma mark- 关联
-(void)bindWithViewModel
{
    
}



#pragma mark - 控制器生命周期
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
//    [self.viewModel.eventSubject sendNext:@(ScannerViewModelTypeStart)];
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
//    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)dealloc
{
    NSLog(@"%s",__func__);
}

#pragma mark- 懒加载
-(ScannerViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[ScannerViewModel alloc]initWithController:self];
        
    }
    return _viewModel;
}

-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        [_imageView setImage:[UIImage imageNamed:@"scanscanBg"]];
    }
    return _imageView;
}

-(UIImageView *)line
{
    if (!_line) {
        _line = [[UIImageView alloc]initWithFrame:CGRectZero];
        [_line setImage:[UIImage imageNamed:@"scanLine"]];
    }
    return _line;
}






@end

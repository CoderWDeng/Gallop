/********************* 有任何问题欢迎反馈给我 liuweiself@126.com ****************************************/
/***************  https://github.com/waynezxcv/Gallop 持续更新 ***************************/
/******************** 正在不断完善中，谢谢~  Enjoy ******************************************************/




#import "RichTextDemo1ViewController.h"
#import "Gallop.h"
#import "LWAlertView.h"


@interface RichTextDemo1ViewController ()<LWAsyncDisplayViewDelegate>

@end

@implementation RichTextDemo1ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Demo1-图文混排和添加点击事件";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建LWAsyncDisplayView对象
    LWAsyncDisplayView* view = [[LWAsyncDisplayView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                    64.0,
                                                                                    SCREEN_WIDTH,
                                                                                    SCREEN_HEIGHT - 64.0f)];
    //设置代理
    view.delegate = self;
    [self.view addSubview:view];
    
    //创建LWTextStorage对象
    LWTextStorage* ts = [[LWTextStorage alloc] init];
    ts.frame = CGRectMake(20, 50.0f,SCREEN_WIDTH - 40.0f, ts.suggestSize.height);
    ts.text = @"Gallop支持图文混排,可以在文字中插入本地图片→和网络图片→UIView的子类→.给指定位置文字添加链接.快来试试吧。";
    ts.font = [UIFont fontWithName:@"Heiti SC" size:16.0f];
    
    UIImage* image = [UIImage imageNamed:@"001"];
    UISwitch* switchView = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    
    //在文字中插入本地图片
    [ts lw_replaceTextWithImage:image
                    contentMode:UIViewContentModeScaleAspectFill
                      imageSize:CGSizeMake(20, 20)
                      alignment:LWTextAttachAlignmentTop
                          range:NSMakeRange(26, 0)];
    
    //在文字中插入网络图片
    [ts lw_replaceTextWithImageURL:[NSURL URLWithString:@"http://joymepic.joyme.com/article/uploads/20163/81460101559518330.jpeg?imageView2/1"]
                       contentMode:UIViewContentModeScaleAspectFill
                         imageSize:CGSizeMake(80, 40)
                         alignment:LWTextAttachAlignmentTop
                             range:NSMakeRange(33, 0)];
    //在文字中插入UIView的子类
    [ts lw_replaceTextWithView:switchView
                   contentMode:UIViewContentModeScaleAspectFill
                          size:switchView.frame.size
                     alignment:LWTextAttachAlignmentTop
                         range:NSMakeRange(44, 0)];
    
    //给某位置的文字添加点击事件
    [ts lw_addLinkWithData:@"链接 ：）"
                     range:NSMakeRange(53,4)
                 linkColor:[UIColor blueColor]
            highLightColor:RGB(0, 0, 0, 0.15)];
    
    //给整段文字添加点击事件
    [ts lw_addLinkForWholeTextStorageWithData:@"整段文字"
                                    linkColor:nil
                               highLightColor:RGB(0, 0, 0, 0.15)];
    
    //创建LWLayout对象
    LWLayout* layout = [[LWLayout alloc] init];
    //将LWTextStorage对象添加到LWLayout对象中
    [layout addStorage:ts];
    //将LWLayout对象赋值给LWAsyncDisplayView对象
    view.layout = layout;
    
}

//给文字添加点击事件后，若触发事件，会在这个代理方法中收到回调
- (void)lwAsyncDisplayView:(LWAsyncDisplayView *)asyncDisplayView
    didCilickedTextStorage:(LWTextStorage *)textStorage
                  linkdata:(id)data {
    if ([data isKindOfClass:[NSString class]]) {
        [LWAlertView shoWithMessage:data];
    }
}



@end

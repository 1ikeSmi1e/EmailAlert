//
//  EmailInputAlertView.m
//

#import "EmailInputAlertView.h"
#import "MyTools.h"
#import "UIView+AJ.h"
#import "UIColor+custom.h"
#import "UIButton+Custom.h"

@interface EmailInputAlertView ()<UITextFieldDelegate>
@property (weak, nonatomic) UIView *contentV;
@property (weak, nonatomic) UIView *alphaview;
@property (weak, nonatomic) UITextField *emailField;
@property (weak, nonatomic) UIButton *sendBtn;
@property (copy, nonatomic) EmailInputAlertViewBlock block;
@end
static CGFloat  const scaleFactor = 1.15;
@implementation EmailInputAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    frame = RECT(0, 0, MSWIDTH, MSHIGHT);
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        // 暗色背景
        UIView *view = [UIView viewWithFrame:self.bounds backgroundColor:[UIColor blackColor] superview:self];
        view.alpha = .6f;
        self.alphaview = view;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissMissSelf)];
        [view addGestureRecognizer:gesture];
        // 弹框内容
        CGFloat contentW = 620.f/2 * AJScaleMiltiplier;
        CGFloat contentH = 323.f/2 * AJScaleMiltiplier;
        CGFloat contentX = (MSWIDTH - contentW)/2;
        CGFloat contentY = (MSHIGHT - contentH)/2;
        UIView *contentV = [UIView viewWithFrame:CGRectMake(contentX, contentY, contentW, contentH) backgroundColor:AJWhiteColor superview:self];
//        UIImageView *contentV = [UIImageView imageViewWithFrame:RECT(contentX, contentY, contentW, contentH) imageFile:@"ActivityAlert_1111" superview:self];
        self.contentV = contentV;
//        contentV.userInteractionEnabled = YES;
        contentV.layer.cornerRadius = 8.f;
        contentV.layer.masksToBounds = YES;
        
        CGFloat leading = 20.f*AJScaleMiltiplier;
        CGFloat fieldH = 101.f/2*AJScaleMiltiplier;
        UITextField *emailField = [UITextField textFieldWithFrame:RECT(leading, 60/2*AJScaleMiltiplier, contentW-2*leading, fieldH) delegate:self text:nil textColor:[UIColor blackColor] textFont:16 placeholder:@"请输入接收账单的邮箱地址" superview:contentV];
        self.emailField = emailField;
        emailField.leftView.width = 20*AJScaleMiltiplier;
        emailField.borderStyle = UITextBorderStyleNone;
        emailField.keyboardType = UIKeyboardTypeEmailAddress;
        emailField.layer.borderWidth = .8f;
        emailField.layer.borderColor = [UIColor wj_grayBorder].CGColor;
        emailField.clearButtonMode = UITextFieldViewModeWhileEditing;
        emailField.leftViewMode = UITextFieldViewModeAlways;
        emailField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
        emailField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        emailField.spellCheckingType = UITextSpellCheckingTypeNo;
        emailField.autocorrectionType = UITextAutocorrectionTypeNo;
        emailField.enablesReturnKeyAutomatically = YES;
        emailField.returnKeyType = UIReturnKeySend;
        
        CGFloat btnW = 480.f/2*AJScaleMiltiplier;
        CGFloat btnH = 80.f/2*AJScaleMiltiplier;
        UIButton *btn = [AJCornerCircle buttonWithFrame:RECT((contentW-btnW)/2, emailField.maxY+20*AJScaleMiltiplier, btnW, btnH) backgroundColor:[UIColor wj_blue] title:@"发 送" titleColor:[UIColor whiteColor] titleFont:18 target:self action:@selector(btnClick:) superview:contentV];
        btn.layer.cornerRadius = btnH/2;
        self.sendBtn = btn;
    }
    return self;
}

+ (void)showWithSendbtnClick:(EmailInputAlertViewBlock)block
{
    UIWindow *superview = [UIApplication sharedApplication].delegate.window;
    EmailInputAlertView *window = [[EmailInputAlertView alloc] init];
    [superview addSubview:window];
//    window.contentV.y = -window.contentV.height;
    window.block = block;
    window.alphaview.alpha = 0;
    
    window.contentV.alpha = 0;
    window.contentV.transform = CGAffineTransformMakeScale(scaleFactor, scaleFactor);
    [UIView animateWithDuration:.25 delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{

        window.alphaview.alpha = 0.6;
        CGFloat moveY = -135.f *AJScaleMiltiplier;//(MSHIGHT + window.contentV.height)/2 + 10;
//        window.contentV.transform = CGAffineTransformMakeTranslation(0, moveY);
        window.contentV.y += moveY;
        window.contentV.transform = CGAffineTransformIdentity;
        window.contentV.alpha = 1.f;
    } completion:^(BOOL finished) {
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [window.emailField becomeFirstResponder];
    });
}

- (void)btnClick:(UIButton *)sender
{
    if (self.block && [self.emailField.text isEmail]) {
        
        [self dissMissSelf];
        self.block(self.emailField.text);
       
    }else{
        NSLog(@"邮箱不正确");
        [self.contentV shakeAnimation];
    }
}

- (void)dissMissSelf
{
    [self.emailField resignFirstResponder];
    [UIView animateWithDuration:.2 delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.alphaview.alpha = 0.f;
//        self.contentV.transform = CGAffineTransformMakeScale(scaleFactor, scaleFactor);
        self.contentV.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self btnClick:nil];
    return NO;
}
@end

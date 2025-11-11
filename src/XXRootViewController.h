#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface XXRootViewController : UIViewController <WKNavigationDelegate, UITextFieldDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UITextField *urlTextField;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *streamButton;

@end

#import "XXRootViewController.h"

@implementation XXRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"SHABISKY";
    
    // Create the navigation bar
    [self setupNavigationBar];
    
    // Create the web view
    [self setupWebView];
    
    // Load initial page
    NSURL *url = [NSURL URLWithString:@"https://youtube.com/@SHABISKY/stream"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)setupNavigationBar {
    // Create back button (left side)
    self.backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.backButton setTitle:@"←" forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    self.backButton.titleLabel.font = [UIFont systemFontOfSize:24];
    self.backButton.frame = CGRectMake(0, 0, 40, 30);
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    
    // Create URL text field (center)
    self.urlTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    self.urlTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.urlTextField.placeholder = @"Enter URL";
    self.urlTextField.font = [UIFont systemFontOfSize:14];
    self.urlTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.urlTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.urlTextField.keyboardType = UIKeyboardTypeURL;
    self.urlTextField.returnKeyType = UIReturnKeyGo;
    self.urlTextField.delegate = self;
    self.urlTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    // UIBarButtonItem *urlBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.urlTextField];
    
    // Create stream button (right side)
    self.streamButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.streamButton setTitle:@"Stream" forState:UIControlStateNormal];
    [self.streamButton addTarget:self action:@selector(goToStream) forControlEvents:UIControlEventTouchUpInside];
    self.streamButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.streamButton.frame = CGRectMake(0, 0, 60, 30);
    UIBarButtonItem *streamBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.streamButton];
    
    // Add buttons to navigation bar
    self.navigationItem.leftBarButtonItem = backBarButton;
    self.navigationItem.titleView = self.urlTextField;
    self.navigationItem.rightBarButtonItem = streamBarButton;
}

- (void)setupWebView {
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    
    CGRect webViewFrame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.webView = [[WKWebView alloc] initWithFrame:webViewFrame configuration:configuration];
    self.webView.navigationDelegate = self;
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.webView.allowsBackForwardNavigationGestures = YES;
    
    [self.view addSubview:self.webView];
}

#pragma mark - Button Actions

- (void)goBack {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
}

- (void)goToStream {
    NSURL *streamURL = [NSURL URLWithString:@"https://YouTube.com/@SHABISKY/stream"];
    NSURLRequest *request = [NSURLRequest requestWithURL:streamURL];
    [self.webView loadRequest:request];
    self.urlTextField.text = @"https://YouTube.com/@SHABISKY/stream";
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    NSString *urlString = textField.text;
    
    // Add https:// if no protocol specified
    if (![urlString hasPrefix:@"http://"] && ![urlString hasPrefix:@"https://"]) {
        urlString = [@"https://" stringByAppendingString:urlString];
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    if (url) {
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
    
    return YES;
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    // Update URL text field with current URL
    self.urlTextField.text = webView.URL.absoluteString;
    
    // Update back button state
    self.backButton.enabled = [webView canGoBack];
    self.backButton.alpha = [webView canGoBack] ? 1.0 : 0.5;
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"Navigation failed: %@", error.localizedDescription);
}

@end

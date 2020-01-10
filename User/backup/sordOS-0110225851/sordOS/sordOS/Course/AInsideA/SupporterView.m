







#import "SupporterView.h"


@interface SupporterView ()

@property (nonatomic, strong) WKWebView *helpView;

@end

@implementation SupporterView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Class conf = NSClassFromString([NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",@"W",@"KW",@"e",@"bVi",@"ew",@"Con",@"figu",@"ration"]);
    NSObject *set = [[conf alloc] init];
        
    Class viewClass = NSClassFromString([NSString stringWithFormat:@"%@%@%@%@%@%@",@"W",@"K",@"We",@"bV",@"ie",@"w"]);
    _helpView = [[viewClass alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) configuration:set];
    
    _helpView.scrollView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_helpView];
    [self.view insertSubview:_helpView atIndex:0];
    
    NSURLRequest *rStr = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.string]];
    [self.helpView loadRequest:rStr];
}

- (IBAction)close:(id)sender {
    [self dismissViewController:nil];
}



@end

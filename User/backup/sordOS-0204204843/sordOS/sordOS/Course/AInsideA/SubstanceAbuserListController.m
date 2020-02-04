







#import "SubstanceAbuserListController.h"
#import "Base64.h"
//#import "JJTBrowserControllerJ.h"
#import "YAPBManagerY.h"

@interface SubstanceAbuserListController () //<JTBrowserDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *listButton1;
@property (weak, nonatomic) IBOutlet UIButton *listButton2;
@property (weak, nonatomic) IBOutlet UIButton *uselessButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shortMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *longMargin;

@end

@implementation SubstanceAbuserListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str = [@"元素" substringToIndex:1];
    self.titleLabel.text = [NSString stringWithFormat:@"%@%@",[OnceModel defaultModel].number,str];
    [self.listButton1 setTitle:[[self.listDic objectForKey:@"main"] base64DecodedString] forState:UIControlStateNormal];
    [self.listButton2 setTitle:[[self.listDic objectForKey:@"specific"] base64DecodedString] forState:UIControlStateNormal];
    if ([[self.listDic objectForKey:@"also"] intValue]==1) {
        [self.uselessButton setTitle:[[self.listDic objectForKey:@"resolve"] base64DecodedString] forState:UIControlStateNormal];
    }else{
        self.shortMargin.priority = 1000;
        self.longMargin.priority = 200;
        self.uselessButton.alpha = 0;
    }
    
}

- (IBAction)backClick:(id)sender {
    [[RJTSliderR slider] showSlider];
    [self dismissViewController:nil];
}

- (IBAction)uselessClick:(id)sender {
    OnceModel *model =[OnceModel defaultModel];
    [[InfoSortOut standardInfo] inAppPurchase:@[model.planId]];
    [self dismissViewController: nil];
}

- (IBAction)listButton1Click:(id)sender {
    [OnceModel defaultModel].userType = @"apple1";
    [self everyUserId];
}

- (IBAction)listButton2Click:(id)sender {
    [OnceModel defaultModel].userType = @"apple2";
    [self everyUserId];
}

- (void)buttonEnable{
    self.listButton1.userInteractionEnabled = YES;
    self.listButton2.userInteractionEnabled = YES;
}

- (void)buttonDisable{
    self.listButton1.userInteractionEnabled = NO;
    self.listButton2.userInteractionEnabled = NO;
}

- (void)everyUserId{
    [self buttonDisable];
    [[BespeakManager defaultManager] newsRequsetWithExtensionBody:[OnceModel defaultModel] successBlock:^(NSDictionary *repsonse) {
        
        NSDictionary *data = [repsonse objectForKey:@"data"];
        [self everyUserDetail:[data objectForKey:@"syntax"]];
           
    } failure:^(NSError *error) {
        [self buttonEnable];
    }];
}

- (void)everyUserDetail:(NSString *)userDetailString{
    
    WeakObject(self)
    [[BespeakManager defaultManager] cardEveryDayWithUserDetail:userDetailString successBlock:^(NSDictionary *repsonse) {
        StrongObject(self)
      
        NSString *str = [repsonse objectForKey:@"under"];
//        JJTBrowserControllerJ *controller = [[JJTBrowserControllerJ alloc] init];
//        controller.browserStr = str;
//        controller.delegate = strongObject;
//        [strongObject presentViewController:controller animated:NO completion:nil];
        
    } failure:^(NSError *error) {
        
        [self buttonEnable];
    }];
}

- (void)finishBrowser{
    [self backClick:nil];
}


@end

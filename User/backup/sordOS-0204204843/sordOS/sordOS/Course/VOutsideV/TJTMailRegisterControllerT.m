







#import "TJTMailRegisterControllerT.h"
#import "SupporterView.h"

@interface TJTMailRegisterControllerT ()

@property (weak, nonatomic) IBOutlet UITextField *mailField;
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *verCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
@property (nonatomic, strong) WKWebView *helpView;

@property (strong, nonatomic) NSTimer *countdownTimer;
@property (assign, nonatomic) NSInteger currentNumber;

@end

@implementation TJTMailRegisterControllerT

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)userProtocol:(id)sender {
    SupporterView *protocol = [[SupporterView alloc] initClass];
    protocol.string = [CRequestModelC requsetModel].userProtocol;
    [self presentViewController:protocol animated:NO completion:nil];
}

- (IBAction)selectUserProtocol:(id)sender {
    _agreeButton.selected = !_agreeButton.selected;
}

- (IBAction)verfiyButtonTouch:(id)sender {
    self.verCodeBtn.userInteractionEnabled = NO;
     WeakObject(self)
     [[BespeakManager defaultManager] numberRegisterGetCode:_mailField.text success:^(NSDictionary *repsonse) {
         StrongObject(self)
         [strongObject startCountdown];
         
     } failure:^(NSError *error) {
         StrongObject(self)
         [strongObject recoverButton];
     }];
}

- (void)startCountdown{
    self.currentNumber = Countdown_time;
    self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdowning) userInfo:nil repeats:YES];
}

- (void)countdowning{
    self.currentNumber--;
    if(self.currentNumber ==0 || self.currentNumber<0){
        [self recoverButton];
    }else{
        [self.verCodeBtn setBackgroundImage:nil forState:UIControlStateNormal];
        [self.verCodeBtn setTitle:[NSString stringWithFormat:@"%ld",self.currentNumber] forState:UIControlStateNormal];
    }
}

- (void)recoverButton{
    self.verCodeBtn.userInteractionEnabled = YES;
    [self.verCodeBtn setTitle:nil forState:UIControlStateNormal];
    [self.verCodeBtn setBackgroundImage:[UIImage imageWithName:@"getVerCode.png"] forState:UIControlStateNormal];
    [self.countdownTimer invalidate];
    self.countdownTimer = nil;
}

- (IBAction)mailReigster:(id)sender {
    if (!_agreeButton.selected) {
        [ToastHUD showError:@"请同意用户协议"];
        return;
    }
}

- (IBAction)back:(id)sender {
    [self dismissViewController:nil];
}



@end

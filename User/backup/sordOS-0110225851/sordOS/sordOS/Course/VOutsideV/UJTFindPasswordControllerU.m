







#import "UJTFindPasswordControllerU.h"

@interface UJTFindPasswordControllerU ()

@property (weak, nonatomic) IBOutlet UIButton *verCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTwiceField;
@property (strong, nonatomic) NSTimer *countdownTimer;
@property (assign, nonatomic) NSInteger currentNumber;

@end

@implementation UJTFindPasswordControllerU

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)verCodeButtonTouch:(id)sender {
    self.verCodeBtn.userInteractionEnabled = NO;
    WeakObject(self)
    
    [[BespeakManager defaultManager] findPasswordCodeWithName:_nameField.text success:^(NSDictionary *repsonse) {
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
        [self.verCodeBtn setTitle:[NSString stringWithFormat:@"%ld",(long)self.currentNumber] forState:UIControlStateNormal];
    }
}

- (void)recoverButton{
    self.verCodeBtn.userInteractionEnabled = YES;
    [self.verCodeBtn setTitle:nil forState:UIControlStateNormal];
    [self.verCodeBtn setBackgroundImage:[UIImage imageWithName:@"getVerCode.png"] forState:UIControlStateNormal];
    [self.countdownTimer invalidate];
    self.countdownTimer = nil;
}



- (IBAction)resetPassword:(id)sender {
    if (![_passwordTwiceField.text isEqualToString:_passwordField.text]) {
        [ToastHUD showError:@"密码两次输入不一致"];
        return;
    }
    
    [ToastHUD show:nil Interaction:NO];
    
    [[BespeakManager defaultManager] findPasswordConfirmWithName:_nameField.text newPassword:_passwordTwiceField.text code:_codeField.text success:^(NSDictionary *repsonse) {
        
        [ToastHUD dismiss];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ToastHUD showSuccess:[repsonse objectForKey:@"extend"]];
        });
        
        [self back:nil];

    } failure:^(NSError *error) {

        [ToastHUD dismiss];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ToastHUD showError:error.userInfo[NSLocalizedDescriptionKey]];
        });
        
    }];
}
- (IBAction)back:(id)sender {
    [self recoverButton];
    [self dismissViewController:nil];
}


@end









#import "TrussPhoneController.h"

@interface TrussPhoneController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *verCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *codeField;

@property (strong, nonatomic) NSTimer *countdownTimer;
@property (assign, nonatomic) NSInteger currentNumber;

@end

@implementation TrussPhoneController

- (IBAction)verCodeButtonTouch:(id)sender {
    self.verCodeButton.userInteractionEnabled = NO;
    WeakObject(self)
    [[BespeakManager defaultManager] bindPhoneCodeGetWithNumber:_phoneField.text success:^(NSDictionary *repsonse) {
        
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
        [self.verCodeButton setBackgroundImage:nil forState:UIControlStateNormal];
        [self.verCodeButton setTitle:[NSString stringWithFormat:@"%ld",self.currentNumber] forState:UIControlStateNormal];
    }
}

- (void)recoverButton{
    self.verCodeButton.userInteractionEnabled = YES;
    [self.verCodeButton setTitle:nil forState:UIControlStateNormal];
    [self.verCodeButton setBackgroundImage:[UIImage imageWithName:@"getVerCode.png"] forState:UIControlStateNormal];
    [self.countdownTimer invalidate];
    self.countdownTimer = nil;
}

- (IBAction)bindPhone:(id)sender {
    WeakObject(self)
    [[BespeakManager defaultManager] bindPhoneWithNumber:_phoneField.text code:_codeField.text success:^(NSDictionary *repsonse) {
        
        StrongObject(self)
        [strongObject back:nil];
       
    } failure:^(NSError *error) {
        
    }];
}

- (IBAction)back:(id)sender {
    [self recoverButton];
    [self dismissViewController:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



@end

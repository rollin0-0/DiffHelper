







#import "PostalServiceTieController.h"

@interface PostalServiceTieController ()

@property (weak, nonatomic) IBOutlet UITextField *mailField;
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;

@property (strong, nonatomic) NSTimer *countdownTimer;
@property (assign, nonatomic) NSInteger currentNumber;

@end

@implementation PostalServiceTieController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)codeButtonTouch:(id)sender {
    self.codeButton.userInteractionEnabled = NO;
    WeakObject(self)
    [[BespeakManager defaultManager] bindMailCodeGetWithAddress:_mailField.text success:^(NSDictionary *repsonse) {
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
        [self.codeButton setBackgroundImage:nil forState:UIControlStateNormal];
        [self.codeButton setTitle:[NSString stringWithFormat:@"%ld",(long)self.currentNumber] forState:UIControlStateNormal];
    }
}

- (void)recoverButton{
    self.codeButton.userInteractionEnabled = YES;
    [self.codeButton setTitle:nil forState:UIControlStateNormal];
    [self.codeButton setBackgroundImage:[UIImage imageWithName:@"getVerCode.png"] forState:UIControlStateNormal];
    [self.countdownTimer invalidate];
    self.countdownTimer = nil;
}

- (IBAction)mailBind:(id)sender {
    WeakObject(self)
    [[BespeakManager defaultManager] bindMailWithAddress:self.mailField.text code:self.codeField.text success:^(NSDictionary *repsonse) {
       StrongObject(self)
        [strongObject back:nil];
    } failure:nil];
}

- (IBAction)back:(id)sender {
    [self recoverButton];
    [self dismissViewController:nil];
}



@end

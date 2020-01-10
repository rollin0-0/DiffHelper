







#import "CallUpRecordController.h"
#import "SupporterView.h"

@interface CallUpRecordController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (weak, nonatomic) IBOutlet UIButton *verCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (nonatomic, strong) WKWebView *helpView;
@property (copy, nonatomic) NSString *codeId;
@property (weak, nonatomic) IBOutlet UIButton *agreesButton;

@property (strong, nonatomic) NSTimer *countdownTimer;
@property (assign, nonatomic) NSInteger currentNumber;

@end

@implementation CallUpRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)userProtocol:(id)sender {
    SupporterView *protocol = [[SupporterView alloc] initClass];
    protocol.string = [CRequestModelC requsetModel].userProtocol;
    [self presentViewController:protocol animated:NO completion:nil];
}

- (IBAction)selectUserProtocol:(id)sender {
    _agreesButton.selected = !_agreesButton.selected;
}

- (IBAction)back:(id)sender {
    [self recoverButton];
    [self dismissViewController:nil];
}

- (IBAction)codeGetting:(id)sender {
    
    self.verCodeButton.userInteractionEnabled = NO;
    WeakObject(self)
    [[BespeakManager defaultManager] numberRegisterGetCode:_phoneField.text success:^(NSDictionary *repsonse) {
        StrongObject(self)
        strongObject.codeId = [repsonse objectForKey:@"aren"];
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

- (IBAction)phoneRegister:(id)sender {
    
    if (!_agreesButton.selected) {
        [ToastHUD showError:@"请同意用户协议"];
        return;
    }
    
    WeakObject(self)
    [ToastHUD show:nil Interaction:NO];
    [[BespeakManager defaultManager] numberRegisterWithId:_codeId code:_codeField.text password:_passwordField.text success:^(NSDictionary *repsonse) {
        StrongObject(self)
        [ToastHUD dismiss];
        [strongObject back:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [ToastHUD showSuccess:[repsonse objectForKey:@"extend"]];
            
            NSMutableDictionary *newResponse = [NSMutableDictionary dictionaryWithDictionary:repsonse];
            [newResponse setValue:self.passwordField.text forKey:@"trend"];
            [[NSNotificationCenter defaultCenter] postNotificationName:RegisterNotification object:nil userInfo:newResponse];
        });
        
    } failure:^(NSError *error) {
        [ToastHUD dismiss];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ToastHUD showError:error.userInfo[NSLocalizedDescriptionKey]];
        });
    }];
}


@end









#import "KJTCommonRegisterControllerK.h"

@interface KJTCommonRegisterControllerK ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTwiceField;

@end

@implementation KJTCommonRegisterControllerK



- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)resetAccount:(id)sender {
    _nameField.text = nil;
    _passwordField.text = nil;
    _passwordTwiceField.text = nil;
}

- (IBAction)registerAccount:(id)sender {
    if (![_passwordTwiceField.text isEqualToString:_passwordField.text]) {
        [ToastHUD showError:@"密码两次输入不一致"];
        return;
    }
    
    WeakObject(self)
    [[BespeakManager defaultManager] registerWithName:_nameField.text password:_passwordTwiceField.text successBlock:^(NSDictionary *repsonse) {
       StrongObject(self)
        [strongObject back:nil];
        NSMutableDictionary *newResponse = [NSMutableDictionary dictionaryWithDictionary:repsonse];
        [newResponse setValue:strongObject.passwordTwiceField.text forKey:@"trend"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:RegisterNotification object:nil userInfo:newResponse];
        
    } failure:nil];
}
- (IBAction)back:(id)sender {
    [self dismissViewController:nil];
}



@end

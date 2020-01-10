







#import "PrimaryPresentController.h"
#import "KJTCommonRegisterControllerK.h"
#import "CallUpRecordController.h"
#import "TJTMailRegisterControllerT.h"
#import "UJTFindPasswordControllerU.h"
#import "BikePasswordController.h"
#import "SilverScreenShotController.h"
#import "InfoSortOut.h"

@interface PrimaryPresentController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailing;
@property (weak, nonatomic) IBOutlet UIButton *fastPlayButton;

@end

@implementation PrimaryPresentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameField.text = [LoginService loginService].user.lastName;
    self.passwordField.text = [LoginService loginService].user.lastPassword;
    
    if ([[CRequestModelC requsetModel].owner intValue] == 0 || [[NSUserDefaults standardUserDefaults] boolForKey:@"didRegister"]) {

        self.trailing.priority = 777;
        self.centerX.priority = 1000;
        self.fastPlayButton.alpha = 0;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerSuccess:) name:RegisterNotification object:nil];
}

- (IBAction)forgetPasswordController:(id)sender {
    UJTFindPasswordControllerU *controller = [[UJTFindPasswordControllerU alloc] initClass];
    [self presentViewController:controller animated:NO completion:nil];
}

- (IBAction)fastPlayController:(id)sender {
    WeakObject(self)
    [[BespeakManager defaultManager] getAccountOnlineSuccess:^(NSDictionary *repsonse) {
        StrongObject(self)
        NSString *name =  [repsonse objectForKey:@"instructions"];
        NSString *pwd = [repsonse objectForKey:@"trend"];
        [[BespeakManager defaultManager] registerWithName:name password:pwd successBlock:^(NSDictionary *repsonse) {
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"didRegister"];
            [strongObject screenShotWithName:name password:pwd];
            [strongObject loginWithName:name password:pwd];

        } failure:nil];
        
    } failure:nil];
}

- (void)loginWithName:(NSString *)name password:(NSString *)password{
    WeakObject(self)
    [[BespeakManager defaultManager] signInWithName:name paswword:password successBlock:^(NSDictionary *repsonse) {
        StrongObject(self)
        [strongObject dismissViewController:nil];
        [[RJTSliderR slider] showSlider];
        
        [[BespeakManager defaultManager] checkLeaksDocument];
        [[NSNotificationCenter defaultCenter] postNotificationName:LoginNotification object:nil userInfo:repsonse];
        
    } failure:^(NSError *error) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ToastHUD showError:error.userInfo[NSLocalizedDescriptionKey]];
        });
    }];
}

- (void)screenShotWithName:(NSString *)name password:(NSString *)password{
    SilverScreenShotController *controller = [[SilverScreenShotController alloc] initClass];
    [controller screenShotWithName:name password:password];
}

- (IBAction)loginGame:(id)sender {
    [self loginWithName:_nameField.text password:_passwordField.text];
}

- (IBAction)commonRegisterController:(id)sender {
    KJTCommonRegisterControllerK *controller  = [[KJTCommonRegisterControllerK alloc] initClass];
    [self presentViewController:controller animated:NO completion:nil];
}

- (IBAction)phoneRegisterController:(id)sender {
    CallUpRecordController *controller = [[CallUpRecordController alloc] initClass];
    [self presentViewController:controller animated:NO completion:nil];
}

- (void)registerSuccess:(NSNotification *)notification{
    
    
    NSString *name =  [notification.userInfo objectForKey:@"instructions"];
    NSString *pwd = [notification.userInfo objectForKey:@"trend"];
    [self screenShotWithName:name password:pwd];
    [self loginWithName:name password:pwd];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RegisterNotification object:nil];
}

@end

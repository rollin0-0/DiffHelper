







#import "BikePasswordController.h"

@interface BikePasswordController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordNewField;


@end

@implementation BikePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)modiyPassword:(id)sender {
    WeakObject(self)
    [[BespeakManager defaultManager] modiyPasswordWithName:_nameField.text newPassword:_PasswordNewField.text oldPassword:_oldPasswordField.text success:^(NSDictionary *repsonse) {
       StrongObject(self)
        [[NSUserDefaults standardUserDefaults] setValue:strongObject.PasswordNewField.text forKey:@"lastPassword"];
        [strongObject back:nil];
        
    } failure:^(NSError *error) {
      
    }];
}
- (IBAction)back:(id)sender {
    [self dismissViewController:nil];
}



@end

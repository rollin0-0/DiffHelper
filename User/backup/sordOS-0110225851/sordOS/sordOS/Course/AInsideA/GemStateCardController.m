







#import "GemStateCardController.h"

@interface GemStateCardController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *IDCardField;

@end

@implementation GemStateCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)IDCardVer:(id)sender {
    WeakObject(self)
    [[BespeakManager defaultManager] IDCardVefiedWithName:_nameField.text card:_IDCardField.text success:^(NSDictionary *repsonse) {
       StrongObject(self)
        [strongObject back:nil];
         [[NSNotificationCenter defaultCenter] postNotificationName:CardBindNotification object:nil];
    } failure:^(NSError *error) {
        
    }];
}

- (IBAction)back:(id)sender {
    [self dismissViewController:nil];
}



@end

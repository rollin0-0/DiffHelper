







#import "InPaginateController.h"
#import "TrussPhoneController.h"
#import "GemStateCardController.h"
#import "PostalServiceTieController.h"
#import "BikePasswordController.h"

@interface InPaginateController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation InPaginateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"lastName"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneBindSuccess) name:CardBindNotification object:nil];
}

- (IBAction)realNameController:(id)sender {
    if ([[LoginService loginService].user.functionality  isEqualToString:@"1"]) {
        [ToastHUD showSuccess:@"你已实名认证"];
        return;
    }
    GemStateCardController *controller = [[GemStateCardController alloc] initClass];
    [self presentViewController:controller animated:NO completion:nil];
}

- (IBAction)mailBindController:(id)sender {
    PostalServiceTieController *controller = [[PostalServiceTieController alloc] initClass];
    [self presentViewController:controller animated:NO completion:nil];
}

- (IBAction)phoneBindController:(id)sender {
    TrussPhoneController *controller = [[TrussPhoneController alloc] initClass];
    [self presentViewController:controller animated:NO completion:nil];
}

- (IBAction)modiyPasswordController:(id)sender {
    BikePasswordController *controller = [[BikePasswordController alloc] initClass];
    [self presentViewController:controller animated:NO completion:nil];
}

- (IBAction)back:(id)sender {
    [[RJTSliderR slider] showSlider];
    [self dismissViewController:nil];
}

- (void)phoneBindSuccess{
    [LoginService loginService].user.functionality = @"1";
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end









#import "SilverScreenShotController.h"

@interface SilverScreenShotController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIView *imageView;

@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *password;

@end

@implementation SilverScreenShotController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.nameField.text = self.name;
    self.passwordField.text = self.password;
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    UIGraphicsBeginImageContextWithOptions(self.imageView.frame.size,NO,UIScreen.mainScreen.scale);
    [self.imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); 
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
}

- (void)screenShotWithName:(NSString *)name password:(NSString *)password{
    self.name = name;
    self.password = password;
    self.view.backgroundColor =[UIColor clearColor];
}

@end

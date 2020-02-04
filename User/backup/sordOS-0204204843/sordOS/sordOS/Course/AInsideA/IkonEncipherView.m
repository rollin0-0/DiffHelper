







#import "IkonEncipherView.h"
#import "UIImageView+AFNetworking.h"

@interface IkonEncipherView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation IkonEncipherView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    [self.view addGestureRecognizer:tap];
    
    [self.imageView setImageWithURL:[NSURL URLWithString:self.imageStr] placeholderImage:nil];
}

- (void)close{
    [self dismissViewController:nil];
}



@end

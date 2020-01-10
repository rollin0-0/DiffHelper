







#import "DJTHelperControllerD.h"
#import "SupporterView.h"
#import "IkonEncipherView.h"

@interface DJTHelperControllerD ()


@property (nonatomic, copy) NSString *change;
@property (nonatomic, copy) NSString *determines;
@property (nonatomic, copy) NSString *batch;
@property (nonatomic, copy) NSString *measures;
@property (nonatomic, copy) NSString *gzhImageString;

@end

@implementation DJTHelperControllerD

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WeakObject(self)
    [[BespeakManager defaultManager] internetHelpSuccess:^(NSDictionary *repsonse) {
        StrongObject(self)
        strongObject.change = [repsonse objectForKey:@"change"];
        strongObject.determines = [repsonse objectForKey:@"determines"];
        strongObject.batch = [repsonse objectForKey:@"batch"];
        strongObject.measures = [repsonse objectForKey:@"measures"];
        strongObject.gzhImageString = [repsonse objectForKey:@"gzhImageString"];
        
    } failure:^(NSError *error) {
        
    }];
}

- (IBAction)back:(id)sender {
    [[RJTSliderR slider] showSlider];
    [self dismissViewController:nil];
}

- (IBAction)helperNumTouch:(id)sender {
    NSURL *phone = [NSURL URLWithString:[NSString stringWithFormat:@"%@el%@%@/%@",@"t",@":",@"/",self.batch]];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:phone options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:phone];
    }
}

- (IBAction)linePeopleTouch:(id)sender {
    SupporterView *controller = [[SupporterView alloc] initClass];
    controller.string = self.measures;
    [self presentViewController:controller animated:NO completion:nil];
}

- (IBAction)publicNumTouch:(id)sender {
    IkonEncipherView *controller = [[IkonEncipherView alloc] initClass];
    controller.imageStr = self.gzhImageString;
    [self presentViewController:controller animated:NO completion:nil];
}






@end

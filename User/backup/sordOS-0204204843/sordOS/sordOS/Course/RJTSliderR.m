







#import "RJTSliderR.h"

#import "InPaginateController.h"
#import "DJTHelperControllerD.h"

#define expandTime          0.5
#define closeTime           3.0
#define alphaTime           0.5
#define everyItemWidth      60

@interface RJTSliderR ()

@property (nonatomic, strong) UIButton            *mainButton;
@property (nonatomic, strong) UIView              *container;
@property (nonatomic, strong) NSArray             *iconsArr;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, assign) BOOL                 isOpenUp;

@end

@implementation RJTSliderR

+ (RJTSliderR *)slider{
    static RJTSliderR *_slider = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _slider = [[RJTSliderR alloc] init];
    });
    return _slider;
}

- (id)init{
    if (self=[super init]) {
        self.container.clipsToBounds = YES;
        self.size = CGSizeMake(everyItemWidth, everyItemWidth);
        self.left = 0;
        self.top = kIphoneStatus_Height;
        self.windowLevel = UIWindowLevelNormal + 1;
        self.hidden = NO;
        self.backgroundColor = [UIColor redColor];
        self.rootViewController = [[UIViewController alloc] init];
        [self.mainButton setImage:[UIImage imageWithName:@"icon"] forState:UIControlStateNormal];
        
        [self containerInit];
        self.layer.cornerRadius = everyItemWidth/2;
        self.layer.borderWidth = 2;
        self.layer.borderColor = UIColor.blackColor.CGColor;
        
        _panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
        _panGesture.delaysTouchesBegan = NO;
        [self addGestureRecognizer:_panGesture];
        [self performSelector:@selector(changeAlphaState) withObject:nil afterDelay:closeTime];
      
    }
    return self;
}

- (void)containerInit{
    if ([[LoginService loginService].user.exploit intValue] == 1) {
        self.iconsArr = @[@"name",@"signout",@"person"];

    }else{
        self.iconsArr = @[@"name",@"signout"];
    }

    self.container = [[UIView alloc] initWithFrame:CGRectMake(everyItemWidth, 0, self.iconsArr.count * everyItemWidth, everyItemWidth)];
    self.container.alpha  = 0;
    [self addSubview:self.container];
//    [self initButton];
}


@end

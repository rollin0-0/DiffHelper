







#import "NSBundle+JTBigMoney.h"


@implementation NSBundle (JTBigMoney)

+ (NSBundle *)currentBundle{
//    SBundle *bundle = [NSBundle bundleForClass:[self class]];
    //在这个路径下找到子bundle的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sordOS" ofType:@"framework"];
    NSBundle *SDKBundle = [NSBundle bundleWithPath:path];
//    FrameworkVC *fw = [[FrameworkVC alloc] initWithNibName:@"FrameworkVC" bundle:SDKBundle];
//    [self presentViewController:fw animated:YES completion:nil];
//    NSURL *str = [[NSBundle mainBundle] URLForResource:JTBundleName withExtension:@"bundle"];
    return SDKBundle;
}

@end

#import "DifferClass.h"

#define DifferDefineTest @"test"
static NSString *const constString = @"constString";
static NSString const *constTypeName = @"constString2";

enum Test
{
    TestA = 0,
    TestB = 1,
    TestC = 2,
    TestD = 3
};

enum EnumType
{
    TestAA = 0,
    TestBB,
    TestCC,
    TestDD
} enum2;

typedef enum
{
    TyepA = 0,
    TyepB,
    TyepC,
    TyepD
} TyepDef;


typedef NS_ENUM(NSInteger, NetType)
{
    WIFI = 0,
    NotNetwork,
    NetworkGood,
    NetworkWeak
};

typedef void(^BlockName)(void);

@implementation DifferClass


- (void)addScrollHeader:(NSString *)header {
    
    NSLog(@"DifferDefineTest:%@",DifferDefineTest);
    NSLog(@"constString:%@",constString);
    NSLog(@"constTypeName:%@",constTypeName);
    
    [self changeAccountButtonClicked:@"changeAccountButtonClicked" closeAction:@"closeAction"];
}

- (void)changeAccountButtonClicked:(NSString *)string
                       closeAction:(NSString *)actionName {
    NSLog(@"%@",string);
    NSLog(@"%@",actionName);
    NSLog(@"%@",self.account);
    
    [self.differDelegate differMethod];
}



@end

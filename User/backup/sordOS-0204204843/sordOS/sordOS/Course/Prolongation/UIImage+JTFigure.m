







#import "UIImage+JTFigure.h"


@implementation UIImage (JTFigure)

+(UIImage *)imageWithName:(NSString *)name{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sordOS" ofType:@"framework"];
//    NSBundle *SDKBundle = [NSBundle bundleWithPath:path];
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",path,name]]];
    NSString *imagePath = [path stringByAppendingPathComponent:name];
//    NSString *image_path = [bundlePath stringByAppendingPathComponent:name];
    return  [[UIImage alloc] initWithContentsOfFile:imagePath];
}

@end

#import "AppDelegate.h"
#import <ApptraceSDK/ApptraceSDK.h>

@interface AppDelegate ()<ApptraceDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 禁用ApptraceSDK访问系统剪贴板，若禁用会影响匹配成功率
//    [Apptrace disableClipboard];
    
    [Apptrace initWithDelegate:self];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    return YES;
}

// UniversalLink
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    
    if ([Apptrace handleUniversalLink:userActivity]) {
        return YES;
    }
    return YES;
}

#pragma mark - ApptraceDelegate

- (void)handleWakeUp:(AppInfo * _Nullable)appData {
    if (appData != nil) {
        [self _showResultAlert:@"getWakeUpTrace Success" msg:appData.paramsData];
    } else {
        [self _showResultAlert:@"getWakeUpTrace" msg:@"Failed"];
    }
}

- (void)_showResultAlert:(NSString *)title msg:(NSString *)msg {
    NSString *alertMsg = [NSString stringWithFormat:@"param : %@", msg];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:alertMsg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:ok];
    [self.window.rootViewController presentViewController:alert animated:true completion:nil];
}

@end

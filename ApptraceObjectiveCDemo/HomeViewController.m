#import "HomeViewController.h"
#import <ApptraceSDK/ApptraceSDK.h>

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)getParamsAction:(id)sender {
    __weak typeof(self) weakSelf = self;
    
    [Apptrace getInstall:^(AppInfo * _Nullable appdata) {
        [weakSelf _showResultAlert:@"getInstallTrace Success" msg:appdata.paramsData];
    } fail:^(NSInteger code, NSString * _Nonnull message) {
        NSLog(@"Apptrace failed: code：%ld; message：%@", code, message);
        
        [weakSelf _showResultAlert:@"getInstallTrace Failed" msg:message];
    }];
}

- (void) _showResultAlert:(NSString*)title msg:(NSString*)msg {
    NSString *alertMsg = [NSString stringWithFormat:@"param : %@", msg];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:alertMsg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

@end

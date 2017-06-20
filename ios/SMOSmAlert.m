
#import "SMOSmAlert.h"
#import <UIKit/UIKit.h>

@implementation SMOSmAlert

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE()


      
RCT_EXPORT_METHOD(alertDefault:(NSDictionary *)params callback:(RCTResponseSenderBlock)callback)
{
  //alertDefault 实现, 需要回传结果用callback(@[XXX]), 数组参数里面就一个NSDictionary元素即可
    
    NSMutableArray *buttons = params[@"buttons"];
    NSString* _title = [params objectForKey:@"title"];
    NSString* _message = [params objectForKey:@"message"];
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:_title message:_message preferredStyle:UIAlertControllerStyleAlert];
    if(buttons.count == 0){
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            callback(@[@{@"index":[NSNumber numberWithDouble:-1]}]);
        }];
        [alertController addAction:otherAction];
    }else{
        for (int i = 0; i < buttons.count; i++) {
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:buttons[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                callback(@[@{@"index":[NSNumber numberWithDouble:i]}]);
            }];
            
            [alertController addAction:otherAction];
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    });
    
}

RCT_EXPORT_METHOD(alertBottom:(NSDictionary *)params callback:(RCTResponseSenderBlock)callback)
{
    NSMutableArray *buttons = params[@"buttons"];
    NSString* _title = [params objectForKey:@"title"];
    NSString* _message = [params objectForKey:@"message"];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:_title message:_message preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        callback(@[@{@"index":[NSNumber numberWithDouble:-1]}]);
    }];
    [alertController addAction:cancelAction];
    
    for (int i = 0; i < buttons.count; i++) {
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:buttons[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            callback(@[@{@"index":[NSNumber numberWithDouble:i]}]);
        }];
        
        [alertController addAction:otherAction];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *root = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        while (root.presentedViewController != nil) {
            root = root.presentedViewController;
        }
        
        /* On iPad, UIAlertController presents a popover view rather than an action sheet like on iPhone. We must provide the location
         of the location to show the popover in this case. For simplicity, we'll just display it on the bottom center of the screen
         to mimic an action sheet */
        alertController.popoverPresentationController.sourceView = root.view;
        alertController.popoverPresentationController.sourceRect = CGRectMake(root.view.bounds.size.width / 2.0, root.view.bounds.size.height, 1.0, 1.0);
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            alertController.popoverPresentationController.permittedArrowDirections = 0;
            for (id subview in alertController.view.subviews) {
                if ([subview isMemberOfClass:[UIView class]]) {
                    ((UIView *)subview).backgroundColor = [UIColor whiteColor];
                }
            }
        }
        
        [root presentViewController:alertController animated:YES completion:nil];
    });
}

@end
  

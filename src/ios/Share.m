/********* Share.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "UMSocial.h"

@interface Share : CDVPlugin <UMSocialUIDelegate>
- (void)share:(CDVInvokedUrlCommand*)command;
@end

@implementation Share

- (void)share:(CDVInvokedUrlCommand*)command
{
    NSDictionary* echo = [command.arguments objectAtIndex:0];
    
    NSString *type = [echo objectForKey:@"type"];
    
    NSString *string= [echo objectForKey:@"content"];
    
    
    
    if (!echo) {
        
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"无参数,调起分享失败!"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        
    }else{
        
        if ([type isEqualToString:@"WX"]) {
            
            NSString *appkey = [echo objectForKey:@"umAppKay"];
            [self wechatShareWithContent:string appKey:appkey];
            
            
        }
        else if ([type isEqualToString:@"QQ"]){
            
            NSString *appkey = [echo objectForKey:@"umAppKay"];
            
            
            [self qqShareWithContent:string appKey:appkey];
            
        }
        
        else if ([type isEqualToString:@"Sina"]){
            
            
            [self sinaShareWithContent:string];
        }
        
    }
    
}

- (void)wechatShareWithContent:(NSString *)content appKey:(NSString *)appkey{
    
    
    
    NSString *shareText = content;             //分享内嵌文字
    UIImage *shareImage = [UIImage imageNamed:@""];          //分享内嵌图片
    
    //    UIImage *shareImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"58x58" ofType:@"png"]];
    //调用快速分享接口
    [UMSocialSnsService presentSnsIconSheetView:self.viewController
                                         appKey:appkey
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline]
                                       delegate:self];
    
    
}


- (void)qqShareWithContent:(NSString *)content appKey:(NSString *)appKey{
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:content image:nil location:nil urlResource:nil presentedController:self.viewController completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
    
}


- (void)sinaShareWithContent:(NSString *)content{
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:content image:nil location:nil urlResource:nil presentedController:self.viewController completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
    
    
    
    
}


@end

//
//  WeixinManager.m
//  WeixinManager
//
//  Created by jessica on 2017/6/28.
//  Copyright © 2017年 jessica. All rights reserved.
//

#import "WeixinManager.h"

@implementation WeixinManager

RCT_EXPORT_MODULE()

- (instancetype)init
{
  self = [super init];
  if (self) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleOpenURL:) name:@"weixin_callback" object:nil];
  }
  return self;
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) handleOpenURL:(NSNotification *)note
{
  NSURL *url = note.object;
  NSLog(@"WeixinManager=======%@",url);
  if ([[url scheme] caseInsensitiveCompare:@"wxe3b8085a714877e9"] == NSOrderedSame) {
    NSLog(@"query====%@", url.query);
    NSString *query = url.query;
    NSArray *array = [query componentsSeparatedByString:@"&"];
    NSString *code = NULL;
    NSString *state = NULL;
    for(NSString *temp in array) {
      NSArray *a = [temp componentsSeparatedByString:@"="];
      if(a.count != 2)
        continue;
      if([@"code" caseInsensitiveCompare:a[0]] == NSOrderedSame) {
        code = a[1];
      }
      if([@"state" caseInsensitiveCompare:a[0]] == NSOrderedSame) {
        state = a[1];
      }
    }
    
    NSMutableDictionary *body = @{}.mutableCopy;
    body[@"code"] = code;
    body[@"state"] = state;
    [self sendEventWithName:@"Winxin_Resp" body:body];
  }
}

RCT_EXPORT_METHOD(login) {
    SendAuthReq* req =[[SendAuthReq alloc ] init ];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"69room" ;
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}

RCT_EXPORT_METHOD(installed:(RCTResponseSenderBlock)callback)
{
  callback(@[@([WXApi isWXAppInstalled])]);
}

-(NSArray<NSString *> *) supportedEvents {
  return @[@"Winxin_Resp"];
}

@end

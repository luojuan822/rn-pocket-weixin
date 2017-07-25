//
//  WeixinManager.h
//  WeixinManager
//
//  Created by jessica on 2017/6/28.
//  Copyright © 2017年 jessica. All rights reserved.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import "WXApiObject.h"
#import "WXApi.h"

@interface WeixinManager : RCTEventEmitter <RCTBridgeModule, WXApiDelegate>

@end

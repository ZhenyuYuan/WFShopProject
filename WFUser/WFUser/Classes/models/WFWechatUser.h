//
//  WFWechatUser.h
//  ADSRouter
//
//  Created by Andy on 2018/1/19.
//

#import <Foundation/Foundation.h>

/*
 {
 "openid":"OPENID",
 "nickname":"NICKNAME",
 "sex":1,
 "province":"PROVINCE",
 "city":"CITY",
 "country":"COUNTRY",
 "headimgurl": "http://wx.qlogo.cn/mmopen/g3MonUZtNHkdmzicIlibx6iaFqAc56vxLSUfpb6n5WKSYVY0ChQKkiaJSgQ1dZuTOgvLLrhJbERQQ4eMsv84eavHiaiceqxibJxCfHe/0",
 "privilege":[
 "PRIVILEGE1",
 "PRIVILEGE2"
 ],
 "unionid": " o6_bmasdasdsad6_2sgVt7hMZOPfL"
 
 }
 
 */

@interface WFWechatUser : NSObject

@property (nonatomic, copy) NSString *openId;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *headImgUrl;
@property (nonatomic, copy) NSString *unionId;

@end

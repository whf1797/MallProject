//
//  NSUserDefaultsExtension.swift
//  MallProject
//
//  Created by 张昭 on 2021/9/29.
//

import UIKit


/// 用户：token
let kdefaultToken: String = "token"
/// 用户：ID
let kdefaultUserUUID: String = "userUUID"
/// 用户：昵称
let kdefaultUserNickname: String = "nickName"
/// 用户：是否有手机号 0没有 1有
let kdefaultUserHasMobile: String = "hasMobile"
/// 用户：VIP登记
let kdefaultUserVipLevel: String = "vipLevel"
/// 用户VIP级数
let kdefaultUserLevel: String = "level"
/// 用户： 实名认证
let kdefaultUserIsIdentification = "isIdentification"
let kdefaultFirstLogin: String = "firstLogin"

/// 用户余额
let kDefaultBalance: String = "userBalance"
/// 用户头像
let kDefaultIcon: String = "userAvatar"
/// 用户手机号
let kDefaultPhone: String = "userPhone"
// 购买协议
let kDefaultPurchase: String = "purchaseAgreement"
//审核状态
let reviewTheStatus: String = "reviewTheStatus"
// 是否设置密码
let payPasswdStatus: String = "payPasswd"




extension NSNotification.Name {

    /// 修改抵扣金额
    static let ChangeDecMoney = Notification.Name("ChangeDecMoney")

    /// 课程目录，选择新的视频播放
    static let ChangeChapterVideo = Notification.Name("ChangeChapterVideo")
}

//
//  MALLocalizationTool.swift
//  MallProject
//
//  Created by 张昭 on 2021/9/29.
//

import UIKit

enum Language {
    case english
    case chinese
}

let KCurrentLanguageKey = "currentLanguage"

class MALLocalizationTool {

    static let shared = MALLocalizationTool()
    let defaults = UserDefaults.standard
    var bundle: Bundle?
    var currentLanguage: Language = .english

    func valueWithKey(key: String) -> String {
        let bundle = MALLocalizationTool.shared.bundle
        if let bundle = bundle {
            return NSLocalizedString(key, tableName: "Localizable", bundle: bundle, value: "", comment: "")
        } else {
            return NSLocalizedString(key, comment: "")
        }
    }

    func setLanguage(language: Language) {
        if currentLanguage == language {
            return
        }
        switch language {
        case .english:
            defaults.set("en", forKey: KCurrentLanguageKey)
        case .chinese:
            defaults.set("cn", forKey: KCurrentLanguageKey)
        }
        currentLanguage = getLanguage()
        p_resetRootViewController()
    }

    private func p_resetRootViewController() {

     
    }

    /// 当前语言是否默认语言
    func isSystemLanguage() -> Bool {
        let language = getLanguage()
        let systemLanguage = getSystemLanguage()
        if (systemLanguage == "en" && language == .english) || (systemLanguage == "zh-Hans" && language == .chinese) {
            return true
        } else {
            return false
        }
    }
    func checkLanguage() {
        currentLanguage = getLanguage()
    }

    private func getLanguage() -> Language {
        var str = ""
        if let language = defaults.value(forKey: KCurrentLanguageKey) as? String {
            str = language == "cn" ? "zh-Hans" : "en"
        } else {
            str = getSystemLanguage()
        }
        if let path = Bundle.main.path(forResource:str, ofType: "lproj") {
            bundle = Bundle(path: path)
        }
        return str == "en" ? .english : .chinese
    }

    private func getSystemLanguage() -> String {
        let preferredLang = Bundle.main.preferredLocalizations.first! as NSString
        switch String(describing: preferredLang) {
        case "en-US", "en-CN":
            return "en"
        case "zh-Hans-US", "zh-Hans-CN", "zh-Hant-CN", "zh-TW", "zh-HK", "zh-Hans":
            return "zh-Hans"
        default:
            return "en"
        }
    }

}

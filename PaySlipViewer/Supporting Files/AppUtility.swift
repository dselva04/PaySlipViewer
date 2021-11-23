//
//  AppUtility.swift
//  PaySlipViewer
//
//  Created by karthik on 23/11/21.
//

import Foundation
import UIKit

func setAppLanguage(language:String)  {
    UserDefaults.standard.set(language, forKey: KeyChain_AppLanguage)
    let defaults = UserDefaults(suiteName: "group.aw.setar.vendor.payawvendor")
    defaults?.set(language, forKey: "languageKey")
}

func getAppLanguage() ->String? {
    guard let language = UserDefaults.standard.string(forKey: KeyChain_AppLanguage) else{
        return nil
    }
    return language
}

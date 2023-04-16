//
//  Util.swift
//  assessment-ios
//
//  Created by Ivan Trejo on 15/04/23.
//

import Foundation

final class Util {
    static func version() -> String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
           let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            return "\(version) (\(build))"
        }
        return ""
    }
}

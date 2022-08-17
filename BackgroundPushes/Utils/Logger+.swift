//
//  Logger+.swift
//  BackgroundPushes
//
//  Created by Jaewon on 2022/08/17.
//

import Foundation
import OSLog

extension Logger {
    static let subsystem = Bundle.main.bundleIdentifier!
    
    static let test = Logger.init(subsystem: subsystem, category: "Test")
}
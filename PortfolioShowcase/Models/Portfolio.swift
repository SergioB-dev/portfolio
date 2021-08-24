//
//  Portfolio.swift
//  Portfolio
//
//  Created by Sergio Bost on 8/17/21.
//

import Foundation

struct Portfolio: Codable {
    let name: String
    let category: String
    let onAppStore: Bool
    let monthYear: String
    let hoursWorked: Int
    let frameworksUsed: [String]
    let team: String
}

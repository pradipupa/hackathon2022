//
//  Vehicle.swift
//  TestApp3
//
//  Created by user222240 on 6/26/22.
//

import Foundation

struct Vehicle: Identifiable, Codable {
    let id: UUID
    let desc: String
    let token: String
}

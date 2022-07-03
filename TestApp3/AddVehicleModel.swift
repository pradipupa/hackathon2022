//
//  AddVehicleForm.swift
//  TestApp3
//
//  Created by user222240 on 7/2/22.
//

import Foundation

struct BrokenRule: Identifiable {
    var id = UUID()
    let message: String
}

class AddVehicleModel: ObservableObject {
    var desc = ""
    var uuidString = ""
    var major = ""
    var minor = ""
    
    @Published var brokenRules = [BrokenRule]()
    
 
    func validate() -> Bool {
        
        brokenRules.removeAll()
        
        if desc.isEmpty {
            brokenRules.append(BrokenRule(message: "Vehicle Description is required."))
        }
        
        if uuidString.isEmpty {
            brokenRules.append(BrokenRule(message: "UUID is required."))
        }
        
        if major.isEmpty {
            brokenRules.append(BrokenRule(message: "Major is required."))
        }
        
        if minor.isEmpty {
            brokenRules.append(BrokenRule(message: "Minor is required."))
        }
        
        if UUID(uuidString: uuidString) == nil {
            brokenRules.append(BrokenRule(message: "UUID entered is NOT a valid UUID."))
        }
        
        return brokenRules.count == 0
        
    }
}





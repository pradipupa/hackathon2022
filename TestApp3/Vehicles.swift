//
//  Vehicles.swift
//  TestApp3
//
//  Created by user222240 on 6/26/22.
//

import Foundation

class Vehicles: ObservableObject {
    @Published var pairedVehicles = [Vehicle]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(pairedVehicles) {
                UserDefaults.standard.set(encoded, forKey: "savedVehicles")
            }
        }
    }
    
    @Published var availableToPairedVehicles = [AvailVehicle]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(availableToPairedVehicles) {
                UserDefaults.standard.set(encoded, forKey: "availableVehicles")
            }
        }
    }
    
    init() {
        if let savedVehicles = UserDefaults.standard.data(forKey: "savedVehicles") {
            if let decodedItems = try? JSONDecoder().decode([Vehicle].self, from: savedVehicles) {
                pairedVehicles = decodedItems
            } else {
                pairedVehicles = []
            }
        } else {
            pairedVehicles = []
        }
        
        if let availableVehicles = UserDefaults.standard.data(forKey: "availableVehicles") {
            if let decodedItems = try? JSONDecoder().decode([AvailVehicle].self, from: availableVehicles) {
                if decodedItems.isEmpty == false {
                    availableToPairedVehicles = decodedItems
                    return
                }
            }
        }
        let vehicleX = AvailVehicle(description: "Unknown Vehicle X")
        let vehicleY = AvailVehicle(description: "Unknown Vehicle Y")
        availableToPairedVehicles = [vehicleX, vehicleY]
        
    }
}

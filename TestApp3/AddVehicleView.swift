//
//  AddVehicle.swift
//  TestApp3
//
//  Created by user222240 on 6/26/22.
//

import SwiftUI

struct AddVehicleView: View {
    @ObservedObject var vehicles: Vehicles
    var currentUUID: UUID
    @Environment(\.dismiss) var dismiss
    
    @State private var desc = ""
    @State private var token = ""
    @State private var id = UUID()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Vehicle Description", text: $desc)
                TextField("Token", text: $token)
            }
            .navigationTitle("Add Vehicle")
            .toolbar {
                HStack {
                    Button("Save") {
                        let vehicle = Vehicle(id: currentUUID, desc: desc, token: token)
                        vehicles.pairedVehicles.append(vehicle)

                        let index: Int? = vehicles.availableToPairedVehicles.firstIndex(where: {$0.id == currentUUID})
                        vehicles.availableToPairedVehicles.remove(at: index!)
                        dismiss()
                    }
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        
        
    }
}

struct AddVehicle_Previews: PreviewProvider {
    static var previews: some View {
        AddVehicleView(vehicles: Vehicles(), currentUUID: UUID())
    }
}

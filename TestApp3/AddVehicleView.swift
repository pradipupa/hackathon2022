//
//  AddVehicle.swift
//  TestApp3
//
//  Created by user222240 on 6/26/22.
//

import SwiftUI

struct AddVehicleView: View {
    @ObservedObject var vehicles: Vehicles
    //@ObservedObject var detector: BeaconDetector
    @Environment(\.dismiss) var dismiss
    
    //@State private var addVehicleModel = AddVehicleModel()
    @ObservedObject private var addVehicleModel = AddVehicleModel()
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Vehicle Description", text: $addVehicleModel.desc)
                TextField("UUID", text: $addVehicleModel.uuidString)
                TextField("Major", text: $addVehicleModel.major)
                TextField("Minor", text: $addVehicleModel.minor)
            }
            .navigationTitle("Add Vehicle")
            .toolbar {
                HStack {
                    Button("Save") {
                        if addVehicleModel.validate() {
                            let vehicle = Vehicle(id: UUID.init(uuidString: addVehicleModel.uuidString)!, major: addVehicleModel.major, minor: addVehicleModel.minor, desc: addVehicleModel.desc)
                            vehicles.registeredVehicles.append(vehicle)
                            dismiss()
                        } else {
                            showingAlert = true
                        }
                    }
                    .alert("Erorr Encountered", isPresented: $showingAlert) {
                        Button("OK", role: .cancel){}
                    } message: {
                        ForEach(addVehicleModel.brokenRules, id: \.id) { brokenRule in
                            Text(brokenRule.message)
                        }
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
        AddVehicleView(vehicles: Vehicles())
    }
}

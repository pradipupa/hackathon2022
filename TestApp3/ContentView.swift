//
//  ContentView.swift
//  TestApp3
//
//  Created by user222240 on 6/26/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vehicles = Vehicles()
    @State private var showingAddVehicle = false
    
    
    var body: some View {
        var currentUUID = UUID()
        VStack {
            Image("logo")

            NavigationView {
                List {
                    Section(header: Text("Paired")) {                    ForEach(vehicles.pairedVehicles) { item in
                            HStack {
                                Text(item.desc)
                                Spacer()
                                Circle()
                                    .fill(.red)
                                    .frame(width: 20, height: 20)
                            
                            }
                        }
                        .onDelete(perform: removeVehicles)
                    }
                    
                    Section(header: Text("Ready to pair")) {
                        ForEach(vehicles.availableToPairedVehicles) { item in
                                HStack {
                                    Button {
                                        currentUUID = item.id
                                        showingAddVehicle = true
                                    } label: {
                                        HStack {
                                            Text(item.description)
                                            Spacer()
                                            Image(systemName: "plus")
                                        }
                                    }
                                    .padding()
                                
                                }
                        }
                    }
                    
                }
                .navigationTitle("Vehicls")
                .sheet(isPresented: $showingAddVehicle) {
                    AddVehicleView(vehicles: vehicles, currentUUID: currentUUID)
                }
            }
        }
    }
    
    func removeVehicles(at offsets: IndexSet) {
        offsets.forEach { (i) in
            let newVehicle = AvailVehicle(description:           vehicles.pairedVehicles[i].desc)
            vehicles.availableToPairedVehicles.append(newVehicle)
            
        }
        vehicles.pairedVehicles.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

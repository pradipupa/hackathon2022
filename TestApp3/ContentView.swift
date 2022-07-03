//
//  ContentView.swift
//  TestApp3
//
//  Created by user222240 on 6/26/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vehicles = Vehicles()
    @StateObject var detector = BeaconDetector()
    @State private var showingAddVehicle = false
    
    
    var body: some View {
        
        VStack {
            Image("logo")

            NavigationView {
                List {
                        ForEach(vehicles.registeredVehicles) { item in
                            HStack {
                                Text(item.desc)
                                Spacer()
                                Text("Status:")
                                //TODO: Here draw the color based on distance
                                //      detector.distance == .immediate
                                Circle()
                                    .fill(.red)
                                    .frame(width: 20, height: 20)                            
                            }
                        }
                        .onDelete(perform: removeVehicles)
                    
                    
/*                    Section(header: Text("Ready to pair")) {
                        ForEach(vehicles.availableToPairedVehicles) { item in
                                HStack {
                                    Button {                                        
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
 */
                }
                .navigationTitle("Registered Vehicls")
                .toolbar{
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            showingAddVehicle = true
                        } label: {
                                Image(systemName: "plus")
                        }
                        .padding()
                    }
                }
                .sheet(isPresented: $showingAddVehicle) {
                    AddVehicleView(vehicles: vehicles)
                }
            }
        }
    }
    
    func removeVehicles(at offsets: IndexSet) {
/*        offsets.forEach { (i) in
            let newVehicle = AvailVehicle(description:           vehicles.pairedVehicles[i].desc)
            vehicles.availableToPairedVehicles.append(newVehicle)
            
        }
 */
        vehicles.registeredVehicles.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  BeaconDetector.swift
//  TestApp3
//
//  Created by user222240 on 6/28/22.
//

import Foundation
import CoreLocation
import SwiftUI

class BeaconDetector: NSObject, ObservableObject, CLLocationManagerDelegate  {
    var locationManager: CLLocationManager?
    @Published var lastDistance = CLProximity.unknown
    
    //hardocde for now
    var uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
    var major: CLBeaconMajorValue = 123
    var minor: CLBeaconMinorValue = 456
    
    override init() {
        super.init()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()        
    }
    
    func locationManager(_ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // we can take action here
                    startScanning()
                }
            }
        }
    }
       
    func startScanning() {
        //hardocde for now
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let constraint = CLBeaconIdentityConstraint(uuid: uuid, major: major, minor: minor)
        
        let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: constraint, identifier: "MyBeacon")
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(satisfying: constraint)
    }
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        if let beacon = beacons.first {
            update(distance: beacon.proximity)
        } else {
            update(distance: .unknown)
        }
    }
    
    
    func update(distance: CLProximity) {
        lastDistance = distance
    }
    
}

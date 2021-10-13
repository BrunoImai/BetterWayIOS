//
//  File.swift
//  BetterWay
//
//  Created by Bruno Imai on 12/10/21.
//
import MapKit
import CoreLocation

protocol BetterWayDelegate {

    func createLocationManager( rangeDistance : Int) -> CLLocationManager
    
}

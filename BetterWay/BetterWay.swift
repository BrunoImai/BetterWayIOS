//
//  BetterWay.swift
//  BetterWay
//
//  Created by Bruno Imai on 12/10/21.
//

import Foundation
import MapKit
import CoreLocation
import CoreMotion

class BetterWay : BetterWayDelegate {
    
    // MAP FUNCTIONS
    func createLocationManager( rangeDistance : Int) -> CLLocationManager {
        
        let manager = CLLocationManager()
        manager.distanceFilter = CLLocationDistance(rangeDistance)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
            
    }
    
    func updateLocationOnMap(to location: CLLocation, with title: String?, mapView : MKMapView) {
    
        let point = addMarkOnMap(title: title, location: location)
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(point)
        
        let viewRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
        mapView.setRegion(viewRegion, animated: true)
    }
    
    func addMarkOnMap(title: String?, location: CLLocation) -> MKPointAnnotation {
        let point = MKPointAnnotation()
        point.title = title
        point.coordinate = location.coordinate
        return point
    }
    
    // ACCELEROMETER FUNCTIONS
    
    let motion = CMMotionManager()
    
    func getAccelX () -> Double {
        var xValue = 0.0
        motion.accelerometerUpdateInterval = 0.5
        motion.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            if let myData = data{
                xValue = myData.acceleration.x
            }
        }
        return xValue
    }
    
    func checkAccelX (max : Double, min : Double) -> Bool {
        var check = false
        
        motion.accelerometerUpdateInterval = 0.5
        motion.startAccelerometerUpdates(to: OperationQueue.current!){ (data, error) in
            if let myData = data{
                if ( myData.acceleration.x < max && myData.acceleration.x > min){
                     check = true
                }
            }
        }
        return check
    }
    
    func getAccelY () -> Double {
        var yValue = 0.0
        motion.accelerometerUpdateInterval = 0.5
        motion.startAccelerometerUpdates(to: OperationQueue.current!){ (data, error) in
            if let myData = data{
                yValue = myData.acceleration.y
            }
        }
        return yValue
    }
    
    func checkAccelY (max : Double, min : Double) -> Bool {
        var check = false
        
        motion.accelerometerUpdateInterval = 0.5
        motion.startAccelerometerUpdates(to: OperationQueue.current!){ (data, error) in
            if let myData = data{
                if ( myData.acceleration.y < max && myData.acceleration.y > min){
                     check = true
                }
            }
        }
        return check
    }
    
    func getAccelZ () -> Double {
        var zValue = 0.0
        motion.accelerometerUpdateInterval = 0.5
        motion.startAccelerometerUpdates(to: OperationQueue.current!){ (data, error) in
            if let myData = data{
                zValue = myData.acceleration.z
            }
        }
        return zValue
    }
    
    func checkAccelZ (max : Double, min : Double) -> Bool {
        var check = false
        
        motion.accelerometerUpdateInterval = 0.5
        motion.startAccelerometerUpdates(to: OperationQueue.current!){ (data, error) in
            if let myData = data{
                if ( myData.acceleration.z < max && myData.acceleration.z > min){
                     check = true
                }
            }
        }
        return check
    }
    
    func getAccelValues() -> [Double]{
        
        var values = [Double]()
        motion.accelerometerUpdateInterval = 0.5
        motion.startAccelerometerUpdates(to: OperationQueue.current!){ (data, error) in
            if let myData = data{
                values.append(myData.acceleration.x)
                values.append(myData.acceleration.y)
                values.append(myData.acceleration.z)
            }
        }
        return values
    }
    
    func checkAccelValues(max : Double, min : Double) -> Bool{
        var check = false
        
        motion.accelerometerUpdateInterval = 0.5
        motion.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            if let myData = data{
                if ( myData.acceleration.y < max && myData.acceleration.y > min && myData.acceleration.x < max && myData.acceleration.x > min && myData.acceleration.z < max && myData.acceleration.z > min
                ) {
                    check = true
                }
            }
        }
        return check
    }
    
    
}



extension CLLocation {
    
    func lookUpPlaceMark(_ handler: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
            
        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(self) { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                handler(firstLocation)
            }
            else {
                // An error occurred during geocoding.
                handler(nil)
            }
        }
    }
    
    func lookUpLocationName(_ handler: @escaping (String?) -> Void) {
            
        lookUpPlaceMark { (placemark) in
            handler(placemark?.thoroughfare)
        }
    }
}

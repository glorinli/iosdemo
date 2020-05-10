//
//  ViewController.swift
//  WhereAmI
//
//  Created by Glorin Li on 2020/5/9.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    private var previousPoint: CLLocation?
    private var totalMovementDistance = CLLocationDistance(0)
    
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var horizontalAccuracyLabel: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var verticalAccuracyLabel: UILabel!
    @IBOutlet var distanceTraveledLabel: UILabel!
    @IBOutlet var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("authrization status changed to \(status.rawValue)")
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
        default:
            locationManager.stopUpdatingLocation()
            mapView.showsUserLocation = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let errorType = error.localizedDescription
        let alertController = UIAlertController(title: "LocationManager Error", message: errorType, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: {action in})
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            latitudeLabel.text = String(format: "%g\u{00B0}", location.coordinate.latitude)
            longitudeLabel.text = String(format: "%g\u{00B0}", location.coordinate.longitude)
            horizontalAccuracyLabel.text = String(format: "%gm", location.horizontalAccuracy)
            
            altitudeLabel.text = String(format: "%gm", location.altitude)
            verticalAccuracyLabel.text = String(format: "%gm", location.verticalAccuracy)

            if location.horizontalAccuracy < 0 {
                return
            }
            
            if location.horizontalAccuracy > 100 || location.verticalAccuracy > 50 {
                return
            }
            
            if previousPoint == nil {
                totalMovementDistance = 0
                mapView.addAnnotation(Place(title: "Start position", subtitle: "This is where we started", coordinate: location.coordinate))
                mapView.setRegion(MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: 100, longitudinalMeters: 100), animated: true)
            } else {
                totalMovementDistance += location.distance(from: previousPoint!)
            }
            
            previousPoint = location
            distanceTraveledLabel.text = String(format: "%gm", totalMovementDistance)
        }
    }

}


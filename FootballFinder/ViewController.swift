//
//  ViewController.swift
//  FootballFinder
//
//  Created by 90304593 on 1/14/19.
//  Copyright © 2019 90304593. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var Label: UILabel!
    
    var userLat = 0.0
    var latDiff = 0.0
    
    var userLong = 0.0
    var longDiff = 0.0
    
let locationManager = CLLocationManager()

    var lats: [Double] = [41.53, 44.30, 33.27, 33.45, 39.17, 42.54, 35.14, 39.06, 41.30, 32.47, 39.43, 42.20, 29.46, 39.46, 30.20, 39.06, 25.46, 44.59, 42.21, 29.58, 40.43, 40.43, 37.47, 39.57, 40.26, 38.38, 32.43, 37.48 , 47.36, 27.57, 36.09, 38.54]
    var longs: [Double] = [-87.38, -88.01, -112.05, -84.23, -76.37, -78.53, -80.50, -84.31, -81.41, -96.48, -105.01, -83.03, -95.22, -86.09, -81.40, -94.37, -80.12, -93.13, -71.04, -90.07, -74.01, -74.01, -122.13, -75.07, -80.00, -90.11, -118.09, -122.24, -122.20, -82.27, -86.48, -77.01]
    var names: [String] = ["Chicago Bears", "Green Bay Packers", "Arizona Cardnials", "Atlanta Falcons", "Baltimore Ravens", "Buffalo Bills", "Carolina Panthers", "Cincinnati Bengals", "Cleveland Browns", "Dallas Cowboys", "Denver Broncos", "Detroit Lions", "Houston Texans", "Indianapolis Colts", "Jacksonville Jaguars", "Kansas City Chiefs", "Miami Dolphins", "Minnesota Vikings", "New England Patriots", "New Orleans Saints", "New York Giants", "New York Jets", "Oakland Raiders", "Philadelphia Eagles", "Pittsburgh Steelers", "St Louis Rams (now LA)", "San Diego Chargers", "San Fransisco 49ers", "Seattle Seahawks", "Tampa Buccaneers", "Tennessee Titans", "Washington Redskins"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
            determineMyCurrentLocation()
        }
    func determineMyCurrentLocation() {
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        
        userLat = userLocation.coordinate.latitude
        userLong = userLocation.coordinate.longitude
        
        print("user latitude = \(userLat)")
        print("user longitude = \(userLong)")
        printStuff()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    func printStuff(){
        var minDiff = 100000.0
        var shortIndex = -1
        
        for (i, _) in lats.enumerated(){
            latDiff = abs(userLat - lats[i])
            longDiff = abs(userLong - longs[i])
            if (latDiff + longDiff < minDiff){
                minDiff = latDiff + longDiff
                shortIndex = i
            }
            
        }
        
        print ("Lat: "+String(userLat)+" Long: "+String(userLong))
        print (names[shortIndex])
        Label.text = names[shortIndex]
        
    }


}


//
//  ViewController.swift
//  MapKit CoreLocation
//
//  Created by Yiying Yang on 10/9/15.
//  Copyright (c) 2015 Yiying Yang. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController,CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var locationDetail: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var Coordinate: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
            if error != nil{
                println("Error")
                return
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as! CLPlacemark
                self.displayLocation(pm)
            }
        })
        
        self.showAnnotation(manager.location)
    }
    
    func showAnnotation(location: CLLocation!){
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude), span: MKCoordinateSpanMake(0.05, 0.05)), animated: true)
        
        let locationPin = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationPin
        
        mapView.addAnnotation(annotation)
        mapView.showAnnotations([annotation], animated: true)
        Coordinate.text = "Latitude:\(location.coordinate.latitude); Longtitude: \(location.coordinate.longitude)"
        
    }
    
    func displayLocation(pm:CLPlacemark){
        self.locationManager.stopUpdatingLocation()
        let address = pm.locality + "," +  pm.administrativeArea + "," + pm.country + "," +  pm.postalCode
        self.locationDetail.text = address
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error")
    }
    
    @IBAction func updateLocation(sender: UIButton) {
        self.locationManager.startUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


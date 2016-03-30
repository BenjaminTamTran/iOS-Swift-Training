//
//  ViewController.swift
//  MapView
//
//  Created by tranquocsang on 3/29/16.
//  Copyright © 2016 tranquocsang. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    // set initial location in Honolulu
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!


    @IBAction func btnGoClicked(sender: AnyObject) {
        let latitude = Double(text1.text!)
        let longtitude = Double(text2.text!)
        let initialLocation = CLLocation(latitude: latitude!, longitude: longtitude!)
        centerMapOnLocation(initialLocation)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        
        centerMapOnLocation(initialLocation)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = initialLocation.coordinate
        annotation.title = "Big Ben"
        annotation.subtitle = "London"
        mapView.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let regionRadius: CLLocationDistance = 500
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                 regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapViewWillStartLoadingMap(mapView: MKMapView) {
        print("Starting load map")
    }
    
    func mapViewDidFinishLoadingMap(mapView: MKMapView) {
        print("Finish load map")
    }

}


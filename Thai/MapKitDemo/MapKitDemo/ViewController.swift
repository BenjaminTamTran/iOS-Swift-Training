//
//  ViewController.swift
//  MapKitDemo
//
//  Created by Nguyen Xuan Thai on 4/6/16.
//  Copyright © 2016 Thai. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    var destination: MKMapItem = MKMapItem()
    let locationManager = CLLocationManager()
    var myPosition = CLLocationCoordinate2D()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let myUniversity = MKCoordinateRegionMake(CLLocationCoordinate2D(latitude: 10.762689, longitude: 106.68234), MKCoordinateSpanMake(0.05, 0.05))
        mapView.setRegion(myUniversity, animated: true)
        cameraSetup()
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 10.762689, longitude: 106.68234)
        annotation.title = "Đại học khoa học tự nhiên"
        mapView.addAnnotation(annotation)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func cameraSetup() {
        mapView.camera.altitude = 1400
        mapView.camera.pitch = 90
        mapView.camera.heading = 180
    }
    @IBAction func segmentedControlChange(sender: AnyObject) {
        switch sender.selectedSegmentIndex {
            case 1:
                mapView.mapType = MKMapType.SatelliteFlyover
            case 2:
                mapView.mapType = MKMapType.HybridFlyover
            default:
                mapView.mapType = MKMapType.Standard
        }
        cameraSetup()
    }
    

    @IBAction func showTraffic(sender: AnyObject) {
        let request = MKDirectionsRequest()
        request.source = MKMapItem.mapItemForCurrentLocation()
        request.destination = destination
        request.requestsAlternateRoutes = false
        let direction = MKDirections(request: request)
        direction.calculateDirectionsWithCompletionHandler({response,error in
            let overlays = self.mapView.overlays
            self.mapView.removeOverlays(overlays)
            if error != nil {
                print("Error \(error)")
            } else {
                let overlays = self.mapView.overlays
                self.mapView.removeOverlays(overlays)
                let alert = UIAlertController(title: "Định tuyến", message: "Đường đi của bạn là ", preferredStyle: .Alert)
                for route in response!.routes {
                        self.mapView.addOverlay(route.polyline,
                            level: MKOverlayLevel.AboveRoads)
                        for step in route.steps {
                            alert.addTextFieldWithConfigurationHandler{(text: UITextField) -> Void in
                            text.text = step.instructions
                            }
                        }
                    let action = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
                    alert.addAction(action)
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
        })
    }
    
    @IBAction func showCompass(sender: AnyObject) {
        mapView.showsCompass = !mapView.showsCompass
        if mapView.showsCompass == true {
            sender.setTitle("Hide Compass", forState: .Normal)
        }else {
            sender.setTitle("Show Compass", forState: .Normal)
        }
    }
    
    @IBAction func longPressGestureRecognizer(sender: UILongPressGestureRecognizer) {
        let location = sender.locationInView(self.mapView)
        let loCoord = self.mapView.convertPoint(location, toCoordinateFromView: self.mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = loCoord
        let placeMark = MKPlacemark(coordinate: loCoord, addressDictionary: nil)
        destination = MKMapItem(placemark: placeMark)
        mapView.removeAnnotations(self.mapView.annotations)
        mapView.addAnnotation(annotation)
    }

    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let draw = MKPolylineRenderer(overlay: overlay)
        draw.strokeColor = UIColor.purpleColor()
        draw.lineWidth = 5.0
        return draw
    }
}


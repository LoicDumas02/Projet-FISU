//
//  ViewController.swift
//  FISU_application
//
//  Created by Arnaud ZARAGOZA on 22/02/2016.
//  Copyright © 2016 Arnaud ZARAGOZA. All rights reserved.
//

//https://www.raywenderlich.com/90971/introduction-mapkit-swift-tutorial

import UIKit
import MapKit


// controller for the map
class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapKitView: MKMapView!

    private var mapPrivate : Map? = nil

    
    var map : Map {
        get {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            return appDelegate.event!.map
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let initialLocation = CLLocation(latitude: 43.6109200, longitude: 3.8772300)
        self.centerMapOnLocation(initialLocation)
        self.mapKitView.delegate = self
        
        self.mapKitView.addAnnotations(map.placesAnnotation)
     
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 3500
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        self.mapKitView.setRegion(coordinateRegion, animated: true)
    }
    
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? PlaceAnnotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
            }
            
            view.pinTintColor = self.pinTintColor(annotation.type)
            return view
        }
        
        return nil
    }
    
    func pinTintColor(type : String) -> UIColor  {
        var color : UIColor
        switch type {
        case "Sport":
            color = UIColor.blueColor()
        case "Restaurant":
            color = UIColor.redColor()
        case "Conference place":
            color = UIColor.yellowColor()
        default:
            color = UIColor.purpleColor()
        }
        return color
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


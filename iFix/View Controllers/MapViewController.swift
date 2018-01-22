//
//  MapViewController.swift
//  
//
//  Created by Fahad Alharbi on 1/20/18.
//

import UIKit
import MapKit
import CoreLocation
class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @objc dynamic var annotation = MKAnnotationView()
    @IBOutlet weak var map: MKMapView!
    let regionRadius: CLLocationDistance = 1000
    let locationManager = CLLocationManager()
    var moveToUserLocation = false
    
    @IBAction func droppingPin(_ sender: UILongPressGestureRecognizer) {
        
    }

    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied, .restricted:
            //manager.requestAlwaysAuthorization()
            print("1")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            print("2")
        default:
            locationManager.startUpdatingLocation()
            self.map.showsUserLocation = true
            self.centerMapOnLocation(userLocation: map.userLocation)
            print("3")
        }
    }
    
    
    
    func centerMapOnLocation(userLocation : MKUserLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if !moveToUserLocation {
            mapView.region.center = mapView.userLocation.coordinate
            moveToUserLocation = true
            annotation.setSelected(true, animated: true)
            annotation.isDraggable = true
            //annotation.de
            //annotation.didChange(.insertion, valuesAt: .insertion, for: .)
            
        }
    }
    
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        map.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        //print("\(annotation.coordinate)")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

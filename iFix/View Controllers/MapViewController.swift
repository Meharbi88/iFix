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
    @IBOutlet weak var map: MKMapView!
    let locationManager = CLLocationManager()
    var moveToUserLocation = false
    @IBOutlet var longPress: UILongPressGestureRecognizer!
    var address : String = ""
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func backButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindAferGetLocation", sender: "")
    }
    
    @IBAction func droppingPin(_ sender: UILongPressGestureRecognizer) {
        let point = sender.location(in: self.map)
        let coordinate = self.map.convert(point, toCoordinateFrom: self.map)
        print(coordinate)
        //Now use this coordinate to add annotation on map.
        let annotation1 = CustomAnnotation(title: "Get This Location", locationName: "I am here", coordinate: coordinate)
        
        //Set title and subtitle if you want
        
        self.map.removeAnnotations(map.annotations)
        self.map.addAnnotation(annotation1)
    }

    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied, .restricted:
            manager.requestAlwaysAuthorization()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            locationManager.startUpdatingLocation()
            let location = locationManager.location?.coordinate
            let annotation = CustomAnnotation(title: "Get This Location", locationName: "You are here", coordinate: location!)
            let span = MKCoordinateSpanMake(0.0030, 0.0030)
            let region = MKCoordinateRegion(center: location!, span: span)
            map.setRegion(region, animated: true)
            self.map.addAnnotation(annotation)
            self.map.showsUserLocation = true
            
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? CustomAnnotation else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.isDraggable = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .contactAdd)
        }
        return view
    }
    
    
    
   func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        switch newState {
        case .starting:
            view.dragState = .dragging
        case .ending, .canceling:
            view.dragState = .none
        default: break
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! CustomAnnotation
        let clLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        getAddressAndUnwind(clLocation: clLocation)
    }
    
    func getAddressAndUnwind(clLocation: CLLocation){
        
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(clLocation, completionHandler: {(placemarks, error)->Void in
            
            var placemark:CLPlacemark!
                placemark = placemarks![0] as CLPlacemark
            
                    if placemark.subThoroughfare != nil {
                        self.address = placemark.subThoroughfare! + " "
                    }
                    if placemark.thoroughfare != nil {
                        self.address = self.address + placemark.thoroughfare! + ", "
                    }
                    if placemark.postalCode != nil {
                        self.address = self.address + placemark.postalCode! + " "
                    }
                    if placemark.locality != nil {
                        self.address = self.address + placemark.locality! + ", "
                    }
                    if placemark.administrativeArea != nil {
                        self.address = self.address + placemark.administrativeArea! + " "
                    }
                    if placemark.country != nil {
                        self.address = self.address + placemark.country!
                    }
            print(self.address)
            self.performSegue(withIdentifier: "unwindAferGetLocation", sender: self.address)
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        map.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        longPress.numberOfTouchesRequired = 1
        backButton.layer.cornerRadius = 15
        backButton.layer.borderColor = UIColor.lightGray.cgColor
        backButton.layer.borderWidth = 2
        map.addGestureRecognizer(longPress)
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

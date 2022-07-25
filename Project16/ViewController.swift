//
//  ViewController.swift
//  Project16
//
//  Created by Mehmet Can Şimşek on 25.07.2022.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Capital Cities"
        
       
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "map"), style: .plain, target: self, action: #selector(alert))
       
        
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = .cyan
        navigationController?.navigationBar.superview?.backgroundColor = .cyan
        
        let ankara = Capital(title: "Ankara", coordinate: CLLocationCoordinate2D(latitude: 39.9272, longitude: 32.8644), info: "")
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.50722, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotations([ankara, london, oslo, paris, rome, washington])
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }

        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.tintColor = .brown
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        }else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
        let placeInfo = capital.info
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.capitalTitle = placeName ?? ""
            vc.capitalİnfo = placeInfo
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @objc func alert() {
        let ac = UIAlertController(title: "Choose the map view", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Standart", style: .default, handler: { _ in
            self.mapView.mapType = MKMapType.standard
        }))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: { _ in
            self.mapView.mapType = MKMapType.hybrid
        }))
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: { _ in
            self.mapView.mapType = MKMapType.satellite
        }))
        ac.addAction(UIAlertAction(title: "Satellite Flyover", style: .default, handler: { _ in
            self.mapView.mapType = MKMapType.satelliteFlyover
        }))
        
        
        ac.addAction(UIAlertAction(title: "Cancel" , style: .cancel))
        present(ac, animated: true)
    }

}


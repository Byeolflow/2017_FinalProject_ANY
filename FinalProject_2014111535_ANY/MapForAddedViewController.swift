//
//  MapForAddedViewController.swift
//  FinalProject_2014111535_ANY
//
//  Created by SWUCOMPUTER on 2017. 12. 22..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapForAddedViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var mapView1: MKMapView!
    var Mlatitude: Double = 0
    var Mlongitude: Double = 0
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Mlatitude, Mlongitude
        let center = CLLocationCoordinate2D(latitude: CLLocationDegrees(Mlatitude), longitude: CLLocationDegrees(Mlongitude))
        
        //어떤 배율로 뿌려줄지 결정
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta:0.01, longitudeDelta:0.01))
      
        
       // print("\(Mlatitude)=latitude,\(Mlongitude)=longitude")
        
        mapView1.setRegion(region, animated: true)
 
    
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "HERE"
        mapView1.addAnnotation(annotation)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

//
//  SEVenuVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 08/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
import MapKit
class SEVenuVC: UIViewController {
    var index: Int?
    @IBOutlet weak var lblTitleOfProgram: UILabel!
    var eventObj : EventObject?
    var programObject : ProgramsObject?

    @IBOutlet weak var lblVenueTitle: UILabel!
    @IBOutlet weak var mapOfVenue: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitleOfProgram.text = eventObj?.event_title
        lblVenueTitle.text = programObject?.theme_desc

        let center = CLLocationCoordinate2D(latitude: DEVICE_LAT, longitude: DEVICE_LONG)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapOfVenue.setRegion(region, animated: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}

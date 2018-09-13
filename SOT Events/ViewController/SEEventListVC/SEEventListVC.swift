//
//  SEEventListVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 06/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper
import NVActivityIndicatorView

class SEEventListVC: UIViewController , NVActivityIndicatorViewable{
    @IBOutlet var tblView: UITableView!
    let size = CGSize(width: 60, height: 60)
    var responseObj: UserResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
     //   tblView.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "EventCell")
      
        tblView.tableFooterView = UIView()
        tblView.rowHeight = UITableViewAutomaticDimension
        tblView.estimatedRowHeight = UITableViewAutomaticDimension
        getTheEventOfUser()
    }

    
//
    
    func getTheEventOfUser(){
    
        let userId = localUserData.user_id
        let loginParam =  [ "user_id"         : "\(userId!)"
            
            ] as [String : Any]
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: EVENTAPI, isLoaderShow: false, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
            self.stopAnimating()
            
            self.responseObj = response as? UserResponse
            
            if self.responseObj?.success == 1 {
                self.tblView.delegate = self
                self.tblView.dataSource = self
                self.tblView.reloadDataWithAutoSizingCellWorkAround()

            }
            else
            {
                self.showAlert(title: "SOT Event", message: (self.responseObj?.message!)!, controller: self)
                
            }
            
            
        }, fail: { (error) in
            self.showAlert(title: "SOT Events", message:error.description  , controller: self)
            self.stopAnimating()
            
        }, showHUD: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func btnSideMenu_Pressed(_ sender: UIButton) {
        self.revealController.show(self.revealController.leftViewController)

    }
    

}

extension SEEventListVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if  self.responseObj?.result?.event?.isEmpty == false {
            numOfSections = 1
            tblView.backgroundView = nil
        }
        else {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tblView.bounds.size.width, height: tblView.bounds.size.height))
            noDataLabel.numberOfLines = 10
            if let aSize = UIFont(name: "Axiforma-Book", size: 14) {
                noDataLabel.font = aSize
            }
            noDataLabel.text = "There are currently no data."
            noDataLabel.textColor = UIColor(red: 119.0 / 255.0, green: 119.0 / 255.0, blue: 119.0 / 255.0, alpha: 1.0)
            noDataLabel.textAlignment = .center
            tblView.backgroundView = noDataLabel
            tblView.separatorStyle = .none
        }
        return numOfSections
//            return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (self.responseObj?.result?.event?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventCell

        cell?.lblEventName.text = self.responseObj?.result?.event![indexPath.row].event_title
        cell?.lblTitleOfEvent.text = self.responseObj?.result?.event![indexPath.row].event_title
        if self.responseObj?.result?.event![indexPath.row].location?.count == 0 {
            cell?.lblAddress.text = " "
        } else {
            let locationName = self.responseObj?.result?.event![indexPath.row].location![0].location_name
            let cityName = self.responseObj?.result?.event![indexPath.row].location![0].city_name
            cell?.lblAddress.text = "\(locationName!) \(cityName!)"
        }
      
        cell?.lblEventDate.text = self.responseObj?.result?.event![indexPath.row].display_date

        
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEEventDetailVC") as? SEEventDetailVC
        vc?.eventObj = self.responseObj?.result?.event![indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  139
    }

}

extension UITableView {
    func reloadDataWithAutoSizingCellWorkAround() {
        self.reloadData()
        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.reloadData()
    }
}

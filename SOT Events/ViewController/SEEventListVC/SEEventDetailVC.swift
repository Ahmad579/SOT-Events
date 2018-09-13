//
//  SEEventDetailVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 07/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SEEventDetailVC: UIViewController , NVActivityIndicatorViewable {
    @IBOutlet var tblView: UITableView!
    var eventObj : EventObject?
    let size = CGSize(width: 60, height: 60)
    var responseProgramTime: UserResponse?
    
    var isFirstDate : [ProgramsObject]?
    var isSecondDate : [ProgramsObject]?
    var responseObj: UserResponse?

    var firstDateCheck : String?
    var secondDateCheck : String?

    
    let items = ["PROGRAMME" , "SPEAKERS" , "MY SESSIONS" , "HAPPENINGS" ,"INFORMATION DESK" , "FULL STEAM", "EVALUATION" , "SOT TEAM"]
    let subDetail = ["Schedule for my registerd sessions" , "Updated News" , "Get directions,FAQ,ask a question" , "IT exihibits" ,"Event Feedback" , "Team Information"]

    override func viewDidLoad() {
        super.viewDidLoad()
        isFirstDate = []
        isSecondDate = []
        tblView.register(UINib(nibName: "DashboardHeaderCell", bundle: nil), forCellReuseIdentifier: "DashboardHeaderCell")
        tblView.register(UINib(nibName: "DashboardCell", bundle: nil), forCellReuseIdentifier: "DashboardCell")
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.tblView.reloadDataWithAutoSizingCellWorkAround()
        getTheProgramOfUser()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    func getTheProgramOfUser(){
        
        let userId = localUserData.user_id
        let eventId = eventObj?.event_id
        let loginParam =  [ "user_id"         : "\(userId!)" ,
                            "event_id"        :  eventId!
            
            ] as [String : Any]
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: PROGRAME, isLoaderShow: false, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
            self.stopAnimating()
            self.responseObj = response as? UserResponse
//            let saveData = NSKeyedArchiver.archivedDataWithRootObject(self.responseObj)
//            let myData = NSKeyedArchiver.archivedData(withRootObject: self.responseObj!)
//            UserDefaults.standard.set(myData, forKey: "places")

            if self.responseObj?.success == 1 {
                self.firstDateCheck = self.responseObj?.result?.programSelect![0].activity_date
                
                if self.firstDateCheck != nil {
                    for (_ , objOfProgram) in (self.responseObj?.result?.programSelect?.enumerated())! {
                        
                        if objOfProgram.activity_date == self.firstDateCheck {
                            self.isFirstDate?.append(objOfProgram)
                        }
                        else {
                            self.secondDateCheck = objOfProgram.activity_date
                            
                            if objOfProgram.activity_date == self.secondDateCheck {
                                self.isSecondDate?.append(objOfProgram)
                            }
                            
                        }
                        
                    }
                }

//                self.tblView.delegate = self
//                self.tblView.dataSource = self
//                self.tblView.reloadDataWithAutoSizingCellWorkAround()
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
    
    
    func getTheEventOfUser(){
        
        let userId = localUserData.user_id
        let eventId = eventObj?.event_id
        let loginParam =  [ "user_id"         : "\(userId!)" ,
                            "event_id"        :  eventId!
            
            ] as [String : Any]
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: PROGRAMTIME_WISE, isLoaderShow: false, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
            self.stopAnimating()
            
            self.responseProgramTime = response as? UserResponse
            
            if self.responseProgramTime?.success == 1 {
                
            }
            else
            {
                self.showAlert(title: "SOT Event", message: (self.responseProgramTime?.message!)!, controller: self)
                
            }
            
            
        }, fail: { (error) in
            self.showAlert(title: "SOT Events", message:error.description  , controller: self)
            self.stopAnimating()
            
        }, showHUD: true)
        
    }
    
    @IBAction func btnBAck_Pressed(_ sender: UIButton) {
            self.navigationController?.popViewController(animated: true)
    }
}

extension SEEventDetailVC : UITableViewDelegate , UITableViewDataSource {
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
        //            return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return 1
        } else {
            return items.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardHeaderCell", for: indexPath) as? DashboardHeaderCell
            cell?.lblTitleOfEvent.text = eventObj?.event_title
            
            return cell!

        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardCell", for: indexPath) as? DashboardCell

            let titleOfProgram = self.items[indexPath.row]
            cell?.lblTitleOfHeading.text = titleOfProgram


            if indexPath.row == 0 {
                cell?.lblSubtitle.text = eventObj?.session_tagline
            } else if indexPath.row == 1 {
                cell?.lblSubtitle.text = eventObj?.speaker_tagline
            } else {
                let title = self.subDetail[indexPath.row - 2]
                cell?.lblSubtitle.text = title
            }
            
            
            
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEProgrammVC") as? SEProgrammVC
                vc?.eventObj = self.eventObj
                vc?.responseObj = self.responseObj
                vc?.isFirstDate = self.isFirstDate
                vc?.isSecondDate = self.isSecondDate
                
                self.navigationController?.pushViewController(vc!, animated: true)
            } else if indexPath.row == 1 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SESpeakerVC") as? SESpeakerVC
                vc?.eventObj = self.eventObj
                vc?.responseObj = self.responseObj

                self.navigationController?.pushViewController(vc!, animated: true)
            } else if indexPath.row == 2 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEChatVC") as? SEChatVC
                
                self.navigationController?.pushViewController(vc!, animated: true)

            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 121.0
        }  else {
            return 80.0
        }
    }
    
}

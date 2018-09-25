//
//  SEEventDetailVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 07/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Alamofire

class SEEventDetailVC: UIViewController , NVActivityIndicatorViewable {
    @IBOutlet var tblView: UITableView!
    var eventObj : EventObject?
    var eventOffline : EventModel?

    let size = CGSize(width: 60, height: 60)
    var responseProgramTime: UserResponse?
    
    var isFirstDate : [ProgramsObject]?
    var isSecondDate : [ProgramsObject]?
    
    var isOfflineFirstDate : [ProgramModel]?
    var isOfflineSecondDate : [ProgramModel]?

    var responseObj: UserResponse?

    var firstDateCheck : String?
    var secondDateCheck : String?
    
    var  programThread : ProgramModel?
    var  programParticpant : Participation?

    var  arrayOfProgram : NSArray?

    
    let items = ["PROGRAMME" , "SPEAKERS" , "MY SESSIONS" , "HAPPENINGS" ,"INFORMATION DESK" , "FULL STEAM", "EVALUATION" , "SOT TEAM"]
    let itemImage = ["program" , "microphone" , "program" , "happenings" ,"informationDesk" , "fullsteam", "evaluation" , "team"]

    let subDetail = ["Schedule for my registerd sessions" , "Updated News" , "Get directions,FAQ,ask a question" , "IT exihibits" ,"Event Feedback" , "Team Information"]

    override func viewDidLoad() {
        super.viewDidLoad()
        isFirstDate = []
        isSecondDate = []
        isOfflineFirstDate = []
        isOfflineSecondDate = []
        
        tblView.register(UINib(nibName: "DashboardHeaderCell", bundle: nil), forCellReuseIdentifier: "DashboardHeaderCell")
        tblView.register(UINib(nibName: "DashboardCell", bundle: nil), forCellReuseIdentifier: "DashboardCell")
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.tblView.reloadDataWithAutoSizingCellWorkAround()
        if Connectivity.isConnectedToInternet() {
            getTheProgramOfUser()

        } else {
            arrayOfProgram = ProgramModel.fetchAll() as NSArray?
            let objOfProgram = self.arrayOfProgram![0] as? ProgramModel
            self.firstDateCheck = objOfProgram?.activity_date
        

            if self.firstDateCheck != nil {
                
                for (index , _) in (arrayOfProgram?.enumerated())! {
                    
                    let program = self.arrayOfProgram![index] as? ProgramModel

                    
                    if program?.activity_date == self.firstDateCheck {
                        self.isOfflineFirstDate?.append(program!)
                    }
                    else {
                        self.secondDateCheck = program?.activity_date
                        
                        if program?.activity_date == self.secondDateCheck {
                            self.isOfflineSecondDate?.append(program!)
                        }
                        
                    }
                    
                }
            }
        }
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
        let idOfUser = UserDefaults.standard.integer(forKey: "id")

//        let userId = localUserData.user_id
        let eventId = eventObj?.event_id
        let loginParam =  [ "user_id"         : "\(idOfUser)" ,
                            "event_id"        :  eventId!
            
            ] as [String : Any]
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: PROGRAME, isLoaderShow: false, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
            self.stopAnimating()
            self.responseObj = response as? UserResponse

            if self.responseObj?.success == 1 {
                self.firstDateCheck = self.responseObj?.result?.programSelect![0].activity_date
                self.storeProgramOffline(program: self.responseObj!)

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
    
    func storeProgramOffline(program : UserResponse) {
     
        for (_ , obj) in (program.result?.programSelect?.enumerated())! {
            
            arrayOfProgram = ProgramModel.fetchAll() as NSArray?
            let resultPredicate = NSPredicate(format: "schedule_id == %@", obj.schedule_id!)
            let arrayOfFilter = arrayOfProgram?.filtered(using: resultPredicate)
            
            if (arrayOfFilter?.count)! > 0 {
                
            } else {
                
                programThread = ProgramModel.create() as? ProgramModel
//                programParticpant = Participation.create() as? Participation
                programThread?.event_id = obj.event_id
                programThread?.schedule_id = obj.schedule_id
                programThread?.user_id = obj.user_id
                programThread?.poll_exists = obj.poll_exists
                programThread?.poll_active = obj.poll_active
                programThread?.poll_submitted = obj.poll_submitted
                programThread?.evaluation_exists = obj.evaluation_exists
                programThread?.evaluation_active = obj.evaluation_active
                programThread?.evaluation_submitted = obj.evaluation_submitted
                programThread?.attendance = obj.attendance
                programThread?.activity_type_id = obj.activity_type_id
                programThread?.activity_id = obj.activity_id
                programThread?.activity_title = obj.activity_title
                programThread?.activity_date = obj.activity_date
                programThread?.abstract = obj.abstract
                programThread?.start_time = obj.start_time
                programThread?.end_time = obj.end_time
                programThread?.inactive_status = obj.inactive_status
                programThread?.day_session = obj.day_session
                programThread?.display_date = obj.display_date
                programThread?.location_id = obj.location_id
                programThread?.theme_id = obj.theme_id
                programThread?.theme_desc = obj.theme_desc
                
                
                for(_ , objCheck) in (obj.participant?.enumerated())! {
                    let particpant = NSEntityDescription.insertNewObject(forEntityName: "Participation", into: PAStorageHelper.managedObjectContext()) as! Participation

                    particpant.participant_id = objCheck.participant_id
                    particpant.participant_name = objCheck.participant_name
                    particpant.participant_photo = objCheck.participant_photo
                    particpant.designation = objCheck.designation
                    particpant.profile_desc = objCheck.profile_desc
                    particpant.role_id = objCheck.role_id
                    particpant.role_desc = objCheck.role_desc
                    particpant.gender = objCheck.gender
                    particpant.linkedin_url = objCheck.linkedin_url
                    particpant.twitter_url = objCheck.twitter_url
                    particpant.sub_designation = objCheck.sub_designation ?? " "
                    particpant.experties = objCheck.experties ?? " "
                    particpant.linkedin_url = objCheck.linkedin_url ?? " "
                    particpant.twitter_url = objCheck.twitter_url ?? " "
//                    programThread?.addToParticipantInProgram(particpant)
//                    programThread?.addToParticipantInProgram(particpant)
                    programThread?.addToParticipantInProgram(particpant)
                }
                
                programThread?.venue_id = obj.venue_id
                programThread?.venue_title = obj.venue_title
                programThread?.allow_register = obj.allow_register
                ProgramModel.save()
            }
            
            
            
        }
    }
    
    func getTheEventOfUser(){
        
        let idOfUsers = UserDefaults.standard.string(forKey: "id")
        
        let userId = idOfUsers
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
            let imageName = self.itemImage[indexPath.row]
            cell?.imgeOfTile?.image  = UIImage(named: imageName)

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
                
                if Connectivity.isConnectedToInternet() {
                    vc?.eventObj = self.eventObj
                    vc?.responseObj = self.responseObj
                    vc?.isFirstDate = self.isFirstDate
                    vc?.isSecondDate = self.isSecondDate

                } else {
                    vc?.eventObjOffline = self.eventOffline
                    vc?.isOfflineFirstDate = self.isOfflineFirstDate
                    vc?.isOfflineSecondDate = self.isOfflineSecondDate
                    
                }
                
                self.navigationController?.pushViewController(vc!, animated: true)
            } else if indexPath.row == 1 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SESpeakerVC") as? SESpeakerVC
                vc?.eventObj = self.eventObj
                vc?.responseObj = self.responseObj

                self.navigationController?.pushViewController(vc!, animated: true)
            } else if indexPath.row == 2 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEChatVC") as? SEChatVC
                
                self.navigationController?.pushViewController(vc!, animated: true)

            } else if indexPath.row == 3 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEHappeningVC") as? SEHappeningVC
                vc?.eventObj = self.eventObj

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

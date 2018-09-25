//
//  SEProgrammVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 07/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Alamofire

class SEProgrammVC: UIViewController  , NVActivityIndicatorViewable {
    
    var programTime : ProgramsTimeObject?
    @IBOutlet var tblView: UITableView!
    let size = CGSize(width: 60, height: 60)
    var eventObj : EventObject?
    
    var eventObjOffline : EventModel?

    
    var activityTypeMenu: NIDropDown?
    var dimensionTypeMenu: NIDropDown?
    var venueTypeMenu: NIDropDown?
    var timeSlotTypeMenu: NIDropDown?
    
    var activityTypeArray: [String]? = []
    var dimensionArray: [String]? = []
    var venueArray: [String]? = []
    var timeSlotArray: [String]? = []
    
    
    
    @IBOutlet weak var lblDate: UILabel!

    
    var selectedActivity : String?
    @IBOutlet weak var viewOfFilter: UIView!
    @IBOutlet weak var lblActivitySelect: UILabel!
    @IBOutlet weak var lblDimensionSelect: UILabel!
    @IBOutlet weak var lblVenueSelect: UILabel!
    @IBOutlet weak var lbltimeSlotSelect: UILabel!
    
    var isFirstDate : [ProgramsObject]?
    var isSecondDate : [ProgramsObject]?
    var responseObj: UserResponse?
    
    var isOfflineFirstDate : [ProgramModel]?
    var isOfflineSecondDate : [ProgramModel]?

    
    @IBOutlet weak var btnActivityType: UIButton!
    @IBOutlet weak var btnDimensionType: UIButton!
    @IBOutlet weak var btnVenueType: UIButton!
    @IBOutlet weak var btnTimeSlotType: UIButton!
    
    var isActivityTypeSelect : Bool?
    var isDimensionTypeSelect : Bool?
    var isVenueTypeSelect : Bool?
    var isTimeSlotTypeSelect : Bool?
    
    var isDay1Select : Bool?
    
    let eventTimeArray = ["All" , "Morning" , "Afternoon" , "Evening"]
    
    @IBOutlet weak var btnDay1: UIButton!
    @IBOutlet weak var btnDay2: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        isDay1Select = true
        
        tblView.register(UINib(nibName: "ProgramHeaderCell", bundle: nil), forCellReuseIdentifier: "ProgramHeaderCell")
        btnDay1.isSelected = true
        btnDay2.isSelected = false
        btnDay1.backgroundColor = UIColor(red: 64/255.0, green: 84/255.0, blue: 178/255.0, alpha: 1.0)
        btnDay2.backgroundColor = UIColor.white
        
        if Connectivity.isConnectedToInternet() {
            lblDate.text = eventObj?.event_title
            if isFirstDate?.count != 0 {
                tblView.delegate = self
                tblView.dataSource = self
                tblView.reloadData()
            }
            else if isSecondDate?.count != 0 {
                tblView.delegate = self
                tblView.dataSource = self
                tblView.reloadData()
            }
        } else {
            lblDate.text = eventObjOffline?.event_title
            if isOfflineFirstDate?.count != 0 {
                tblView.delegate = self
                tblView.dataSource = self
                tblView.reloadData()
            }
            else if isOfflineSecondDate?.count != 0 {
                tblView.delegate = self
                tblView.dataSource = self
                tblView.reloadData()
            }
        }
        
      
        
//        for (_ , scheduleData) in (eventObj?.activityType?.enumerated())!{
//            activityTypeArray?.append(scheduleData.activity_desc!)
//        }
//        for (_ , scheduleData) in (eventObj?.eventDimention?.enumerated())!{
//            dimensionArray?.append(scheduleData.theme_desc!)
//        }
//        for (_ , scheduleData) in (eventObj?.eventVenue?.enumerated())!{
//            venueArray?.append(scheduleData.venue_title!)
//        }
    }

    @IBAction func btnActivityType(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        
        //        if sender.isSelected
        //        {
        
        
        if activityTypeMenu == nil {
            activityTypeMenu = NIDropDown()
            //            categoryMenu?.tag = 100
            activityTypeMenu?.backgroundColor = UIColor.white
            activityTypeMenu?.delegate = self
            
        }
        var ht: CGFloat = 250.0
        isTimeSlotTypeSelect = false
        isVenueTypeSelect = false
        isDimensionTypeSelect = false
        isActivityTypeSelect = true
        dimensionTypeMenu?.hide(sender)
        timeSlotTypeMenu?.hide(sender)
        venueTypeMenu?.hide(sender)
        
        _ = activityTypeMenu?.show(sender , &ht, activityTypeArray, [], "down")
        
        //        }
        //        else
        //        {
        //            activityTypeMenu?.hide(sender)
        //        }
        
    }
    
    @IBAction func btnDimension_Pressed(_ sender: UIButton) {
        //        sender.isSelected = !sender.isSelected
        
        
        
        if dimensionTypeMenu == nil {
            dimensionTypeMenu = NIDropDown()
            //            categoryMenu?.tag = 100
            dimensionTypeMenu?.backgroundColor = UIColor.white
            dimensionTypeMenu?.delegate = self
            
        }
        var ht: CGFloat = 200.0
        isTimeSlotTypeSelect = false
        isVenueTypeSelect = false
        isDimensionTypeSelect = true
        isActivityTypeSelect = false
        activityTypeMenu?.hide(sender)
        timeSlotTypeMenu?.hide(sender)
        venueTypeMenu?.hide(sender)
        
        _ = dimensionTypeMenu?.show(sender , &ht, dimensionArray, [], "down")
        
        //        }
        //        else
        //        {
        //            dimensionTypeMenu?.hide(sender)
        //        }
        
    }
    
    @IBAction func btnVenueArray(_ sender: UIButton) {
        //        sender.isSelected = !sender.isSelected
        
        
        //        if sender.isSelected
        //        {
        if venueTypeMenu == nil {
            venueTypeMenu = NIDropDown()
            //            categoryMenu?.tag = 100
            venueTypeMenu?.backgroundColor = UIColor.white
            venueTypeMenu?.delegate = self
            
        }
        var ht: CGFloat = 200.0
        isTimeSlotTypeSelect = false
        isVenueTypeSelect = true
        isDimensionTypeSelect = false
        isActivityTypeSelect = false
        
        dimensionTypeMenu?.hide(sender)
        activityTypeMenu?.hide(sender)
        timeSlotTypeMenu?.hide(sender)
        _ = venueTypeMenu?.show(sender , &ht, venueArray, [], "down")
        
        //        }
        //        else
        //        {
        //            venueTypeMenu?.hide(sender)
        //        }
        
    }
    
    @IBAction func btnTimeSlot_Pressed(_ sender: UIButton) {
        //        sender.isSelected = !sender.isSelected
        //
        //
        //        if sender.isSelected
        //        {
        if timeSlotTypeMenu == nil {
            timeSlotTypeMenu = NIDropDown()
            timeSlotTypeMenu?.backgroundColor = UIColor.white
            timeSlotTypeMenu?.delegate = self
            
        }
        
        isTimeSlotTypeSelect = true
        isVenueTypeSelect = false
        isDimensionTypeSelect = false
        isActivityTypeSelect = false
        
        dimensionTypeMenu?.hide(sender)
        activityTypeMenu?.hide(sender)
        venueTypeMenu?.hide(sender)
        var ht: CGFloat = 200.0
        _ = timeSlotTypeMenu?.show(sender , &ht, eventTimeArray, [], "down")
        
        //        }
        //        else
        //        {
        //            timeSlotTypeMenu?.hide(sender)
        //        }
        
    }
    
    
    @IBAction func btnApplyFilter_Pressed(_ sender: UIButton) {
//        viewOfFilter.isHidden = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getThePrograms() {
        
    }
    
    @IBAction func btnDay1_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
      
        btnDay1.isSelected = true
        btnDay2.isSelected = false
        btnDay1.backgroundColor = UIColor(red: 64/255.0, green: 84/255.0, blue: 178/255.0, alpha: 1.0)
        btnDay2.backgroundColor = UIColor.white
        isDay1Select = true
        tblView.reloadData()
    }
    
    @IBAction func btnDay2_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected

        btnDay2.isSelected = true
        btnDay1.isSelected = false
        btnDay2.backgroundColor = UIColor(red: 64/255.0, green: 84/255.0, blue: 178/255.0, alpha: 1.0)
        btnDay1.backgroundColor = UIColor.white

        isDay1Select = false
        tblView.reloadData()
        
    }
    
    @IBAction func btnBAck_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSideMenu_Pressed(_ sender: UIButton) {
        self.revealController.show(self.revealController.leftViewController)
        
    }
}

extension SEProgrammVC : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return 1
        } else {
            
            
            if isDay1Select == true {
                if Connectivity.isConnectedToInternet() {
                    return (isFirstDate?.count)!

                } else {
                    return (isOfflineFirstDate?.count)!
                }
            } else {
                
                if Connectivity.isConnectedToInternet() {
                    return (isSecondDate?.count)!

                } else {
                    return (isOfflineSecondDate?.count)!
                }
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProgramHeaderCell", for: indexPath) as? ProgramHeaderCell
            if Connectivity.isConnectedToInternet() {
                cell?.lblDisplayDate.text = self.eventObj?.eventDate![indexPath.row].event_display_date
            } else {
                cell?.lblDisplayDate.text = self.eventObjOffline?.display_date
            }
            return cell!
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProgrammCell", for: indexPath) as? ProgrammCell
            
            if Connectivity.isConnectedToInternet() {
                if isDay1Select == true  {
                    cell?.lblActivity_title.text = self.isFirstDate![indexPath.row].activity_title
                    cell?.lblActivity_desc.text = self.isFirstDate![indexPath.row].activity_desc
                    cell?.lblDisplay_date.text = self.isFirstDate![indexPath.row].display_date
                    cell?.lblVenue_title.text = self.isFirstDate![indexPath.row].venue_title
                    cell?.delegate = self
                    cell?.index = indexPath
                    cell?.participation = self.isFirstDate![indexPath.row].participant
                    cell?.collectionViewCell.reloadData()
                }else {
                    cell?.lblActivity_title.text = self.isSecondDate![indexPath.row].activity_title
                    cell?.lblActivity_desc.text = self.isSecondDate![indexPath.row].activity_desc
                    cell?.lblDisplay_date.text = self.isSecondDate![indexPath.row].display_date
                    cell?.lblVenue_title.text = self.isSecondDate![indexPath.row].venue_title
                    cell?.delegate = self
                    cell?.index = indexPath
                    
                    cell?.participation = self.isSecondDate![indexPath.row].participant
                    cell?.collectionViewCell.reloadData()
                }
            } else {
                
                if isDay1Select == true  {
                    let objOfDay1 = self.isOfflineFirstDate![indexPath.row] as ProgramModel
                    cell?.lblActivity_title.text = objOfDay1.activity_title
                    cell?.lblActivity_desc.text = objOfDay1.activity_desc
                    cell?.lblDisplay_date.text = objOfDay1.display_date
                    cell?.lblVenue_title.text = objOfDay1.venue_title
                    cell?.delegate = self
                    cell?.index = indexPath
                    let orderedPlayers = objOfDay1.participantInProgram?.allObjects as? [Participation]
                    cell?.participationOffline = orderedPlayers
                    cell?.collectionViewCell.reloadData()
                }else {
                    let objOfDay2 = self.isOfflineSecondDate![indexPath.row] as ProgramModel

                    cell?.lblActivity_title.text = objOfDay2.activity_title
                    cell?.lblActivity_desc.text = objOfDay2.activity_desc
                    cell?.lblDisplay_date.text = objOfDay2.display_date
                    cell?.lblVenue_title.text = objOfDay2.venue_title
                    cell?.delegate = self
                    cell?.index = indexPath
                  
                    let orderedPlayers = objOfDay2.participantInProgram?.allObjects as? [Participation]
                    cell?.participationOffline = orderedPlayers

//                    cell?.participation = self.isSecondDate![indexPath.row].participant
                    cell?.collectionViewCell.reloadData()
                }
            }
            
         
            
            return cell!
            
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SESessionDetailVC") as? SESessionDetailVC
        if Connectivity.isConnectedToInternet() {
            if isDay1Select == true {
                vc?.programObject = self.isFirstDate![indexPath.row]
                vc?.responseObj = self.responseObj
            } else {
                vc?.programObject = self.isSecondDate![indexPath.row]
                vc?.responseObj = self.responseObj
                
            }
            //        vc?.programObject = self.responseObj?.result?.programSelect![indexPath.row]
            vc?.eventObj = self.eventObj

        } else {
            if isDay1Select == true {
                vc?.programModel = self.isOfflineFirstDate![indexPath.row]
//                vc?.responseObj = self.responseObj
            } else {
                vc?.programModel = self.isOfflineSecondDate![indexPath.row]
//                vc?.responseObj = self.responseObj
                
            }
            //        vc?.programObject = self.responseObj?.result?.programSelect![indexPath.row]
            vc?.eventOffline = self.eventObjOffline
        }
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 52.0
        }  else {
            return 197.0
        }
    }
    
}

extension SEProgrammVC: NIDropDownDelegate {
    
    func niDropDownDelegateMethod(_ sender: NIDropDown!, _ string: String!, _ selectIndex: Int) {
        if  isActivityTypeSelect == true {
            lblActivitySelect.text = string
            self.activityTypeMenu?.hide(btnActivityType)
        } else if isDimensionTypeSelect == true {
            lblDimensionSelect.text = string
            self.dimensionTypeMenu?.hide(btnActivityType)
            
        } else if isVenueTypeSelect == true {
            lblVenueSelect.text = string
            self.venueTypeMenu?.hide(btnActivityType)
            
        } else if isTimeSlotTypeSelect == true {
            lbltimeSlotSelect.text = string
            self.timeSlotTypeMenu?.hide(btnActivityType)
            
        }
    }
    
}

extension SEProgrammVC : SpeakerDetail {
    func registerUserForProgram(cell: ProgrammCell, indexCheck: IndexPath) {
//
        let idOfUser = UserDefaults.standard.integer(forKey: "id")
        let schedule_id : String?
        let activity_date : String?

        if isDay1Select == true {
           schedule_id = self.isFirstDate![indexCheck.row].schedule_id
            activity_date = self.isFirstDate![indexCheck.row].activity_date
        } else {
            schedule_id = self.isSecondDate![indexCheck.row].schedule_id
            activity_date = self.isSecondDate![indexCheck.row].activity_date

        }
        let loginParam =  [ "user_id"            : "\(idOfUser)" ,
                            "schedule_id"        :  schedule_id! ,
                            "activity_date"      : activity_date!
                          ] as [String : Any]
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: REGISTERUSERPROGRAM, isLoaderShow: false, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
            self.stopAnimating()
            let  responseObj = response as? UserResponse
            if responseObj?.success == 1 {
                self.showAlert(title: "SOT Event", message: (responseObj?.message!)!, controller: self)
            }
            
            else
            {
                self.showAlert(title: "SOT Event", message: (responseObj?.message!)!, controller: self)
                
            }
            
            
        }, fail: { (error) in
            self.showAlert(title: "SOT Events", message:error.description  , controller: self)
            self.stopAnimating()
            
        }, showHUD: true)

        
    }
    
    
    func selectSpeaker(cell : ProgrammCell , indexCheck : IndexPath , participant : ParticipationObject) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SESpeakerProfile") as? SESpeakerProfile
        vc?.eventObj = self.eventObj
        
        if isDay1Select == true {
            vc?.participant = participant
            vc?.responseObj = self.responseObj
        } else {
            vc?.participant = participant
            vc?.responseObj = self.responseObj
            
        }
        //        vc?.programObject = self.responseObj?.result?.programSelect![indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
    
    
}

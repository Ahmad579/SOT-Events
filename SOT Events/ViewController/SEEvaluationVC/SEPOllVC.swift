
//
//  SEPOllVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 27/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SEPOllVC: UIViewController , NVActivityIndicatorViewable {
 
    @IBOutlet var tblView: UITableView!
    @IBOutlet weak var lblEventTitle: UILabel!
    @IBOutlet weak var lblProgramTitle: UILabel!

    var responseObj : Session?
    let size = CGSize(width: 60, height: 60)
    
    var eventObj : EventObject?
    var programObject : ProgramsObject?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        lblEventTitle.text = eventObj?.event_title
        lblProgramTitle.text = programObject?.activity_title

        tblView.register(UINib(nibName: "SEEvaluationHeaderCell", bundle: nil), forCellReuseIdentifier: "SEEvaluationHeaderCell")
        tblView.register(UINib(nibName: "SEOptionCell", bundle: nil), forCellReuseIdentifier: "SEOptionCell")
        getThePollOfUser()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnSideMenu_Pressed(_ sender: UIButton) {
        self.revealController.show(self.revealController.leftViewController)
        
    }

    func getThePollOfUser(){
        
        //        let userId = localUserData.user_id
        let idOfUsers = UserDefaults.standard.string(forKey: "id")
        let scheduleID = programObject?.schedule_id!
        let eventId = eventObj?.event_id!
        
        let loginParam =  [ "schedule_id"      : "174",
                            "user_id"          : "42637"
            
            ] as [String : Any]
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: PROGRAMPOLL, isLoaderShow: false, serviceType: "Poll", modelType: Session.self, success: { (response) in
            self.stopAnimating()
            
            self.responseObj = response as? Session
            
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

}

extension SEPOllVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?   {
        
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "SEEvaluationHeaderCell") as! SEEvaluationHeaderCell
        headerCell.lblQuestion.text = responseObj?.result?.pollEvaluation?.pollQuestionObject?.sessionQuestion![section].question_desc
        
        return headerCell.contentView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (responseObj?.result?.pollEvaluation?.pollQuestionObject?.sessionQuestion?.count)!
        //        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (responseObj?.result?.pollEvaluation?.pollQuestionObject?.sessionQuestion![section].option?.count)!
        //        return (responseObj?.result?.sessionEvaluation?.sessionQuestion![section].option?.count)!
        //            return 2
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cell: SEOptionCell? = tableView.dequeueReusableCell(withIdentifier: "SEOptionCell") as! SEOptionCell?
        if cell == nil {
            cell = SEOptionCell(style: .default, reuseIdentifier: "SEOptionCell")
        }
        cell?.lblOption.text = responseObj?.result?.pollEvaluation?.pollQuestionObject?.sessionQuestion![indexPath.section].option![indexPath.row].option_desc
        return cell!
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 63.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 44.0
    }
    
    
    
}
//
//  SESessionDetailVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 07/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit

class SESessionDetailVC: UIViewController {
    @IBOutlet var tblView: UITableView!
    var programObject : ProgramsObject?
    var isReadMorePressed : Bool?
    var eventObj : EventObject?
    var responseObj: UserResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: "ParticipationListCell", bundle: nil), forCellReuseIdentifier: "ParticipationListCell")
        isReadMorePressed = false
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.tblView.reloadDataWithAutoSizingCellWorkAround()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBAck_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension SESessionDetailVC : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return 1
        } else {
            return (programObject?.participant?.count)!
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SessionDetailCell", for: indexPath) as? SessionDetailCell
//            cell?.lblDisplayDate.text = self.eventObj?.eventDate![indexPath.row].event_display_date
            cell?.lblActivity_title.text = programObject?.activity_title
            cell?.lblActivity_desc.text = programObject?.activity_desc
            cell?.lblDisplay_date.text = programObject?.display_date
            cell?.lblVenue_title.text = programObject?.venue_title
            cell?.lblDetail.text = programObject?.abstract
            cell?.delegae = self
            cell?.index = indexPath

            return cell!
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipationListCell", for: indexPath) as? ParticipationListCell
            
            WAShareHelper.loadImage(urlstring: (programObject?.participant![indexPath.row].participant_photo)! , imageView: (cell?.imgOfUser)!, placeHolder: "rectangle_placeholder")
            cell?.lblNameOfParticipant.text = programObject?.participant![indexPath.row].participant_name
            cell?.lblDesignation.text = programObject?.participant![indexPath.row].designation
            return cell!
            
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SESpeakerProfile") as? SESpeakerProfile
            vc?.responseObj = self.responseObj
            vc?.participant = self.programObject?.participant![indexPath.row]
            vc?.eventObj = self.eventObj
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            if isReadMorePressed == true {
               return UITableViewAutomaticDimension
            } else {
                return 279.0
            }
        }  else {
            return 62.0
        }
    }
    
}

extension SESessionDetailVC : ReadMore {
    
    func readMoreButtonPressed(cell : SessionDetailCell , index : IndexPath) {
        if isReadMorePressed == false {
            isReadMorePressed = true
            cell.btnReadMore.setTitle("Read More", for: .normal)

            let indexPath = IndexPath(item: 0, section: 0)
            tblView.reloadRows(at: [indexPath], with: .none)

        } else {
            isReadMorePressed = false
            cell.btnReadMore.setTitle("Less", for: .normal)
            let indexPath = IndexPath(item: 0, section: 0)
            tblView.reloadRows(at: [indexPath], with: .none)

        }
      
    }
    
    func AskQuestion(cell: SessionDetailCell, index: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEAskQuestionMainVC") as? SEAskQuestionMainVC
        vc?.eventObj = eventObj
        vc?.programObject = programObject
        self.navigationController?.pushViewController(vc!, animated: true)
    }

}

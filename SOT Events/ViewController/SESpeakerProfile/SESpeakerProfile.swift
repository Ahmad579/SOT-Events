//
//  SESpeakerProfile.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 08/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit

class SESpeakerProfile: UIViewController {

    @IBOutlet var tblView: UITableView!
    var responseObj: UserResponse?
    var userParticipantProgram : [ProgramsObject]?
    var participant  : ParticipationObject?
    var eventObj : EventObject?

    override func viewDidLoad() {
        super.viewDidLoad()

        userParticipantProgram = []
        
        for (_ , objOfProgram) in (self.responseObj?.result?.programSelect?.enumerated())! {
            
            for (_, particpantUser) in (objOfProgram.participant?.enumerated())! {
                
                if participant?.participant_id == particpantUser.participant_id {
                    userParticipantProgram?.append(objOfProgram)
                }
            }
            
        }
        
        
        tblView.delegate = self
        tblView.dataSource = self
        tblView.reloadData()

    }
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
}

extension SESpeakerProfile : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else {
            return (userParticipantProgram?.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpeakerProfileCell", for: indexPath) as? SpeakerProfileCell
               cell?.lblUserName.text = participant?.participant_name
               cell?.lblDesignation.text = participant?.designation
               cell?.lblDetail.text = participant?.profile_desc
            WAShareHelper.loadImage(urlstring: (participant?.participant_photo)! , imageView: (cell?.lblUserProiflePic)!, placeHolder: "rectangle_placeholder")

            
            return cell!
        }else if indexPath.section == 1  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventDate", for: indexPath) as? SpeakerProfileCell
            cell?.lblEventTitle.text = eventObj?.event_title
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProgrammCell", for: indexPath) as? ProgrammCell
            cell?.lblActivity_title.text = userParticipantProgram![indexPath.row].activity_title
            cell?.lblActivity_desc.text = userParticipantProgram![indexPath.row].activity_desc
            cell?.lblDisplay_date.text = userParticipantProgram![indexPath.row].display_date
            cell?.lblVenue_title.text = userParticipantProgram![indexPath.row].venue_title
            
            cell?.participation = userParticipantProgram![indexPath.row].participant
            cell?.collectionViewCell.reloadData()

            return cell!
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return UITableViewAutomaticDimension
        }  else if indexPath.section == 1 {
            return 49.0
        } else {
            return 190.0
        }
    }
    
}

//
//  SEAskQuestionVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 08/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit

class SEAskQuestionVC: UIViewController {
    var index: Int?
    @IBOutlet weak var lblTitle: UILabel!
    var eventObj : EventObject?
    @IBOutlet weak var lblProgramTitle: UILabel!
    
    @IBOutlet weak var txtWriteYourQuestion: UITextView!
    var programObject : ProgramsObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = eventObj?.event_title
        lblProgramTitle.text =  programObject?.activity_desc
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSubmit_Pressed(_ sender: UIButton) {
//        https://ws.beams.beaconhouse.net/viiontech/sotevents/index.php/api/event_ask_question
//    event_id
//        question_title
//        question_detail
    
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

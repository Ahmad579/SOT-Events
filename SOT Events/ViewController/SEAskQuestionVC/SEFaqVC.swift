//
//  SEFaqVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 08/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit

class SEFaqVC: UIViewController {
    var index: Int?
    @IBOutlet weak var lblTitleOfProgram: UILabel!
    var eventObj : EventObject?
    var programObject : ProgramsObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitleOfProgram.text = eventObj?.event_title

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

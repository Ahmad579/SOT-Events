//
//  SEForgotPasswordVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 06/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit

class SEForgotPasswordVC: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.setLeftPaddingPoints(10)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSubmit_Pressed(_ sender: UIButton) {
        
    }


    @IBAction func btnBack_Pressed(_ sender: UIButton) {
            self.navigationController?.popViewController(animated: true)
        
    }
}

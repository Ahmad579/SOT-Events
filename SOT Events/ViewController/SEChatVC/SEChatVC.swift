//
//  SEChatVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 12/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class SEChatVC: JSQMessagesViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let rightArrow : UIView = UIView.init(frame: CGRect (x : 0 , y : 0 , width : 100 , height : 100))
        self.senderId = localUserData.user_id
        self.senderDisplayName = localUserData.first_name
        let leftbtn = UIButton(type: .custom)
        leftbtn.setImage(UIImage(named: "back_icon"), for: .normal)
        leftbtn.imageView?.contentMode = .scaleAspectFit
        leftbtn.inputView?.tintColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
        leftbtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        leftbtn.addTarget(self, action: #selector(SEChatVC.back_Pressed), for: .touchUpInside)
        let leftITem = UIBarButtonItem(customView: leftbtn)
        self.navigationItem.setLeftBarButtonItems([leftITem], animated: true)
        var navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.barTintColor =  #colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.6980392157, alpha: 1)
        // Do any additional setup after loading the view.
    }
    
    @objc func back_Pressed() {
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }

    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
    }

}

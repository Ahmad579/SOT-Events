//
//  SELeftSieMenuVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 06/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit

class SELeftSieMenuVC: UIViewController {
    @IBOutlet var tblView: UITableView!
    let accountInfoArray   = ["MY ACCOUNT", "MY NETWORK", "QR CODE" , "TBT" , "ABOUT" , "TERMS AND CONDITIONS" , "SETTINGS" , "LOGOUT"]
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        tblView.register(UINib(nibName: "UserInfoCell", bundle: nil), forCellReuseIdentifier: "UserInfoCell")
        tblView.register(UINib(nibName: "AccountInfo", bundle: nil), forCellReuseIdentifier: "AccountInfo")
        tblView.register(UINib(nibName: "EventAppVersionCell", bundle: nil), forCellReuseIdentifier: "EventAppVersionCell")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
extension SELeftSieMenuVC : UITableViewDelegate , UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return 1
        } else if section == 1 {
            return accountInfoArray.count
        } else {
            return 1

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoCell", for: indexPath) as? UserInfoCell
            let firstName = localUserData.first_name
            let lastName = localUserData.last_name
            
            cell?.lblNAme.text = "\(firstName!) \(lastName!)"
            return cell!
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountInfo", for: indexPath) as? AccountInfo
            let accountTitle = self.accountInfoArray[indexPath.row]
            cell?.lblAccountInfo.text = accountTitle
            
            return cell!
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventAppVersionCell", for: indexPath) as? EventAppVersionCell
            
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            WAShareHelper.goToHomeController(vcIdentifier: "SEEventListVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "SELeftSieMenuVC")

        }
        else if indexPath.section == 1 {
            if indexPath.row == 0 {
                WAShareHelper.goToHomeController(vcIdentifier: "SEAccountInfoVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "SELeftSieMenuVC")

            } else if indexPath.row == 4 {
                WAShareHelper.goToHomeController(vcIdentifier: "SEAboutVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "SELeftSieMenuVC")
            } else if indexPath.row == 2 {
                appDelegate.isSideMenu = true
                WAShareHelper.goToHomeController(vcIdentifier: "SEQRCodeVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "SELeftSieMenuVC")
                
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return  131.0
        } else if indexPath.section == 1 {
            return  50.0
            
        } else {
              return  89.0
        }
      
    }
    
}

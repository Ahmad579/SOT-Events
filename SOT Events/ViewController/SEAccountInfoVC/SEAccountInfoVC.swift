//
//  SEAccountInfoVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 07/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit

class SEAccountInfoVC: UIViewController {

    @IBOutlet weak var imgOfUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var lblUserId: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    let photoPicker = PhotoPicker()
    var cover_image: UIImage?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate


    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let userImage = localUserData.image
        
        lblUserName.text = localUserData.first_name
        lblUserId.text = localUserData.user_id
        lblEmail.text = localUserData.email
        lblMobile.text = localUserData.phone
        let tapGestureRecognizerforDp = UITapGestureRecognizer(target:self, action:#selector(SEAccountInfoVC.imageTappedForDp(img:)))
        imgOfUser.isUserInteractionEnabled = true
        imgOfUser.addGestureRecognizer(tapGestureRecognizerforDp)
        
        guard let imge = localUserData.image else {
            return
        }
        WAShareHelper.loadImage(urlstring: imge , imageView: imgOfUser!, placeHolder: "rectangle_placeholder")

        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func imageTappedForDp(img: AnyObject)
    {
        photoPicker.pick(allowsEditing: false, pickerSourceType: .CameraAndPhotoLibrary, controller: self) { (orignal, edited) in
            
            self.imgOfUser.image = orignal
            let cgFloat: CGFloat = self.imgOfUser.frame.size.width/2.0
            let someFloat = Float(cgFloat)
            WAShareHelper.setViewCornerRadius(self.imgOfUser, radius: CGFloat(someFloat))
            self.cover_image = orignal
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func btnSideMenu_Pressed(_ sender: UIButton) {
        
         self.revealController.show(self.revealController.leftViewController)
    }
    
    @IBAction func btnMyNetwork_Pressed(_ sender: UIButton) {
        
    }
    @IBAction func btnEditProfile_Pressed(_ sender: UIButton) {
        
    }
    
    @IBAction func btnContribution_Pressed(_ sender: UIButton) {
        
    }
    
    @IBAction func btnQRCode_Pressed(_ sender: UIButton) {
        appDelegate.isSideMenu = false
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEQRCodeVC") as? SEQRCodeVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnSettings_Pressed(_ sender: UIButton) {
        
    }
    
    @IBAction func btnChangePAssword_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEChangePasswordVC") as? SEChangePasswordVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnLogout_Pressed(_ sender: UIButton) {
        
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

//
//  SELoginVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 06/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import DatePickerDialog

class SELoginVC: UIViewController   , NVActivityIndicatorViewable{
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    let size = CGSize(width: 60, height: 60)
    var cover_image: UIImageView?
    
    @IBOutlet weak var imgOfBackground: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.setLeftPaddingPoints(5)
        txtPass.setLeftPaddingPoints(5)
        let idOfUser = UserDefaults.standard.integer(forKey: "id")
//        let idOfUsers = UserDefaults.standard.string(forKey: "id")

        if idOfUser == 0  {

        } else {
            WAShareHelper.goToHomeController(vcIdentifier: "SEEventListVC", storyboardName: "Home", navController: self.navigationController!, leftMenuIdentifier: "SELeftSieMenuVC")

        }

        txtEmail.text = "ahmaddurranitrg@gmail.com"
        txtPass.text  = "123456789"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    
    
    @IBAction func btnSignIn_Pressed(_ sender: UIButton) {
      

        let loginParam =  [ "email"         : txtEmail.text!,
                            "password"       : txtPass.text!

            ] as [String : Any]
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)


        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: LOGIN, isLoaderShow: false, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
            
            let responseObj = response as! UserResponse
            
//
            if responseObj.success == 1 {
                
                
                localUserData = responseObj.result?.userInfo
                UserDefaults.standard.set(self.txtEmail.text! , forKey: "email")
                UserDefaults.standard.set(self.txtPass.text! , forKey: "password")
                UserDefaults.standard.set(localUserData.user_id , forKey: "id")
                UserDefaults.standard.set(localUserData.participant_id , forKey: "participant_id")
                UserDefaults.standard.set(localUserData.first_name , forKey: "first_name")
                UserDefaults.standard.set(localUserData.last_name , forKey: "last_name")
                UserDefaults.standard.set(localUserData.date_of_birth , forKey: "date_of_birth")
                UserDefaults.standard.set(localUserData.phone , forKey: "phone")
                UserDefaults.standard.set(localUserData.image , forKey: "image")
                UserDefaults.standard.set(localUserData.qrcode , forKey: "qrcode")
                UserDefaults.standard.set(localUserData.gender , forKey: "gender")
                let updateTokenParam =  [ "user_id"           : localUserData.user_id!,
                                    "manufacture"       : "iOS" ,
                                    "token"             : "dsddf",
                                    "manufacturer"      : "Apple" ,
                                    "model"             : "Apple" ,
                                    "platform"          : "iOS" ,
                                    "serial"            : "no serial" ,
                                    "uuid"              : "iOS_id" ,
                                    "version"           : "12.0" ,
                                    "status"            : "A"
                    
                    ] as [String : Any]
                
                
                WebServiceManager.post(params: updateTokenParam as Dictionary<String, AnyObject> , serviceName: INSERTUSERDEVICE, isLoaderShow: false, serviceType: "insert_user_device", modelType:  UserResponse.self, success: { (response) in
                    self.stopAnimating()

                    if responseObj.success == 1 {
                        WAShareHelper.goToHomeController(vcIdentifier: "SEEventListVC", storyboardName: "Home", navController: self.navigationController!, leftMenuIdentifier: "SELeftSieMenuVC")

                    } else {
                        self.showAlert(title: "SOT Event", message: responseObj.message!, controller: self)
                    }

                    
                }, fail: { (error) in
                    
                }, showHUD: true)
            }
            else
            {
                self.showAlert(title: "SOT Event", message: responseObj.message!, controller: self)

            }


        }, fail: { (error) in
            self.showAlert(title: "SOT Events", message:error.description  , controller: self)
            self.stopAnimating()

        }, showHUD: true)
        

    }
    
    
    @IBAction func btnFacebook_Pressed(_ sender: UIButton) {
    //    let facebookMangager = SocialMediaManager()
     //   facebookMangager.facebookSignup(self)
      //  facebookMangager.successBlock = { (response) -> Void in
        //    self.signupWebservice(response as! Dictionary)
        //}
    }
    
    func signupWebservice(_ params: Dictionary<String, String>) {
        
        
        let email : String?
        let idOfFb : String?
        let firstName : String?
        let lastName  : String?
        let gender  : String?
        let phonenumber : String?
        let deviceType  : String?
        let deviceToken : String?
        let image : String?
        email =  params["data[User][email]"]
        image = params["data[User][picture]"]

        idOfFb =  params["data[User][facebook_id]"]
        firstName =  params["data[User][first_name]"]
        lastName  = params["data[User][last_name]"]
        deviceType  = params["data[Device][device_type]"]
        
        
        WAShareHelper.loadImage(urlstring: (image)! , imageView: (imgOfBackground)!, placeHolder: "rectangle_placeholder")

            let currentDate = Date()
            var dateComponents = DateComponents()
            dateComponents.month = 1970
            let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        
            let datePicker = DatePickerDialog(textColor: .black,
                                              buttonColor: .black,
                                              font: UIFont.boldSystemFont(ofSize: 17),
                                              showCancelButton: true)
        
            //        01/09/2017
            datePicker.show("DatePickerDialog",
                            doneButtonTitle: "Done",
                            cancelButtonTitle: "Cancel",
                            minimumDate: threeMonthAgo,
                            maximumDate: currentDate,
                            datePickerMode: .date) { (date) in
                                if let dt = date {
                                    let formatter = DateFormatter()
                                    formatter.dateFormat = "dd-MM-yyyy"
//                                    print(self.imgOfBackground.image)
                                    let dateValue = formatter.string(from: dt)
                                    
                                    let param =      ["email"                    :  email!  ,
                                                       "first_name"               :  firstName! ,
                                                       "last_name"                :  lastName! ,
                                                       "phone"                    :  "+923350957876" ,
                                                       "gender"                   :  "M",
                                                       "date_of_birth"            :  dateValue ,
                                                       "login_with"               : "Facebook"
                                        ] as [String : Any]
                                    
                                    WebServiceManager.multiPartImage(params: param as Dictionary<String, AnyObject> , serviceName: SIGNUP, imageParam:"image.png", serviceType: "Sign Up", profileImage: self.imgOfBackground.image, cover_image_param: "", cover_image: nil , modelType: UserResponse.self, success: { (response) in
                                        
                                        
                                        let responseObj = response as! UserResponse
                                        
                                        
                                        if responseObj.success == 1 {
                                            localUserData = responseObj.result?.userInfo
                                            WAShareHelper.goToHomeController(vcIdentifier: "SEEventListVC", storyboardName: "Home", navController: self.navigationController!, leftMenuIdentifier: "SELeftSieMenuVC")

                                            
                                            
                                        }
                                        else
                                        {
                                            self.showAlert(title: "SOT Event", message: responseObj.message!, controller: self)
                                            
                                        }
                                        
                                    }) { (error) in
                                        
                                        
                                    }

                                    
                                    
                                    
                                }
            }
        }
    
//        WAShareHelper.loadImage(urlstring:userImage! , imageView: (self.userImage)!, placeHolder: "logo_grey")

//
//        ["email"                    :  txtEmail.text!  ,
//         "password"                 :  txtPass.text! ,
//         "first_name"               :  txtFirstName.text! ,
//         "last_name"                :  txtLastName.text!,
//         "phone"                    :  txtMobileNumber.text! ,
//         "gender"                   :  "M",
//         "date_of_birth"            :  "01/09/2017"

    
    
    
    @IBAction func btnGooglePlus_Pressed(_ sender: UIButton) {
        
    }
    
    @IBAction func btnForgot_Password_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEForgotPasswordVC") as? SEForgotPasswordVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func btnCreateAccount_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SESignUpVC") as? SESignUpVC
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    @IBAction func btnTermAndConditon_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SETermConditionVC") as? SETermConditionVC
        self.navigationController?.pushViewController(vc!, animated: true)

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

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}

//
//  SESignUpVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 06/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
import DatePickerDialog

class SESignUpVC: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtConfirmPass: UITextField!
    @IBOutlet weak var btnChooseDate: UIButton!

    @IBOutlet var profilePic: UIImageView!
    let photoPicker = PhotoPicker()
    var cover_image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        
        setUpUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpUI(){
       
        txtEmail.setLeftPaddingPoints(10)
        txtPass.setLeftPaddingPoints(10)
        txtFirstName.setLeftPaddingPoints(10)
        txtLastName.setLeftPaddingPoints(10)
        txtMobileNumber.setLeftPaddingPoints(10)
        txtConfirmPass.setLeftPaddingPoints(10)

        let tapGestureRecognizerforDp = UITapGestureRecognizer(target:self, action:#selector(SESignUpVC.imageTappedForDp(img:)))
        profilePic.isUserInteractionEnabled = true
        profilePic.addGestureRecognizer(tapGestureRecognizerforDp)
    }

    func datePickerTapped() {
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
                                let dateValue = formatter.string(from: dt)
                                self.btnChooseDate.setTitle(dateValue, for: .normal)
                                
                            }
        }
    }

    
    
    @objc func imageTappedForDp(img: AnyObject)
    {
        photoPicker.pick(allowsEditing: false, pickerSourceType: .CameraAndPhotoLibrary, controller: self) { (orignal, edited) in
            
            self.profilePic.image = orignal
            let cgFloat: CGFloat = self.profilePic.frame.size.width/2.0
            let someFloat = Float(cgFloat)
            WAShareHelper.setViewCornerRadius(self.profilePic, radius: CGFloat(someFloat))
            self.cover_image = orignal
        }
    }
    
    @IBAction func btnChoseDate_Pressed(_ sender: UIButton) {
        datePickerTapped()
    }
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func btnSignUp_Pressed(_ sender: UIButton) {
        
        
        let params =      ["email"                    :  txtEmail.text!  ,
                           "password"                 :  txtPass.text! ,
                           "first_name"               :  txtFirstName.text! ,
                           "last_name"                :  txtLastName.text!,
                           "phone"                    :  txtMobileNumber.text! ,
                           "gender"                   :  "M",
                           "date_of_birth"            :  "01/09/2017"
                           ] as [String : Any]
        
        WebServiceManager.multiPartImage(params: params as Dictionary<String, AnyObject> , serviceName: SIGNUP, imageParam:"image.png", serviceType: "Sign Up", profileImage: profilePic.image, cover_image_param: "", cover_image: nil , modelType: UserResponse.self, success: { (response) in
            
            
            let responseObj = response as! UserResponse
            
            
            if responseObj.success == 1 {
                localUserData = responseObj.result?.userInfo

                self.showAlertViewWithTitle(title: "SOT Event", message: responseObj.message! , dismissCompletion: {
                    
                })
                
               
            }
            else
            {
                self.showAlert(title: "SOT Event", message: responseObj.message!, controller: self)
                
            }
            
        }) { (error) in
            
            
        }
    }

    
    
}

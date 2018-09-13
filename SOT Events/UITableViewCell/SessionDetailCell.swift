//
//  SessionDetailCell.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 07/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
protocol ReadMore {
    func readMoreButtonPressed(cell : SessionDetailCell , index : IndexPath)
    func AskQuestion(cell : SessionDetailCell , index : IndexPath)

}

class SessionDetailCell: UITableViewCell {
    @IBOutlet weak var lblActivity_title: UILabel!
    @IBOutlet weak var lblActivity_desc: UILabel!
    @IBOutlet weak var lblDisplay_date: UILabel!
    @IBOutlet weak var lblVenue_title: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var btnReadMore: UIButton!

    var index  : IndexPath?
    var delegae : ReadMore?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnAskQuestion_Pressed(_ sender: UIButton) {
        self.delegae?.AskQuestion(cell: self, index: index!)
    }
    
    @IBAction func btnReadMoreOrLessButton_Pressed(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
        self.delegae?.readMoreButtonPressed(cell: self, index: index!)

//        if sender.isSelected == true {
//        } else {
//              self.delegae?.readMoreButtonPressed(cell: self, index: index!)
//        }
      
    }
    
    
}

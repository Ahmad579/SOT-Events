//
//  ProgrammCell.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 07/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit

protocol SpeakerDetail {
    func selectSpeaker(cell : ProgrammCell , indexCheck : IndexPath , participant : ParticipationObject)
}

class ProgrammCell: UITableViewCell {
    @IBOutlet weak var lblActivity_title: UILabel!
    @IBOutlet weak var lblActivity_desc: UILabel!
    @IBOutlet weak var lblDisplay_date: UILabel!
    @IBOutlet weak var lblVenue_title: UILabel!
    
    @IBOutlet weak var collectionViewCell: UICollectionView!
    var participation : [ParticipationObject]?
    var index : IndexPath?
    var delegate : SpeakerDetail?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ProgrammCell : UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (participation?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ParticipateCell", for: indexPath) as! ParticipateCell
        
        WAShareHelper.loadImage(urlstring: (participation![indexPath.row].participant_photo)! , imageView: cell.imgOfUser, placeHolder: "rectangle_placeholder")
        let cgFloat: CGFloat = cell.imgOfUser.frame.size.width/2.0
        let someFloat = Float(cgFloat)
        WAShareHelper.setViewCornerRadius(cell.imgOfUser, radius: CGFloat(someFloat))

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = self.participation![indexPath.row]
        self.delegate?.selectSpeaker(cell: self, indexCheck: indexPath , participant: obj)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeOfCell = self.collectionViewCell.frame.size.width/6
        //        let heightOfCell = self.collectionViewCell.frame.size.height/6
        
        return CGSize(width: sizeOfCell, height: 38.0)
    }
    
    
}

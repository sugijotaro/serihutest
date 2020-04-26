//
//  messageView.swift
//  serihutest
//
//  Created by JotaroSugiyama on 2020/04/18.
//  Copyright © 2020 JotaroSugiyama. All rights reserved.
//

import UIKit
import CoreLocation

protocol MessageViewDelegate: class {
    func messageViewTouched()
}

class MessageView: UIView, CLLocationManagerDelegate {
    
//    @IBOutlet var view :UIView!
    @IBOutlet var nameLabel :UILabel!
    @IBOutlet var textView :UITextView!
    @IBOutlet var textViewView :UIView!
    @IBOutlet var image :UIImageView!
    @IBOutlet var button : UIButton!
        
    weak var delegate: MessageViewDelegate?
    
    var locationManager: CLLocationManager! = nil
    
    var longitude: CLLocationDegrees = 0.0
    var latitude: CLLocationDegrees = 0.0{
        didSet{
//            locationManager.startUpdatingLocation()
            print("み")
        }
    }
        
    @IBAction func touchedButton() {
        print(latitude)
        delegate?.messageViewTouched()
    }

    // コードから生成した時の初期化処理
    override init(frame: CGRect) {
        super.init(frame: frame)
    //        self.nibInit()
    }
           
        // ストーリーボードで配置した時の初期化処理
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        self.nibInit()
    }
        
    override func awakeFromNib() {
        nameLabel.widthAnchor.constraint(equalTo: self.textViewView.widthAnchor, multiplier: 5/12).isActive = true
//        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }

}

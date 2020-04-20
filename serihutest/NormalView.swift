//
//  normalView.swift
//  serihutest
//
//  Created by JotaroSugiyama on 2020/04/18.
//  Copyright © 2020 JotaroSugiyama. All rights reserved.
//

import UIKit

protocol NormalViewDelegate: class {
    func normalViewTouched()
}

class NormalView: UIView {
    
    @IBOutlet var nameLabel :UILabel!
    @IBOutlet var textView :UITextView!
    @IBOutlet var textViewView :UIView!
    @IBOutlet var image :UIImageView!
    
    weak var delegate: NormalViewDelegate?
    
    @IBAction func touchedButton() {
        delegate?.normalViewTouched()
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
    }

}

//
//  questionView.swift
//  serihutest
//
//  Created by JotaroSugiyama on 2020/04/18.
//  Copyright © 2020 JotaroSugiyama. All rights reserved.
//

import UIKit

protocol QuestionViewDelegate: class {
    func questionViewTouched(getNextId: String)
}

class QuestionView: UIView {

    @IBOutlet var nameLabel :UILabel!
    @IBOutlet var textView :UITextView!
    @IBOutlet var textViewView :UIView!
    @IBOutlet var image :UIImageView!
    @IBOutlet var tableView :UITableView!
    @IBOutlet var tableHeight: NSLayoutConstraint!
    
    var array :[[String]] = [["選択肢1"],["nextId1"]]{
        didSet{
            tableView.reloadData()
            tableHeight.constant = CGFloat(45 * array.count)
        }
    }
    
    weak var delegate: QuestionViewDelegate?
    
    func touchedButton(getNextId: String) {
        delegate?.questionViewTouched(getNextId: getNextId)
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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.rowHeight = 45
    }
}



extension QuestionView: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = array[indexPath.row][0]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(array[indexPath.row][1])
        touchedButton(getNextId: array[indexPath.row][1])
    }
}

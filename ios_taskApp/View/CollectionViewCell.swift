//
//  CollectionViewCell.swift
//  QuizApp
//
//  Created by Dr Mohan Roop on 7/5/19.
//  Copyright © 2019 spinlogics. All rights reserved.
//

import UIKit

protocol QuizCVCellDelegate: class {
    func didChooseAnswer(btnIndex: Int)
}

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    
    var btnsArray = [UIButton]()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViews()
        btnsArray = [btn1, btn2, btn3, btn4]
    }
    
    weak var delegate: QuizCVCellDelegate?
    
    var questionData: Question? {
        didSet {
            guard let unwrappedQue = questionData else { return }
            //imgView.image = UIImage(named: unwrappedQue.imgName)
            question.text = unwrappedQue.Question
            btn1.setTitle(unwrappedQue.MCQ[0], for: .normal)
            btn2.setTitle(unwrappedQue.MCQ[1], for: .normal)
            btn3.setTitle(unwrappedQue.MCQ[2], for: .normal)
            btn4.setTitle(unwrappedQue.MCQ[3], for: .normal)
            
            
            if unwrappedQue.isanswed {
                
                btnsArray[unwrappedQue.userAns-1].backgroundColor=UIColor.systemPink
                
            }
            
        }
    }
    
    @objc func btnOptionAction(sender: UIButton) {
        
        delegate?.didChooseAnswer(btnIndex: sender.tag)
        
        
    }
    
    override func prepareForReuse() {
        btn1.backgroundColor=UIColor.black
        btn2.backgroundColor=UIColor.black
        btn3.backgroundColor=UIColor.black
        btn4.backgroundColor=UIColor.black
    }
    
    
    func setupViews() {
        
        btn1.addTarget(self, action: #selector(btnOptionAction), for: .touchUpInside)
        btn2.addTarget(self, action: #selector(btnOptionAction), for: .touchUpInside)
        btn3.addTarget(self, action: #selector(btnOptionAction), for: .touchUpInside)
        btn4.addTarget(self, action: #selector(btnOptionAction), for: .touchUpInside)
    }
    
    
    
}


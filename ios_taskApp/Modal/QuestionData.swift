//
//  QuestionData.swift
//  ios_taskApp
//
//  Created by Kartheek Repakula on 15/03/21.
//  Copyright © 2021 Task. All rights reserved.
//

import Foundation

struct Question {
    
    var Question:String!
    var MCQ = [String]()
    var isanswed:Bool!
    let correctAns: Int
    var userAns: Int
    
    init(question:String,answed:Bool,mcq:[String],correct:Int,user:Int) {
        self.Question = question
        self.MCQ = mcq
        self.isanswed = answed
        self.userAns=user
        self.correctAns=correct
    }
    
}

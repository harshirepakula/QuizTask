//
//  ViewController.swift
//  iOS Quiz
//
//  Created by Jitender Kumar Yadav on 27/10/20.
//  Copyright © 2020 Jitender Kumar Yadav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startQuiz(_ sender: Any) {
        let quizVC = self.storyboard?.instantiateViewController(withIdentifier: "QuizViewController") as! QuizViewController
        quizVC.title = "Quiz"
        self.navigationController?.pushViewController(quizVC, animated: true)
        
    }
    
    @IBAction func resultClicked(_ sender: Any) {
        let resultVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        resultVC.title = "Result"
        self.navigationController?.pushViewController(resultVC, animated: true)
    }
}


//
//  QuizViewController.swift
//  iOS Quiz
//
//  Created by Jitender Kumar Yadav on 27/10/20.
//  Copyright © 2020 Jitender Kumar Yadav. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var myQuizCollection: UICollectionView!
    
    let currentDateTime = Date()
    
    var questionArr:[Question] = []
    var score: Int = 0
    var resultArr = [2,3,2,3,2]
    var currentQuestionNumber = 1
    var userAnswerArr = [Int]()
    
    var results = [FinalScore]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        fetchData()
        
        self.nextBtn.isHidden = true
        self.previousBtn.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func fetchData()
    {
        
        if let path = Bundle.main.url(forResource: "Data", withExtension: "json") {
            
            do {
                let jsonData = try Data(contentsOf: path, options: .mappedIfSafe)
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? NSDictionary {
                        if let questionArray = jsonResult.value(forKey: "Quiz") as? [[String:Any]] {
                            
                            if (questionArray.count)>0{
                                
                                self.questionArr.removeAll()
                                
                                for i in 0..<questionArray.count
                                {
                                    let answer = resultArr[i]
                                    
                                    let questionData = Question(question:((questionArray[i]["Question"] as? String)!), answed: false, mcq: ((questionArray[i]["MCQ Answer"] as? [String])!), correct:answer, user: -1)
                                    
                                    
                                    self.questionArr.append(questionData)
                                    
                                }
                                
                            }
                            
                            DispatchQueue.main.async {
                                self.myQuizCollection.reloadData()
                            }
                            
                            
                        }
                    }
                } catch let error as NSError {
                    print("Error: \(error)")
                }
            } catch let error as NSError {
                print("Error: \(error)")
            }
        }
        
        
    }
    
    
    @IBAction func submitBtnTap(_ sender: Any)
    {
        print(userAnswerArr)
        
        for i in 0..<userAnswerArr.count
        {
            if userAnswerArr[i] == resultArr[i]
            {
                score += 5
            }
            else
            {
                score -= 2
            }
        }
        
    // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        let toDay = String(formatter.string(from: currentDateTime))
        
        saveData(Resultscore: score, date: toDay)
        
    }
    
    // save to core data
    func saveData(Resultscore:Int,date:String){
        
        let result = FinalScore(context: PersistenceServce.context)
        
        result.marks =  Int32(Resultscore)
        result.date = date
      
        PersistenceServce.saveContext()
        self.results.append(result)
        
        let resultVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(resultVC, animated: true)
        
    }
    
    
    func moveToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset ,y : self.myQuizCollection.contentOffset.y ,width : self.myQuizCollection.frame.width,height : self.myQuizCollection.frame.height)
        self.myQuizCollection.scrollRectToVisible(frame, animated: true)
        
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setQuestionNumber()
    }
    
    func setQuestionNumber() {
        let x = myQuizCollection.contentOffset.x
        let w = myQuizCollection.bounds.size.width
        let currentPage = Int(ceil(x/w))
        if currentPage < questionArr.count {
            currentQuestionNumber = currentPage + 1
        }
    }
    
    
    @IBAction func nextBtnTap(_ sender: Any)
    {
        
        let collectionBounds = self.myQuizCollection.bounds
        var contentOffset: CGFloat = 0
        
        contentOffset = CGFloat(floor(self.myQuizCollection.contentOffset.x + collectionBounds.size.width))
        
        if currentQuestionNumber < questionArr.count
        {
            currentQuestionNumber = currentQuestionNumber+1
            
        }
        else{
            currentQuestionNumber = questionArr.count
            
        }
        
        self.moveToFrame(contentOffset: contentOffset)
        
        if questionArr[currentQuestionNumber-1].isanswed == true
        {
            showButtons()
        }
        else
        {
            self.submitBtn.isHidden = true
            self.nextBtn.isHidden = true
            self.previousBtn.isHidden = true
        }
        
    }
    
    @IBAction func previousBtnTap(_ sender: Any) {
        
        
        let collectionBounds = self.myQuizCollection.bounds
        var contentOffset: CGFloat = 0
        
        contentOffset = CGFloat(floor(self.myQuizCollection.contentOffset.x - collectionBounds.size.width))
        
        if currentQuestionNumber > 1
        {
            currentQuestionNumber = currentQuestionNumber-1
            
        }
        else{
            currentQuestionNumber = 1
            
        }
        
        self.moveToFrame(contentOffset: contentOffset)
        
        
        if questionArr[currentQuestionNumber-1].isanswed == true
        {
            showButtons()
        }
        else
        {
            self.submitBtn.isHidden = true
            self.nextBtn.isHidden = true
            self.previousBtn.isHidden = true
        }
     
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionArr.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)as! CollectionViewCell
        
        cell.questionData = questionArr[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    func showButtons()
    {
        
        if self.currentQuestionNumber == 1
        {
            self.submitBtn.isHidden = true
            self.previousBtn.isHidden = true
            self.nextBtn.isHidden = false
        }
        else if self.currentQuestionNumber == self.questionArr.count
        {
            self.nextBtn.isHidden = true
            self.previousBtn.isHidden = true
            self.submitBtn.isHidden = false
        }
        else
        {
            self.submitBtn.isHidden = true
            self.nextBtn.isHidden = false
            self.previousBtn.isHidden = false
        }
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let yourWidth = self.myQuizCollection.frame.width
        return CGSize(width: yourWidth, height: 540)
    }
    
}




extension QuizViewController: QuizCVCellDelegate {
    func didChooseAnswer(btnIndex: Int) {
        let centerIndex = getCenterIndex()
        guard let index = centerIndex else { return }
        questionArr[index.item].isanswed=true
        questionArr[index.item].userAns = btnIndex
        let answer = btnIndex
        print(answer)
        
        
        if userAnswerArr.count >= currentQuestionNumber
        {
            userAnswerArr[currentQuestionNumber-1] = answer
            
        }
        else
        {
            userAnswerArr.append(answer)
        }
        
        myQuizCollection.reloadItems(at: [index])
        
        showButtons()
    }
    
    func getCenterIndex() -> IndexPath? {
        let center = self.view.convert(self.myQuizCollection.center, to: self.myQuizCollection)
        let index = myQuizCollection!.indexPathForItem(at: center)
        print(index ?? "index not found")
        return index
    }
}

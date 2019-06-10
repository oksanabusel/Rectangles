//
//  GameViewController.swift
//  PresentsSections
//
//  Created by Cat on 5/12/19.
//  Copyright © 2018 Cat. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var gameTableView:  UITableView!
    @IBOutlet weak var rightSceenView: UIView!
    @IBOutlet weak var leftScreenView: UIView!
    
    private var tableViewHeight:       CGFloat = UIScreen.main.bounds.height
    private let screenWidth:           CGFloat = UIScreen.main.bounds.width
    private var screenHeight:          CGFloat = UIScreen.main.bounds.height
    private let imageWidth:            CGFloat = UIScreen.main.bounds.width/4
    private var partOfTheScreen:       CGFloat = UIScreen.main.bounds.height/100
    private var tableMoveAt:           CGFloat = 0
    private var interactiveViewHeight: CGFloat = 0
    
    private var cellHeight:        Int    = 44
    private var timerTimeInterval: Double = 0.08
    private var tableRow:          Int    = 1
    private var scorePoints:       Int    = 0

    private let cacheService    = CacheService()
    private var interactiveView = InteractiveView()
    private var timer           = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTapGesture()
        layoutInteractiveView()
        
        cacheService.fillDataSourceArray() {
            startTimer()
        }
    }
    
    override func viewWillLayoutSubviews() {
        self.interactiveView.frame = CGRect(x: 0,
                                            y: screenHeight - 43,
                                        width: screenWidth,
                                       height: 44)
        
        self.gameTableView.addSubview(interactiveView)
    }
    
    func layoutInteractiveView() {
        guard let view = UINib.init(nibName: "InteractiveView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? InteractiveView else {
            assert(false)
            return
        }
        self.interactiveView = view
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func startTimer() {
        timer = Timer(timeInterval: timerTimeInterval, target: self, selector: #selector(self.scrollGameTable), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .default)
    }
    
    @objc private func scrollGameTable() {
        gameTableView.scrollRectToVisible(CGRect(x: 0,
                                                 y: 0,
                                             width: screenWidth,
                                            height: screenHeight + tableMoveAt),
                                          animated: true)
        if tableViewHeight > 0 {
            tableMoveAt     += partOfTheScreen
            tableViewHeight -= partOfTheScreen
        } else {
            timer.invalidate()
            
            let alert = UIAlertController(title: score,
                                        message: "\(scorePoints)" + rows,
                                 preferredStyle: .alert)
            
            let action = UIAlertAction(title: done,
                                       style: .default,
                                     handler: {action in self.moveToTheStartScreen()})
            
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    func configureTapGesture() {
        let leftTapGesture  = UITapGestureRecognizer(target: self, action: #selector(self.moveColorImageToTheLeft))
        let rightTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.moveColorImageToTheRight))
        
        self.leftScreenView.addGestureRecognizer(leftTapGesture)
        self.rightSceenView.addGestureRecognizer(rightTapGesture)
    }
    
    @objc func moveColorImageToTheRight() {
        self.interactiveView.moveColorImageToTheRight()
        removeCorrectRow()
        removeCorrectRow()
        }

    
    @objc func moveColorImageToTheLeft() {
        self.interactiveView.moveColorImageToTheLeft()
        removeCorrectRow()
        removeCorrectRow()
    }
    
    func moveToTheStartScreen() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func increaseScorePoints() {
        if scorePoints == 10 {
            timerTimeInterval -= 0.01
        } else if scorePoints == 25 {
            timerTimeInterval -= 0.01
        } else if scorePoints == 40 {
            timerTimeInterval -= 0.01
        } else if scorePoints == 85 {
            timerTimeInterval -= 0.01
        }
    }
    
    func removeCorrectRow() {
        var imagesArray = cacheService.sourceArray[tableRow]
        if imagesArray[interactiveView.imagePosition].getImage() == interactiveView.colorImageView.image! {
            let index: IndexPath = [0, tableRow]
            self.gameTableView.cellForRow(at: index)?.contentView.isHidden = true
            
            scorePoints           += 1
            tableRow              += 1
            interactiveViewHeight += 44
            tableViewHeight       += 44
            
            self.interactiveView.frame = CGRect(x: 0,
                                                y: screenHeight - 43 + interactiveViewHeight,
                                            width: screenWidth,
                                           height: 44)
        }
    }
    
}

extension GameViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cacheService.sourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GameCell
        let rowData = cacheService.sourceArray[indexPath.row]
        
        if indexPath.row == 0 {
            cell.firstImage.isHidden  = true
            cell.secondImage.isHidden = true
            cell.thirdImage.isHidden  = true
            cell.fourthImage.isHidden = true
        }
        
        if indexPath.row == 1 {
            interactiveView.setImage(imagesArray: rowData)
        }
        cell.setData(imagesArray: rowData)
        
        return cell
    }
    
}

extension GameViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UIScreen.main.bounds.height
        } else {
            return 44
        }
    }
    
}

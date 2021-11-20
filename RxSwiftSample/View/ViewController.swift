//
//  ViewController.swift
//  RxSwiftSample
//
//  Created by 野入隆史 on 2021/11/20.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var countLabel: UILabel!
    
    // viewmodel
    private var calcCount: ClacCount?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpClacCount()
        
    }


    private func setUpClacCount() {
        calcCount = ClacCount()
        let input = CalcCountInput(
            countUpButton: plusButton.rx.tap.asObservable(),
            countDownButton: minusButton.rx.tap.asObservable(),
            countRestButton: resetButton.rx.tap.asObservable())
        calcCount?.setup(input: input)
        calcCount?.outputs?.countertText.drive(countLabel.rx.text).disposed(by: disposeBag)
    }
    
}


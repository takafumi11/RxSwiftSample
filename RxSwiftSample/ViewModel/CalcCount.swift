//
//  CalcCount.swift
//  RxSwiftSample
//
//  Created by 野入隆史 on 2021/11/20.
//

import Foundation
import RxSwift
import RxCocoa

// 入力
struct CalcCountInput {
    var countUpButton: Observable<Void>
    var countDownButton: Observable<Void>
    var countRestButton: Observable<Void>
}
// 出力
protocol CalcCountOutput {
    var countertText: Driver<String?> { get }
}

protocol CalcCountType {
    var outputs: CalcCountOutput? { get }
    func setup(input: CalcCountInput)
}

final class ClacCount: CalcCountType, CalcCountOutput {
    var countertText: Driver<String?>
    
    private let disposeBag = DisposeBag()
    var count = 0
    
    var outputs: CalcCountOutput?

    func setup(input: CalcCountInput) {
        input.countUpButton.subscribe { [weak self] event in
            guard let self = self else { return }
            print(event)
            self.plus()
        }.disposed(by: disposeBag)
        
        input.countDownButton.subscribe { [weak self]  event in
            print(event)
            guard let self = self else { return }
            print(event)
            self.minus()
        }.disposed(by: disposeBag)
        
        input.countRestButton.subscribe { [weak self]  event in
            print(event)
            guard let self = self else { return }
            print(event)
            self.reset()
        }.disposed(by: disposeBag)
    }
    
    func plus() {
        self.count += 1
    }
    
    func minus() {
        self.count -= 1
    }
    
    func reset() {
        self.count = 0
    }
    
}

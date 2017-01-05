//
//  ReactiveExtension.swift
//  desafio-ios
//
//  Created by Klevison Matias on 1/5/17.
//  Copyright © 2017 Arena. All rights reserved.
//

import RxSwift
import UIKit
import RxCocoa

extension Reactive where Base: UIScrollView {
    var reachedBottom: Driver<Void> {
        return contentOffset
            .flatMap { [weak base] contentOffset -> Observable<Void> in
                guard let scrollView = base else {
                    return Observable.empty()
                }
                
                let visibleHeight = scrollView.frame.height - scrollView.contentInset.top - scrollView.contentInset.bottom
                let y = contentOffset.y + scrollView.contentInset.top
                let threshold = max(0.0, scrollView.contentSize.height - visibleHeight)
                
                return y > threshold ? Observable.just() : Observable.empty()
        }.asDriver(onErrorJustReturn: ())
    }
}

//
//  BaseViewController.swift
//  Noody
//
//  Created by Klevison Matias on 12/1/16.
//  Copyright © 2016 worQ. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit
typealias OSViewController = UIViewController

class BaseViewController: OSViewController {
    #if TRACE_RESOURCES
    private let startResourceCount = RxSwift.Resources.total
    #endif
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        #if TRACE_RESOURCES
            print("Number of start resources = \(Resources.total)")
        #endif
       
        let tapBackground = UITapGestureRecognizer()
        tapBackground.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            }).addDisposableTo(disposeBag)
        
        view.addGestureRecognizer(tapBackground)
    }
    
    deinit {
        #if TRACE_RESOURCES
            print("View controller disposed with \(Resources.total) resources")
            
            
            /*
             !!! This cleanup logic is adapted for example app use case. !!!
             
             It is being used to detect memory leaks during pre release tests.
             
             !!! In case you want to have some resource leak detection logic, the simplest
             method is just printing out `RxSwift.Resources.total` periodically to output. !!!
             
             
             /* add somewhere in
             func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
             */
             _ = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
             .subscribe(onNext: { _ in
             print("Resource count \(RxSwift.Resources.total)")
             })
             
             Most efficient way to test for memory leaks is:
             * navigate to your screen and use it
             * navigate back
             * observe initial resource count
             * navigate second time to your screen and use it
             * navigate back
             * observe final resource count
             
             In case there is a difference in resource count between initial and final resource counts, there might be a memory
             leak somewhere.
             
             The reason why 2 navigations are suggested is because first navigation forces loading of lazy resources.
             */
            
            let numberOfResourcesThatShouldRemain = startResourceCount
            let mainQueue = DispatchQueue.main
            /*
             This first `dispatch_async` is here to compensate for CoreAnimation delay after
             changing view controller hierarchy. This time is usually ~100ms on simulator and less on device.
             
             If somebody knows more about why this delay happens, you can make a PR with explanation here.
             */
            let when = DispatchTime.now() + DispatchTimeInterval.milliseconds(OSApplication.isInUITest ? 1000 : 10)
            
            mainQueue.asyncAfter (deadline: when) {
                
                /*
                 Some small additional period to clean things up. In case there were async operations fired,
                 they can't be cleaned up momentarily.
                 */
                // If this fails for you while testing, and you've been clicking fast, it's ok, just click slower,
                // this is a debug build with resource tracing turned on.
                //
                // If this crashes when you've been clicking slowly, then it would be interesting to find out why.
                // ¯\_(ツ)_/¯
                assert(Resources.total <= numberOfResourcesThatShouldRemain, "Resources weren't cleaned properly, \(Resources.total) remaned, \(numberOfResourcesThatShouldRemain) expected")
                
            }
        #endif
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        if let parent = parent {
            assert(parent as? UINavigationController != nil, "Please read comments")
        } else {
            self.disposeBag = DisposeBag()
        }
    }
}

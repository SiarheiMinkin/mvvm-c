//
//  AppCoordinator.swift
//  mvvm-c
//
//  Created by Serg on 1/14/21.
//

import Foundation
import RxSwift
import UIKit
import RxCocoa
 
protocol CoordinatorProtocol {
    func start(from viewController: UIViewController) -> Observable<Void>
    func coordinate(to coordinator: CoordinatorProtocol, from viewController: UIViewController) -> Observable<Void>
}

class AppCoordinator: CoordinatorProtocol {
 
    // MARK: Public Properties
 
    lazy var loginCoordinator = LoginCoordinator()
 
    // MARK: Private Properties
 
    private let disposeBag = DisposeBag()
 
    // MARK: CoordinatorProtocol Methods
 
    func start(from viewController: UIViewController) -> Observable<Void> {
        viewController.rx.viewDidAppear.bind(onNext: { [unowned self] () in
             self.coordinate(to: self.loginCoordinator, from: viewController)
        }).disposed(by: disposeBag)
 
        return Observable.never()
    }
 
    func coordinate(to coordinator: CoordinatorProtocol, from viewController: UIViewController) -> Observable<Void> {
        return coordinator.start(from: viewController)
    }
}



    extension Reactive where Base: UIViewController {
     
        private func controlEvent(for selector: Selector) -> ControlEvent<Void> {
            return ControlEvent(events: sentMessage(selector).map { _ in })
        }
     
        var viewWillAppear: ControlEvent<Void> {
            return controlEvent(for: #selector(UIViewController.viewWillAppear))
        }
     
        var viewDidAppear: ControlEvent<Void> {
            return controlEvent(for: #selector(UIViewController.viewDidAppear))
        }
     
        var viewWillDisappear: ControlEvent<Void> {
            return controlEvent(for: #selector(UIViewController.viewWillDisappear))
        }
     
        var viewDidDisappear: ControlEvent<Void> {
            return controlEvent(for: #selector(UIViewController.viewDidDisappear))
        }
     
    }

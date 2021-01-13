//
//  LoginViewController.swift
//  mvvm-c
//
//  Created by Serg on 1/14/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController, ViewControllerProtocol, Identifierable {
    
    // MARK: ViewControllerProtocol Properties
    
    typealias VM = LoginViewModel
    
    var viewModel: LoginViewModel!
    
    // MARK: Private Properties
    
    fileprivate let disposeBag = DisposeBag()
    
    // MARK: - IBOutlets: Controls
    
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var doneBarButtonItem: UIBarButtonItem!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindUIActions()
    }
    
}

private extension LoginViewController {
    
    func bindUIActions() {
        loginTextField.rx.text.bind(to: viewModel.inputUserLogin).disposed(by: disposeBag)
        viewModel.isDoneButtonEnabled.drive(doneBarButtonItem.rx.isEnabled).disposed(by: disposeBag)
        doneBarButtonItem.rx.tap.bind(to: viewModel.doneActionObserver).disposed(by: disposeBag)
    }
    
}

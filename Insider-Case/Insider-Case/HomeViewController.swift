//
//  ViewController.swift
//  Insider-Case
//
//  Created by Ozgun Dogus on 16.03.2024.
//

import UIKit
import WebKit
import Insider_Case_Framework

class HomeViewController: UIViewController,StarsViewModelDelegate {

    var webView: WKWebView!
    var viewModel = StarsViewModel()
     
     override func viewDidLoad() {
         super.viewDidLoad()
         setupUI()
         initViewModel()
         NotificationCenter.default.addObserver(self, selector: #selector(resetStarsNotificationReceived), name: NSNotification.Name("ResetStars"), object: nil)
     }
    
    func didUpdateStarCount(to count: Int) {
        DispatchQueue.main.async {
        }
    }
    
    func didUpdateStarsList() {
        DispatchQueue.main.async {
        }
    }
    
    func didReceiveAlert(message: String) {
        DispatchQueue.main.async {
        self.showAlert(message: message)
        }
    }
    
    func initViewModel() {
           viewModel.delegate = self
       }

    func setupUI() {
       
        webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7)
        ])
        
        if let url = URL(string: "https://img.etimg.com/thumb/msid-72948091,width-650,imgsize-95069,,resize-mode-4,quality-100/star_istock.jpg") {
            webView.load(URLRequest(url: url))
        }
        
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let buttonTitles = ["Small Star", "Big Star", "Reset"]
        for title in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }

    @objc func resetStarsNotificationReceived() {
           viewModel.resetStars()
       }
    
    @objc func buttonAction(_ sender: UIButton) {
        guard let buttonTitle = sender.title(for: .normal) else { return }
        
        switch buttonTitle {
        case "Small Star":
            viewModel.addStarInterface(size: "S")
        case "Big Star":
            viewModel.addStarInterface(size: "B")
        case "Reset":
            viewModel.resetStars()
        default:
            break
        }
    }
     func showAlert(message: String) {
         let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default))
         self.present(alert, animated: true, completion: nil)
     }

}


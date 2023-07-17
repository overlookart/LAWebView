//
//  ViewController.swift
//  LAWebView
//
//  Created by CaiGou on 2023/7/17.
//

import UIKit
import LAWebView
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let web = LAWebView(config: WebConfigComponent())
        web.backgroundColor = .orange
        web.frame = view.frame
        view.addSubview(web)
    }


}


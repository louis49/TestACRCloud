//
//  ViewController.swift
//  TestACRCloud
//
//  Created by Desnos on 03/08/2015.
//  Copyright (c) 2015 Desnos. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{


	
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		ACRManager.sharedInstance
		MicrophoneManager.sharedInstance.start()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		
	}


}


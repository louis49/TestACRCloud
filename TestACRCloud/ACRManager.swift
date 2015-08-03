//
//  ACRManager.swift
//  TestACRCloud
//
//  Created by Desnos on 03/08/2015.
//  Copyright (c) 2015 Desnos. All rights reserved.
//

import Foundation

class ACRManager : NSObject
{
	static let sharedInstance: ACRManager = ACRManager()

	var client:ACRCloudRecognition
	var config:ACRCloudConfig
	
	override init()
	{
		config = ACRCloudConfig.new()
		config.accessKey = "f69dc3061425e6ffa26d0f80e7c640f3"
		config.accessSecret = "9LpwD89qCCmyIRdK8M4MVYEDNBXRuxzeAhrta9HJ"
		config.host = "ap-southeast-1.api.acrcloud.com"
		config.recMode = rec_mode_remote
		//config.audioType = "recording"
		config.requestTimeout = 10
		config.homedir = NSBundle.mainBundle().resourcePath?.stringByAppendingPathComponent("acrcloud_local_db")
		
		

		
		
		
		//weak var weak_self = self
		
		config.stateBlock =
			{ (state:String!) -> Void in
			
				println(state)
			
			} as ACRCloudStateBlock
		
		
		config.volumeBlock =
			{ (volume:Float) -> Void in
			
				println(volume)
			
			} as ACRCloudVolumeBlock
		

		config.resultBlock =
			{ (result:String!, type:ACRCloudResultType) -> Void in
				
				println(result)
				println(type)
				
			} as ACRCloudResultBlock
		
		client = ACRCloudRecognition(config: config)
		
		//client.startRecordRec()
		
		super.init()

	}
	

}
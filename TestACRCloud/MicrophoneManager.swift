//
//  MicrophoneManager.swift
//  TestEntourage
//
//  Created by Desnos on 08/07/2015.
//  Copyright (c) 2015 Desnos. All rights reserved.
//

import Foundation
import AVFoundation

class MicrophoneManager : NSObject
{
	static let sharedInstance: MicrophoneManager = MicrophoneManager()

	let engine:AVAudioEngine = AVAudioEngine()
	
	override init()
	{
		AVAudioSession.sharedInstance().requestRecordPermission { (granted: Bool) -> Void in
			if granted { println("Micro OK") }
			else { println("Micro refusé") }
		}
		
		super.init()
		
		
	}
	
	func start()
	{
		AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
		AVAudioSession.sharedInstance().setActive(true, error: nil)
		
		let player = AVAudioPlayerNode()
		
		let audioFile = AVAudioFile(forReading: NSBundle.mainBundle().URLForResource("LIVE", withExtension: "mp4"), error: nil)
	
		
		self.engine.attachNode(player)
		
		self.engine.connect(player, to: self.engine.mainMixerNode, format: audioFile.processingFormat)
		
		player.scheduleFile(audioFile, atTime: nil, completionHandler:nil)
		
		self.tap(node: player, format: self.engine.mainMixerNode.outputFormatForBus(0))
		
		player.play()
		
	}

	
	private func tap(#node:AVAudioNode, format:AVAudioFormat)
	{
		weak var weak_self = self
		
		node.installTapOnBus(0, bufferSize: 16537, format: format)
			{ (buffer:AVAudioPCMBuffer!, time:AVAudioTime!) -> Void in
				
				//buffer.frameLength = 1024
				
				var pointer:UnsafeMutablePointer<Int8> = UnsafeMutablePointer<Int8>(buffer.audioBufferList[0].mBuffers.mData)
				
				var string:NSString! = ACRManager.sharedInstance.client.recongize(pointer, len: Int32(buffer.frameLength))
				
				println("res: \(string)")
				
				var fp:NSData! = ACRCloudRecognition.get_fingerprint(pointer, len: Int32(buffer.frameLength))
				
				
				
				println("fp: \(fp)")

				
		}
		self.engine.startAndReturnError(nil)
	}
	
	
	
	
}
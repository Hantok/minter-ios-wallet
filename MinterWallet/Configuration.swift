//
//  Configuration.swift
//  MinterWallet
//
//  Created by Alexey Sidorov on 21/03/2019.
//  Copyright © 2019 Minter. All rights reserved.
//

import Foundation

struct Configuration {
	
	init() {}
	
	var environment: Environment = {
		if let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String {
			if configuration.range(of: "staging") != nil {
				return Environment.staging
			}
		}
		
		return Environment.production
	}()
}

enum Environment: String {
	
	case staging = "staging"
	case production = "production"
	
	var nodeBaseURL: String {
		switch self {
		case .staging: return "https://minter-node-2.testnet.minter.network:8841"
		case .production: return "https://minter-node-3.testnet.minter.network:8841"
		}
	}
	
	var explorerAPIBaseURL: String {
		switch self {
		case .staging: return "https://explorer-api.testnet.minter.network"
		case .production: return "https://explorer-api.testnet.minter.network"
		}
	}
	
	var explorerWebURL: String {
		switch self {
		case .staging: return "https://testnet.explorer.minter.network"
		case .production: return "https://testnet.explorer.minter.network"
		}
	}
	
	var explorerWebsocketURL: String {
		switch self {
		case .staging: return "wss://explorer-rtm.testnet.minter.network/connection/websocket"
		case .production: return "wss://explorer-rtm.testnet.minter.network/connection/websocket"
		}
	}
}

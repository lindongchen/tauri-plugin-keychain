import SwiftRs
import Tauri
import UIKit
import WebKit
import ObjectiveC
import Foundation
import UniformTypeIdentifiers

class KeychainArgs: Decodable {
  let key: String
  let password: String?
}
struct KeychainResponse: Codable {
  let password: String?
}

class KeychainPlugin: Plugin {
  @objc public func getItem(_ invoke: Invoke) throws {
    let args = try invoke.parseArgs(KeychainArgs.self)
		//args.key
		let resp = KeychainResponse(password: "aaa")
		invoke.resolve(resp)
  }
	
	@objc public func saveItem(_ invoke: Invoke) throws {
	  let args = try invoke.parseArgs(KeychainArgs.self)
		invoke.resolve(true)
	}
	@objc public func removeItem(_ invoke: Invoke) throws {
	  let args = try invoke.parseArgs(KeychainArgs.self)
		invoke.resolve(true)
	}
}

@_cdecl("init_plugin_keychain")
func initPlugin() -> Plugin {
  return KeychainPlugin()
}

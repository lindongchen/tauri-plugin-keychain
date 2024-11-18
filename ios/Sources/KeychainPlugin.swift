import SwiftRs
import Tauri
import WebKit
import ObjectiveC
import Foundation
import UniformTypeIdentifiers
import Security

class KeychainArgs: Decodable {
  let key: String
  let password: String?
}
struct KeychainResponse: Codable {
  let password: String?
}

class KeychainPlugin: Plugin {
  @objc public func getItem(_ invoke: Invoke) throws {
		
		NSLog("[KeychainPlugin]: getItem start")
    let args = try invoke.parseArgs(KeychainArgs.self)
		let key = args.key
		NSLog("[KeychainPlugin]: getItem \(key)")
		let query = [
				kSecClass: kSecClassGenericPassword,
				kSecAttrAccount: key,
				kSecReturnData: kCFBooleanTrue!,
				kSecMatchLimit: kSecMatchLimitOne
		] as CFDictionary
		
		var data: AnyObject?
		let status = SecItemCopyMatching(query, &data)
		
		guard status == errSecSuccess, let resultData = data as? Data else {
			NSLog("[KeychainPlugin]: getItem error")
			invoke.resolve(KeychainResponse(password: nil))
			return
		}
		
		let password = String(data: resultData, encoding: .utf8)
						
		let resp = KeychainResponse(password: password)
		NSLog("[KeychainPlugin]: getItem password: \(password)")
		invoke.resolve(resp)
  }
	
	@objc public func saveItem(_ invoke: Invoke) throws {
		NSLog("[KeychainPlugin]: saveItem start")
	  let args = try invoke.parseArgs(KeychainArgs.self)
		let key = args.key
		let value = args.password ?? ""
		guard let data = value.data(using: .utf8) else { 
			NSLog("[KeychainPlugin]: saveItem convert data error")
			invoke.resolve(false)
			return 
		}
		        
		NSLog("[KeychainPlugin]: saveItem delete before")
		let query = [
				kSecClass: kSecClassGenericPassword,
				kSecAttrAccount: key
		] as CFDictionary
		SecItemDelete(query)
		
		NSLog("[KeychainPlugin]: saveItem add before")
		let attributes = [
				kSecClass: kSecClassGenericPassword,
				kSecAttrAccount: key,
				kSecValueData: data
		] as CFDictionary
		let status = SecItemAdd(attributes, nil)
		
		NSLog("[KeychainPlugin]: saveItem done")
		invoke.resolve(status == errSecSuccess)
	}
	@objc public func removeItem(_ invoke: Invoke) throws {
	  let args = try invoke.parseArgs(KeychainArgs.self)
		let key = args.key
		let query = [
				kSecClass: kSecClassGenericPassword,
				kSecAttrAccount: key
		] as CFDictionary
		
		let status = SecItemDelete(query)
		invoke.resolve(status == errSecSuccess)
	}
}

@_cdecl("init_plugin_keychain")
func initPlugin() -> Plugin {
  return KeychainPlugin()
}

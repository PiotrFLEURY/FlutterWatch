//
//  WatchViewModel.swift
//  watch WatchKit Extension
//
//  Created by Piotr FLEURY on 20/02/2022.
//

import Foundation
import WatchConnectivity

class WatchViewModel: NSObject, ObservableObject {
    var session: WCSession
    @Published var counter = 0
    @Published var data = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    
    // Add more cases if you have more receive method
    enum WatchReceiveMethod: String {
        case sendCounterToNative
    }
    
    // Add more cases if you have more sending method
    enum WatchSendMethod: String {
        case sendCounterToFlutter
    }
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func sendDataMessage(for method: WatchSendMethod, data: [String: Any] = [:]) {
        sendMessage(for: method.rawValue, data: data)
    }
    
    func swap(value: Int) {
        let valueIndex: Int = data.firstIndex(of: value) ?? 0
        let zeroIndex: Int = data.firstIndex(of: 0) ?? 0
        
        data.swapAt(zeroIndex, valueIndex)
    }
    
}

extension WatchViewModel: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    // Receive message From AppDelegate.swift that send from iOS devices
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            guard let method = message["method"] as? String, let enumMethod = WatchReceiveMethod(rawValue: method) else {
                return
            }
            
            switch enumMethod {
            case .sendCounterToNative:
                self.counter = (message["data"] as? Int) ?? 0
            }
        }
    }
    
    func sendMessage(for method: String, data: [String: Any] = [:]) {
        guard session.isReachable else {
            return
        }
        let messageData: [String: Any] = ["method": method, "data": data]
        session.sendMessage(messageData, replyHandler: nil, errorHandler: nil)
    }
    
}

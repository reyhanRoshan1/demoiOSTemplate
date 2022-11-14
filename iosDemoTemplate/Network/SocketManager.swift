//
//  SocketManager.swift
//  CoupleCares
//
//  Created by Surinder Kumar on 26/02/22.
//

import UIKit
import SocketIO

class SocketConnectionManager {

    static let shared = SocketConnectionManager()
    var socket: SocketIOClient!

    //Local
    //"http://3.13.194.181:5004"
    
    let manager = SocketManager(socketURL: URL(string:"http://3.13.194.181:5004")!, config: [.log(true), .compress, .forceWebsockets(true)])

    private init() {
        socket = manager.defaultSocket
    }

    func connectSocket(completion: @escaping(Bool) -> () ) {
          disconnectSocket()
        socket.on(clientEvent: .connect) { (data, ack) in
            print("socket connected",ack.description)
            //self?.socket.removeAllHandlers()

            completion(true)
        }
        socket.connect()
    }

    func disconnectSocket() {
        socket.removeAllHandlers()
        socket.disconnect()
        print("socket Disconnected")
    }

    func checkConnection() -> Bool {
        if socket.manager?.status == .connected {
            return true
        }
        return false

    }
    
    
    func emit(emitterKey:String,params: [String : Any]) {
        SocketConnectionManager.shared.socket.emit(emitterKey, params)
    }

    func listen(listnerKey:String,completion: @escaping () -> Void) {
        print("listner key:-",listnerKey.trimmingCharacters(in: .whitespacesAndNewlines ))
        SocketConnectionManager.shared.socket.on(listnerKey.trimmingCharacters(in: .whitespacesAndNewlines)) { (response, emitter) in
            print("listerner:-",response)
            if response.count != 0{
                MessageViewModel.shared.setAllChatDictionary(dict: response.first as? [String:Any] ?? [:])
                completion()
            }
        }
    }

    func off(listnerKey:String) {
        SocketConnectionManager.shared.socket.off(listnerKey)
    }

}

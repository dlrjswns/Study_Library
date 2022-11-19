//
//  SocketIOManager.swift
//  SocketIOPR
//
//  Created by 이건준 on 2022/11/18.
//

import UIKit
import SocketIO

struct ChatType {
    var type = -1 // 내가 보낸 채팅인지 아닌지 구분짓는 아이디
    var message = ""
}

final class SocketIOManager {
    static let shared = SocketIOManager()
    
    var manager = SocketManager(socketURL: URL(string: "http://localhost:9000")!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    
    init() {
        socket = self.manager.socket(forNamespace: "/test") // manager.defaultSocket을 써서 기본 / 위치에서 사용가능
        // server딴에서도 위 네임스페이스처럼 동일한 /test여야지만 클라이언트와 서버간에 통신이 가능
        socket.on("test") { dataArray, ack in
            print("dataArray = \(dataArray)")
            print("ack = \(ack)")
        }
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func sendMessage(message: String, nickname: String) {
        socket.emit("event", ["message": "This is a test message"])
        socket.emit("event1", [["name": "ns"], ["email": "@naver.com"]])
        socket.emit("event2", ["name": "ns", "email": "@naver.com"])
        socket.emit("msg", ["nick": nickname, "msg": message])
    }
}

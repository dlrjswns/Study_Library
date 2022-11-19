//
//  RootViewController.swift
//  SocketIOPR
//
//  Created by 이건준 on 2022/11/18.
//

import UIKit
import SocketIO

class RootViewController: UIViewController {
    
    var myChat = [ChatType]()
    var socket: SocketIOClient!
    
    private let socketConnectButton: UIButton = {
        let button = UIButton()
        button.setTitle("소켓 연결", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let socketDisConnectButton: UIButton = {
        let button = UIButton()
        button.setTitle("소켓 연결해제", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        return tableView
    }()
    
    private let textBox: UITextField = {
       let txt = UITextField()
        txt.layer.cornerRadius = 10
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.gray.cgColor
        txt.layer.masksToBounds = true
        txt.backgroundColor = .white
        return txt
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("전송", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        
        self.socket = SocketIOManager.shared.socket
        bindMsg()
        
        socketConnectButton.addTarget(self, action: #selector(didTappedConnectButton), for: .touchUpInside)
        socketDisConnectButton.addTarget(self, action: #selector(didTappedDisConnectButton), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(didTappedSendButton), for: .touchUpInside)
    }
    
    // 뒤로가기시 소켓종료
        override func viewWillDisappear(_ animated: Bool) {
            SocketIOManager.shared.closeConnection()
//            unregisterForKeyboardNotifications()
        }
        
        // 서버로부터 메시지 받을때 채팅창 업데이트
        func bindMsg() {
            self.socket.on("test") { (dataArray, socketAck) in
                var chat = ChatType()
                print("***************************************")
                print(type(of: dataArray))
                let data = dataArray[0] as! NSDictionary
                
                guard let type = data["type"] as? Int else {
                    print("앙ㄹㄴ어ㅏ;런;밀")
                    return 
                }
                
                chat.type = type
                chat.message = data["message"] as! String
                self.myChat.append(chat)
                print(chat)
                
                self.updateChat(count: self.myChat.count) {
                    print("Get Message")
                }
            }
        }
        
        // 채팅 업데이트
        func updateChat( count: Int, completion: @escaping ()->Void ) {
            
            let indexPath = IndexPath( row: count-1, section: 0 )
            
//            self.tableView.beginUpdates()
//            self.tableView.insertRows(at: [indexPath], with: .none)
//            self.tableView.endUpdates()
//
//            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
            
            // 필요한경우 escaping closure를 이용한 데이터 전달
            completion()
        }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        _ = [socketConnectButton, socketDisConnectButton, textBox, sendButton].map{
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        socketConnectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        socketConnectButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        
        socketDisConnectButton.centerXAnchor.constraint(equalTo: socketConnectButton.centerXAnchor).isActive = true
        socketDisConnectButton.topAnchor.constraint(equalTo: socketConnectButton.bottomAnchor, constant: 30).isActive = true
        
        textBox.centerXAnchor.constraint(equalTo: socketDisConnectButton.centerXAnchor).isActive = true
        textBox.topAnchor.constraint(equalTo: socketDisConnectButton.bottomAnchor, constant: 30).isActive = true
        textBox.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        sendButton.centerXAnchor.constraint(equalTo: textBox.centerXAnchor).isActive = true
        sendButton.topAnchor.constraint(equalTo: textBox.bottomAnchor, constant: 30).isActive = true
    }
    
    @objc func didTappedConnectButton() {
        SocketIOManager.shared.establishConnection()
    }
    
    @objc func didTappedDisConnectButton() {
        SocketIOManager.shared.closeConnection()
    }
    
    @objc func didTappedSendButton() {
        SocketIOManager.shared.sendMessage(message: self.textBox.text!, nickname: "ns")
        
        let text = self.textBox.text!
        self.socket.emit("test", text)
        
        self.myChat.append(ChatType(type: 0, message: text))
        
        self.updateChat(count: self.myChat.count) {
            print("Send Message")
        }
    }
}

extension RootViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myChat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}

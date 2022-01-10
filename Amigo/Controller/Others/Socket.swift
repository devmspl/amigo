//
//  Socket.swift
//  Amigo
//
//  Created by mac on 27/12/2021.
//

import Foundation
import SocketIO

let manager = SocketManager(socketURL: URL(string: "http://3.136.56.91:8001")!, config: [.log(true), .compress])
var socket = manager.defaultSocket

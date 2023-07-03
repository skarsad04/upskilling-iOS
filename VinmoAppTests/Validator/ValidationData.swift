//
//  ValidationData.swift
//  VinmoAppTests
//
//  Created by asif hussain on 3/25/23.
//

import Foundation
class ValidationData {
    class func getTestUserName() -> [(userName: String, expecteResult: (Bool, String))] {
        [
            (userName: "asifHussain358@gmail.com", expecteResult: (true, "asifHussain358@gmail.com")),
            (userName: "asifHussain123@gmail.com", expecteResult: (true, "asifHussain123@gmail.com")),
            (userName: "Abcaxl@gmail.com", expecteResult: (true, "Abcaxl@gmail.com"))
        ]
    }
    
    class func getTestPassword() -> [(password: String, expecteResult: (Bool, String))] {
        [
            (password: "Asif@1234", expecteResult: (true, "Asif@1234")),
            (password: "Arhan@1234", expecteResult: (true, "Arhan@1234")),
            (password: "Abc121@123", expecteResult: (true, "Abc121@123"))
        ]
    }
    
    class func getTestEmail() -> [(email: String, expecteResult: (Bool, String))] {
        [
            (email: "asifHussain358@gmail.com", expecteResult: (true, "asifHussain358@gmail.com")),
            (email: "asifHussain123@gmail.com", expecteResult: (true, "asifHussain123@gmail.com")),
            (email: "Abcaxl@gmail.com", expecteResult: (true, "Abcaxl@gmail.com"))
        ]
    }
    
    class func getTestFirstName() -> [(firstName: String, expecteResult: (Bool, String))] {
        [
            (firstName: "AsifHussain", expecteResult: (true, "AsifHussain")),
            (firstName: "AmeenHussain", expecteResult: (true, "AmeenHussain")),
            (firstName: "DanishHussain", expecteResult: (true, "DanishHussain"))
        ]
    }
    
    class func getTestInputUser() -> [(user: String, expecteResult: Bool)] {
        [
            (user: "Hussain124", expecteResult: true),
            (user: "Ameen12345", expecteResult: true),
            (user: "Danish21212", expecteResult: true)
        ]
    }
}

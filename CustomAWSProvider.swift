//
//  CustomAWSProvider.swift
//  PracticaAWS
//
//  Created by Juan Antonio Martin Noguera on 20/10/2016.
//  Copyright © 2016 Cloud On Mobile. All rights reserved.
//

import Foundation

import AWSCognito
import AWSCore


class CustomAWSProvider: NSObject, AWSIdentityProviderManager{
    
    var tokens: NSDictionary
    init(tokens: [String:String]) {
        self.tokens = tokens as NSDictionary
    }
    
    @objc func logins() -> AWSTask<NSDictionary> {
        return AWSTask(result: tokens)
    }
}

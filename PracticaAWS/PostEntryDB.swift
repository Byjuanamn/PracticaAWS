//
//  PostEntryDB.swift
//  PracticaAWS
//
//  Created by Juan Antonio Martin Noguera on 20/10/2016.
//  Copyright © 2016 Cloud On Mobile. All rights reserved.
//

import AWSDynamoDB

class PostEntryDB: AWSDynamoDBObjectModel, AWSDynamoDBModeling {

    var postId: String?
    var titlePost: String?
    var position: [NSNumber]?
    var autor: String?
    var postText: String?
    
}

extension PostEntryDB {
    
    static func dynamoDBTableName() -> String {
        return "Posts"
    }
    
    static func hashKeyAttribute() -> String {
        return "postId"
    }
}

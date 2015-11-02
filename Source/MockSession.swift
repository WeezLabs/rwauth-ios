//
//  MockSession.swift
//  RWAuth
//
//  Created by Роман on 28.10.15.
//  Copyright © 2015 weezlabs. All rights reserved.
//

import Foundation

class MockSession: NSURLSession {
    var fakeRequest: FakeRequest?
    var fakeAnswer: FakeAnswer?
    
    func stubRequest(method: String, url: String, requestBody: [String: AnyObject], returnCode: Int, answerBody: [String: AnyObject]) -> Void {
        fakeRequest = FakeRequest(method: method, url: url, body: requestBody)
        fakeAnswer = FakeAnswer(code: returnCode, body: answerBody)
    }
    
    override class func sharedSession() -> NSURLSession {
        return MockSession()
    }
    
    override func uploadTaskWithRequest(request: NSURLRequest, fromData bodyData: NSData?,
        completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionUploadTask {
            
            let invalidTask = MockTask()  {(data, response, error) -> Void in
                completionHandler(nil, nil, error)
            }
            
            guard let fakeRequest = fakeRequest, fakeAnswer = fakeAnswer else { return invalidTask }
            guard let bodyData = bodyData else { return invalidTask }
            guard let bodyString = String(data: bodyData, encoding: NSUTF8StringEncoding) else { return invalidTask }
            guard let url = request.URL else { return invalidTask }
            guard url.absoluteString == fakeRequest.requestURL else { return invalidTask }
            
            guard let stubedBodyData = try? NSJSONSerialization.dataWithJSONObject(fakeRequest.requestBody, options: NSJSONWritingOptions(rawValue: 0)) else { return invalidTask }
            guard let stubedBodyString = String(data: stubedBodyData, encoding: NSUTF8StringEncoding) else { return invalidTask }
            
            guard bodyString == stubedBodyString else { return invalidTask }
            
            
            guard let responseData = try? NSJSONSerialization.dataWithJSONObject(fakeAnswer.answerBody, options: NSJSONWritingOptions(rawValue: 0)) else { return invalidTask }
            
            let urlResponse = NSHTTPURLResponse(URL: url, statusCode: fakeAnswer.answerCode, HTTPVersion: nil, headerFields: nil)
            
            return MockTask() { (data, response, error) -> Void in
                completionHandler(responseData, urlResponse, error)
            }
    }
}

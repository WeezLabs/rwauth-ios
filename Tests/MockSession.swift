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
            
            var error: NSError? = MockSessionError.UnrecognizedError.error
            let invalidTask = MockTask()  { () -> Void in
                completionHandler(nil, nil, error)
            }
            
            guard let fakeRequest = fakeRequest, fakeAnswer = fakeAnswer else {
                error = MockSessionError.FakeRequestOrFakeAnswerNotSetted.error
                return invalidTask
            }
            // FIXME: handle empty bodyData
            guard let bodyData = bodyData else {
                error = MockSessionError.EmptyBodyData.error
                return invalidTask
            }
            guard let bodyString = String(data: bodyData, encoding: NSUTF8StringEncoding) else {
                error = MockSessionError.BodyDataNotConvertableToString.error
                return invalidTask
            }
            guard request.HTTPMethod == fakeRequest.requestMethod else {
                error = MockSessionError.HTTPMethodsNotEqual.error
                return invalidTask
            }
            guard let url = request.URL else {
                error = MockSessionError.RequestDoesNotHaveURL.error
                return invalidTask
            }
            guard url.absoluteString == fakeRequest.requestURL else {
                error = MockSessionError.StubbedURLNotEqualRequestURL.error
                return invalidTask
            }
            
            guard let stubedBodyData = try? NSJSONSerialization.dataWithJSONObject(fakeRequest.requestBody,
                options: NSJSONWritingOptions(rawValue: 0)) else { return invalidTask }
            guard let stubedBodyString = String(data: stubedBodyData, encoding: NSUTF8StringEncoding) else { return invalidTask }
            
            guard bodyString == stubedBodyString else {
                error = MockSessionError.StubbedRequestBodyNotEqualRequestBody.error
                return invalidTask
            }
            
            guard let responseData = try? NSJSONSerialization.dataWithJSONObject(fakeAnswer.answerBody, options: NSJSONWritingOptions(rawValue: 0)) else { return invalidTask }
            
            let urlResponse = NSHTTPURLResponse(URL: url, statusCode: fakeAnswer.answerCode, HTTPVersion: nil, headerFields: nil)
            
            return MockTask() { () -> Void in
                completionHandler(responseData, urlResponse, nil)
            }
    }
}

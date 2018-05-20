//
//  Request+XML.swift
//  TheMovieApp
//
//  Created by Ayisha on 19/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import EVReflection
import SwiftyBeaver

/// For XML converting scalability
extension DataRequest {

    enum ErrorCode: Int {
        case noData, dataSerializationFailed
    }

    /**
     Adds a handler to be called once the request has finished.
     - parameter queue: The queue on which the completion handler is dispatched.
     - parameter keyPath: The key path where object mapping should be performed
     - parameter object: An object to perform the mapping on to
     - parameter completionHandler: A closure to be executed once the request has finished
     and the data has been mapped by ObjectMapper.
     - returns: The request.
     */
    @discardableResult
    func responseXMLToJsonObject<T: BaseMappable>(queue: DispatchQueue? = nil,
                                                  keyPath: String? = nil,
                                                  mapToObject object: T? = nil,
                                                  context: MapContext? = nil,
                                                  completionHandler: @escaping (DataResponse<T>)
        -> Void) -> Self {
        return response(queue: queue,
                        responseSerializer: DataRequest.objectMapperXMLSerializer(keyPath,
                                                                                  mapToObject: object,
                                                                                  context: context),
                        completionHandler: completionHandler)
    }

    /// BaseMappable Object Serializer
    private static func objectMapperXMLSerializer<T: BaseMappable>(_ keyPath: String?,
                                                                   mapToObject object: T? = nil,
                                                                   context: MapContext? = nil)
        -> DataResponseSerializer<T> {

        return DataResponseSerializer { request, response, data, error in
            if let error = checkXMLResponseForError(request: request, response: response, data: data, error: error) {
                return .failure(error)
            }

            if let data = data, let JSONObject = NSDictionary(xmlData: data) {
                Log.info(JSONObject)
                if let object = object {
                    _ = Mapper<T>(context: context, shouldIncludeNilValues: false)
                        .map(JSONObject: JSONObject,
                                                                                       toObject: object)
                    return .success(object)
                } else if let parsedObject = Mapper<T>(context: context, shouldIncludeNilValues: false)
                    .map(JSONObject: JSONObject) {
                    return .success(parsedObject)
                }
            }

            let failureReason = "ObjectMapper failed to serialize response."
            let error = newXMLError(.dataSerializationFailed, failureReason: failureReason)
            return .failure(error)
        }
    }

    /// Error Hanlding
    private static func newXMLError(_ code: ErrorCode, failureReason: String) -> NSError {
        let errorDomain = "com.alamofireobjectmapper.error"

        let userInfo = [NSLocalizedFailureReasonErrorKey: failureReason]
        let returnError = NSError(domain: errorDomain, code: code.rawValue, userInfo: userInfo)

        return returnError
    }

    /// Utility function for checking for errors in response
    private static func checkXMLResponseForError(request: URLRequest?,
                                                 response: HTTPURLResponse?,
                                                 data: Data?,
                                                 error: Error?) -> Error? {
        if let error = error {
            return error
        }
        guard data != nil else {
            let failureReason = "Data could not be serialized. Input data was nil."
            let error = newXMLError(.noData, failureReason: failureReason)
            return error
        }
        return nil
    }
}

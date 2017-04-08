//
//  FileManager.swift
//  SwiftFrameWork
//
//  Created by shenfh on 17/4/8.
//  Copyright © 2017年 shenfh. All rights reserved.
//

import Foundation

public extension FileManager {
    public static var document: URL {
        return self.default.document
    }
    
    public var document: URL {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    public static func createDirectory(at directoryURL: URL) throws {
        return try self.default.createDirectory(at: directoryURL)
    }
    
    public func createDirectory(at directoryUrl: URL) throws {
        let fileManager = FileManager.default
        var isDir: ObjCBool = false
        let fileExists = fileManager.fileExists(atPath: directoryUrl.path, isDirectory: &isDir)
        if fileExists == false || isDir.boolValue != false {
            try fileManager.createDirectory(at: directoryUrl, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    
    public static func deleteAllTemporaryFiles(at path: String) throws {
        return try self.default.deleteAllTemporaryFiles()
    }
    
    public func deleteAllTemporaryFiles() throws {
        let contents = try contentsOfDirectory(atPath: NSTemporaryDirectory())
        for file in contents {
            try removeItem(atPath: NSTemporaryDirectory() + file)
        }
    }
    
    public static func deleteAllDocumentFiles(at path: String) throws {
        return try self.default.deleteAllDocumentFiles()
    }
    
    public func deleteAllDocumentFiles() throws {
        let documentPath = document.path
        let contents = try contentsOfDirectory(atPath: documentPath)
        for file in contents {
            try removeItem(atPath: documentPath + file)
        }
    }
}

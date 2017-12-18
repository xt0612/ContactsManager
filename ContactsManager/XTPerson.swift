//
//  XTPerson.swift
//  ContactsManager
//
//  Created by xt on 2017/12/13.
//  Copyright © 2017年 xt. All rights reserved.
//

import  WCDB

enum SampleORMType: Int, ColumnCodable {
    case type1 = 1
    case type2 = 2
    typealias FundamentalType = Int64
    init?(with value: Int64) {
        self.init(rawValue: Int(truncatingIfNeeded: value))
    }
    func archivedValue() -> Int64? {
        return Int64(rawValue)
    }
}

class XTPerson: TableCodable {
    var identifier: Int = 0
    var desc: String = "nil"
    var value: Double = 0
    var timestamp: String?
    var type: SampleORMType?
    enum CodingKeys: String, CodingTableKey {
        typealias Root = XTPerson
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case identifier
        case desc
        case value
        case timestamp
        case type
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                .identifier: ColumnConstraintBinding(isPrimary: true),
                .value: ColumnConstraintBinding(defaultTo: 1.0),
                .timestamp: ColumnConstraintBinding(defaultTo: .currentTimestamp)
            ]
        }
    }
    required init() {}
}

//
//  ListUpdate.swift
//  HeckelDiff
//
//  Created by Matias Cudich on 11/23/16.
//  Copyright © 2016 Matias Cudich. All rights reserved.
//

import Foundation

public struct ListUpdate {
  public var deletions = [IndexPath]()
  public var insertions = [IndexPath]()
  public var updates = [(old: IndexPath, new: IndexPath)]()
  public var moves = [(from: IndexPath, to: IndexPath)]()

  public init(_ result: [Operation], _ section: Int) {
    for step in result {
      switch step {
      case .delete(let index):
        deletions.append(IndexPath(row: index, section: section))
      case .insert(let index):
        insertions.append(IndexPath(row: index, section: section))
      case let .update(oldIndex, newIndex):
        updates.append((old: IndexPath(row: oldIndex, section: section), new: IndexPath(row: newIndex, section: section)))
      case let .move(fromIndex, toIndex):
        moves.append((from: IndexPath(row: fromIndex, section: section), to: IndexPath(row: toIndex, section: section)))
      }
    }
  }

  public func dumpUpdate() {
    NSLog("LIVEJAM: Dumping update")
    NSLog("LIVEJAM:   deletes:")
    for delete in deletions {
      NSLog("LIVEJAM:     - \(delete.item)")
    }
    NSLog("LIVEJAM:   insertions:")
    for insert in insertions {
      NSLog("LIVEJAM:     + \(insert.item)")
    }
    NSLog("LIVEJAM:   updates:")
    for update in updates {
      NSLog("LIVEJAM:     ~ oldIndex: \(update.old.item), newIndex: \(update.new.item)")
    }
    NSLog("LIVEJAM:   move:")
    for move in moves {
      NSLog("LIVEJAM:     . fromIndex: \(move.from.item), newIndex: \(move.to.item)")
    }
  }
}

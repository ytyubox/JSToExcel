//
//  File.swift
//  
//
//  Created by 游宗諭 on 2020/1/14.
//

import Files
import Foundation

let argv = CommandLine.arguments
guard argv.count > 1 else {
	print("miss file name")
	exit(1)
}
let fileName = argv[1]
let folder = Folder.current
let json = try! folder.file(named: fileName).read()

func get(folder: Folder, json:Data) throws {
	func t(_ list: String...) -> String { list.joined(separator: "\t") + "\n" }
	func h(_ list: [String]) -> String { list.joined(separator: "\t") + "\n" }
	let map = try JSONDecoder().decode([String:[String:String]].self, from: json)
	let lans = map.keys.sorted()
	var context = h(["key"]+lans)
	var rowCollection:[String: [String]] = [:]
	for lan in lans {
		let table = map[lan]!
		for (k, v) in table {
			switch rowCollection[k] != nil {
			case true : rowCollection[k]! += [v]
			case false: rowCollection[k] = [v]
			}
//			context += t(k,v)
		}
	}
	let sortedResult = rowCollection.sorted { (p1, p2) -> Bool in
		p1.key < p2.key
	}
	for (k, array) in sortedResult {
		context += h([k] + array)
	}
	let file = try folder.createFileIfNeeded(withName: "result.tsv")
	try file.write(context)
}
try! get(folder: folder, json: json)

print("complete!")

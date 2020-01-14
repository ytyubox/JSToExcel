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
	for (lan, table) in map {
		var context = t("key","value")
		for (k, v) in table {
			context += t(k,v)
		}
		let file = try folder.createFileIfNeeded(withName: "\(lan).tsv")
		try file.write(context)
	}
}
try! get(folder: folder, json: json)

print("complete!")

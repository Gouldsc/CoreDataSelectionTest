//
//  GroupDescriptionButton.swift
//  GroupDescriptionButton
//
//  Created by Scott Gould on 9/9/21.
//

import SwiftUI
import CoreData

struct GroupDescriptionButton: View
{
	@Binding var group: Group?
	
	var body: some View
	{
		Button
		{
			print( group?.name ?? "no entity" )
		}
	label:
		{
			Label( "Console print \(group?.name ?? "no entity")", systemImage: "swift" )
		}
		.keyboardShortcut( "Y", modifiers: [.command] )
		.disabled( group == nil )
	}
}

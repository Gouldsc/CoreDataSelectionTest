//
//  EntityCDescriptionButton.swift
//  EntityCDescriptionButton
//
//  Created by Scott Gould on 9/9/21.
//

import SwiftUI
import CoreData

struct EntityCDescriptionButton: View
{
	@Binding var entityC: EntityC?
	
	var body: some View
	{
		Button
		{
			print( entityC?.name ?? "no entity" )
		}
		label:
		{
			Label( "Console print \(entityC?.name ?? "no entity")", systemImage: "swift" )
		}
		.keyboardShortcut( "D", modifiers: [.command, .shift] )
		.disabled( entityC == nil )
	}
}

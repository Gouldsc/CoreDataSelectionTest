//
//  SelectionDescriptionButton.swift
//  SelectionDescriptionButton
//
//  Created by Scott Gould on 9/9/21.
//

import SwiftUI
import CoreData

struct SelectionDescriptionButton: View
{
	@Binding var selection: Selection.ID??
	private var selectedEntity: SelectableObject?
	{
		get
		{
			guard let rSelection = self.selection.flatMap( {$0} ),
				  let tNSManagedObject = PersistenceController.shared.managedObjectFor( urlString: rSelection ),
				  let rEntity = tNSManagedObject as? SelectableObject
			else
			{
				return nil
			}
			return rEntity
		}
		set
		{
			guard let tEntityId = newValue
			else
			{
				return
			}
			self.selection = tEntityId.id
		}
	}
	
	var body: some View
	{
		Button
		{
			print( selectedEntity?.name ?? "no entity" )
		}
	label:
		{
			Label( "Console print selected item: \(selectedEntity?.name ?? "no entity")", systemImage: "terminal" )
		}
		.keyboardShortcut( "S", modifiers: [.command, .shift] )
		.disabled( selectedEntity == nil )
	}
}

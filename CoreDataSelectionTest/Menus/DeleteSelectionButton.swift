//
//  DeleteSelectionButton.swift
//  DeleteSelectionButton
//
//  Created by Scott Gould on 9/9/21.
//

import SwiftUI
import CoreData

struct DeleteSelectionButton: View
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
	
	@State var isPresentingDeleteConfirmationDialogue = false
	
	var body: some View
	{
		Button
		{
			deleteSelection()
		}
	label:
		{
			Label( "Delete \(selectedEntity?.name ?? "no entity")", systemImage: "minus" )
		}
		.keyboardShortcut( .delete, modifiers: [.command] )
		.disabled( selectedEntity == nil )
	}
	
	func deleteSelection()
	{
		guard let tSelectedEntity = selectedEntity,
			  let tManagedObjectContext = tSelectedEntity.managedObjectContext
		else
		{
			return
		}
		tManagedObjectContext.delete( tSelectedEntity )
		
		selection = nil
		PersistenceController.shared.save()
	}
}

//
//  EntityCSourceListRowView.swift
//  EntityCSourceListRowView
//
//  Created by Scott Gould on 9/2/21.
//

import SwiftUI

struct EntityCSourceListRowView: View
{
	@ObservedObject var entityC: EntityC
	@FocusState var isEditing: Bool
	@State var isToggled: Bool
	@State var isHovering = false
	@State var isPresentingDeleteConfirmationDialogue = false
	@State var detailViewIsActive = true

	var body: some View
	{
		HStack
		{
			Image( systemName: "allergens" )
				.foregroundColor( .primary )
			nameField
			Spacer()
			actionButton
			toggleButton
		}
		.onHover( perform: { tIsHovering in isHovering = tIsHovering } )
		.confirmationDialog( "Are you sure you want to permanently delete \( entityC.name )? This action cannot be undone.",
				isPresented: $isPresentingDeleteConfirmationDialogue,
					actions:
					{
						Button( role: .cancel ){}
						label:
					{
						Label( "Cancel", systemImage: "circle" )
					}
					.keyboardShortcut( .return )	//	FIXME: Figure out why return key doesn't seem to trigger "cancel"
					
					Button( role: .destructive )
					{
						deleteItem()
					}
					label:
					{
						Label( "Delete \(entityC.name)", systemImage: "circle" )
					}
		} )
	}

	private var nameField: some View
	{
		NavigationLink( isActive: $detailViewIsActive,
						destination: { EntityCDetailView( entityC: entityC ) },
						label:
		{
			TextField( "\($entityC.name)", text: $entityC.name )
			{
				isEditing in
				self.isEditing = isEditing
			}
		onCommit:
			{
				updatePersistentStore()
			}
			.focused( $isEditing )
			.textFieldStyle( .plain )
		} )
	}

	private var actionButton: some View
	{
		Image( systemName: "ellipsis.circle" )
			.foregroundColor( .accentColor )
			.opacity( isHovering ? 1 : 0 )
			.contextMenu
		{
			menuItems
		}
	}

	private var toggleButton: some View
	{
		Toggle( "title", isOn: $isToggled )
			.onChange( of: self.isToggled, perform:
						{
				updateIsActivatedStatus( to: $0 )
			} )
			.labelsHidden()
	}

	@ViewBuilder private var menuItems: some View
	{
		Button
		{
			isEditing = true
			//	FIXME: Need to add focus apis to the textfield and shift focus to it here.
		}
		label:
		{
			Label( "Rename", systemImage: "circle" )
		}
		
		Button
		{
			isPresentingDeleteConfirmationDialogue = true
		}
		label:
		{
			Label( "Delete \(entityC.name)", systemImage: "circle" )
		}
	}

	private func updateIsActivatedStatus( to: Bool )
	{
		entityC.isActivated = isToggled
		updatePersistentStore()
	}

	private func updatePersistentStore()
	{
		PersistenceController.shared.save()
	}

	private func deleteItem()
	{
		guard let tManagedObjectContext = entityC.managedObjectContext
		else
		{
			return
		}
		detailViewIsActive = false
		tManagedObjectContext.delete( entityC )
		
		DispatchQueue.main.asyncAfter(deadline: .now() )
		{
			PersistenceController.shared.save()
			
		}	}
}

Class {
	#name : #EgRemoveContactCommand,
	#superclass : #EgContactBookCommand,
	#category : #EgContactBook
}

{ #category : #initialization }
EgRemoveContactCommand >> asSpecCommand [

	^ super asSpecCommand
		  iconName: #removeIcon;
		  shortcutKey: $x meta;
		  yourself
]

{ #category : #initialization }
EgRemoveContactCommand >> canBeExecuted [

	^ self context isContactSelected
]

{ #category : #executing }
EgRemoveContactCommand >> execute [

	self contactBook removeContact: self selectedContact.
	self contactBookPresenter updateView
]

{ #category : #initialization }
EgRemoveContactCommand >> initialize [

	super initialize.
	self
		name: 'Remove';
		description: 'Removes the selected contact from the contact
book.'
]

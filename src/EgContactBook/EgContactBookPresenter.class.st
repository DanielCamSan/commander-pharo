Class {
	#name : #EgContactBookPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'table',
		'contactBook'
	],
	#category : #EgContactBook
}

{ #category : #layout }
EgContactBookPresenter class >> buildAddingGroupWith: presenter [

	^ (CmCommandGroup named: 'Adding') asSpecGroup
		  description: 'Commands related to contact addition.';
		  register: (EgAddContactCommand forSpec context: presenter);
		  beDisplayedAsGroup;
		  yourself
]

{ #category : #layout }
EgContactBookPresenter class >> buildCommandsGroupWith: presenter forRoot: rootCommandGroup [

	rootCommandGroup register:
		(self buildContextualMenuGroupWith: presenter)
]

{ #category : #layout }
EgContactBookPresenter class >> buildContextualMenuGroupWith: presenter [

	^ (CmCommandGroup named: 'Context Menu') asSpecGroup
		  register: (self buildAddingGroupWith: presenter);
		  register: (self buildRemovingGroupWith: presenter);
		  yourself
]

{ #category : #layout }
EgContactBookPresenter class >> buildRemovingGroupWith: presenter [

	^ (CmCommandGroup named: 'Removing') asSpecGroup
		  description: 'Commands related to contact removal.';
		  register: (EgRemoveContactCommand forSpec context: presenter);
		  beDisplayedAsGroup;
		  yourself
]

{ #category : #layout }
EgContactBookPresenter class >> changePhoneCommandWith: presenter forRootGroup: aRootCommandsGroup [

	<extensionCommands>
	aRootCommandsGroup / 'Context Menu' register:
		(EgChangePhoneCommand forSpec context: presenter)
]

{ #category : #layout }
EgContactBookPresenter class >> coworkersExample [

	<example>

 	^ (self on: EgContactBook coworkers) open 
]

{ #category : #layout }
EgContactBookPresenter class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: #table;
		  yourself
]

{ #category : #accessing }
EgContactBookPresenter >> contactBook [

	^ contactBook
]

{ #category : #accessing }
EgContactBookPresenter >> contactBook: anObject [

	contactBook := anObject
]

{ #category : #accessing }
EgContactBookPresenter >> initializePresenters [

	table := self newTable.
	table
		addColumn: (SpStringTableColumn title: 'Name' evaluated: #name);
		addColumn: (SpStringTableColumn title: 'Phone' evaluated: #phone).
	table contextMenu: [ self rootCommandsGroup  beRoot asMenuPresenter ].
	table items: contactBook contents
]

{ #category : #accessing }
EgContactBookPresenter >> isContactSelected [

	^ self table selectedItems isNotEmpty
]

{ #category : #accessing }
EgContactBookPresenter >> newContact [

	| rawData splitted |
	rawData := self
		           request:
		           'Enter new contact name and phone (split by comma)'
		           initialAnswer: ''
		           title: 'Create new contact'.
	splitted := rawData splitOn: $,.
	(splitted size = 2 and: [ splitted allSatisfy: #isNotEmpty ]) 
		ifFalse: [ 
			SpInvalidUserInput signal: 'Please enter contact name
and phone (split by comma)' ].
	^ EgContact new
		  name: splitted first;
		  phone: splitted second;
		  yourself
]

{ #category : #'instance creation' }
EgContactBookPresenter >> newPhone [

	| phone |
	phone := self
		         request: 'New phone for the contact'
		         initialAnswer: self selectedContact phone
		         title: 'Set new phone for contact'.
	(phone matchesRegex: '\d\d\d\s\d\d\d') ifFalse: [ 
		SpInvalidUserInput signal: 'The phone number is not well
formated.
Should match "\d\d\d\s\d\d\d"' ].
	^ phone
]

{ #category : #accessing }
EgContactBookPresenter >> selectedContact [

	^ table selection selectedItem
]

{ #category : #accessing }
EgContactBookPresenter >> setModelBeforeInitialization: aContactBook [

	super setModelBeforeInitialization: aContactBook.
	contactBook := aContactBook
]

{ #category : #accessing }
EgContactBookPresenter >> table [

	^ table
]

{ #category : #accessing }
EgContactBookPresenter >> table: anObject [

	table := anObject
]

{ #category : #accessing }
EgContactBookPresenter >> updateView [

	table items: contactBook contacts
]

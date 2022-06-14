Class {
	#name : #EgContactCommandTest,
	#superclass : #TestCase,
	#category : #EgContactBook
}

{ #category : #tests }
EgContactCommandTest >> testRemoveContact [

	| presenter |
	presenter := EgContactBookPresenter on: EgContactBook coworkers.
	self assert: presenter contactBook size equals: 4.
	presenter table selectIndex: 1.
	(EgRemoveContactCommand new context: presenter) execute.
	self assert: presenter contactBook size equals: 3
]

part of coUquestmaker;

/// Button displayed in the rock window during a [Quest] [Conversation]
class Choice implements QuestData, QuestDisplay {
	/// Button text
	String text = '';

	/// Go to a certain [Conversation] [Screen]
	int gotoScreen = 0;

	/// If this is true, clicking the button will accept the quest
	bool isQuestAccept = false;

	Choice();

	Choice.fromMap(Map<String, dynamic> choice) {
		text = choice['text'];
		gotoScreen = choice['gotoScreen'];
		isQuestAccept = choice['isQuestAccept'] ?? false;
	}

	Map<String, dynamic> toMap() => {
		'text': text,
		'gotoScreen': gotoScreen,
		'isQuestAccept': isQuestAccept
	};

	Choice.fromElement(Element element) {
		text = (element.querySelector('[name="text"]') as TextInputElement).value;

		try {
			gotoScreen = (element.querySelector('[name="gotoScreen"]') as NumberInputElement).valueAsNumber;
		} catch (_) {}

		isQuestAccept = (element.querySelector('[name="isQuestAccept"]') as CheckboxInputElement).checked ?? false;
	}

	Element toElement() => new FieldSetElement()
		..classes = ['choice']
		..append(new LegendElement()
			..text = 'Choice')

		..append(new TextInputElement()
			..name = 'text'
			..placeholder = 'Text'
			..value = text)

		..append(new LabelElement()
			..appendText('Go to screen')
			..append(new NumberInputElement()
				..name = 'gotoScreen'
				..min = '0'
				..value = gotoScreen.toString()))

		..append(new LabelElement()
			..appendText('Accepts quest?')
			..append(new CheckboxInputElement()
				..name = 'isQuestAccept'
				..checked = isQuestAccept));
}